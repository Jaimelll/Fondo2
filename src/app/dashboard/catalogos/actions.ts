"use server";

// ─────────────────────────────────────────────────────────────────────────────
// Server actions del módulo Catálogos.
//
// Lectura: super admin + usuarios con el módulo 'Catálogos' (solo lectura).
// Escritura: EXCLUSIVA del super admin (jduran). Cada acción revalida la
// identidad del usuario vía la sesión (defensa en profundidad: no confiamos
// solo en el proxy). Capa de datos: Postgres directo; la introspección de
// columnas se hace contra information_schema (reemplaza al RPC
// catalogo_columnas). Los PDFs (columnas archivo_url) van al storage local
// (STORAGE_DOCUMENTS_PATH), no a un bucket de Supabase.
// ─────────────────────────────────────────────────────────────────────────────

import { promises as fs } from 'fs';
import path from 'path';
import { revalidatePath, revalidateTag } from 'next/cache';
import { query } from '@/lib/db';
import { getSession } from '@/lib/session';
import { getModulosUsuario } from '@/lib/permisos';
import { getNormalizedEmail, SUPER_ADMIN, puedeVerCatalogos } from '@/config/permissions';
import { esTablaValida, COLUMNAS_COMBO, type Columna } from './tablas';

// Tag de los catálogos cacheados con unstable_cache en src/app/dashboard/actions.ts
// (líneas, ejes, etapas, regiones, especialistas, etc. — TTL 1 hora). Toda
// escritura desde este módulo DEBE invalidarlo, o el resto de la app seguirá
// sirviendo la lista vieja hasta por una hora.
const CATALOG_TAG = 'catalogos';

function invalidarCatalogos(tabla: string) {
    revalidateTag(CATALOG_TAG, 'max'); // Next 16 exige el 2º arg; 'max' = invalidación total
    revalidatePath(`/dashboard/catalogos/${tabla}`);
    revalidatePath('/dashboard/catalogos');
}

/** Lanza si el usuario actual no es el super admin (guarda de ESCRITURA). */
async function assertSuperAdmin() {
    const session = await getSession();
    if (getNormalizedEmail(session?.user.email) !== SUPER_ADMIN) {
        throw new Error('No autorizado: solo el super admin puede modificar catálogos.');
    }
}

/** Lanza si el usuario no puede VER catálogos (super admin o módulo asignado). */
async function assertPuedeVer() {
    const session = await getSession();
    const email = session?.user.email;
    const modulos = await getModulosUsuario(email);
    if (!puedeVerCatalogos(email, modulos)) {
        throw new Error('No autorizado para ver los catálogos.');
    }
}

function assertTabla(tabla: string) {
    if (!esTablaValida(tabla)) {
        throw new Error(`Tabla no permitida: "${tabla}".`);
    }
}

/** Valida un identificador (columna) dinámico antes de interpolarlo entre comillas. */
function ident(name: string): string {
    if (!/^[\p{L}_][\p{L}\p{N}_]*$/u.test(name)) {
        throw new Error(`Identificador no válido: "${name}"`);
    }
    return `"${name}"`;
}

// ─── Introspección de columnas ─────────────────────────────────────────────────

/**
 * Descubre las columnas de una tabla vía information_schema: tipos reales,
 * PK real, defaults (incluye columnas identity).
 */
export async function getColumnas(tabla: string): Promise<Columna[]> {
    await assertPuedeVer();
    assertTabla(tabla);

    const { rows } = await query(
        `select c.column_name,
                c.data_type,
                (c.is_nullable = 'YES') as is_nullable,
                (c.column_default is not null or c.is_identity = 'YES') as has_default,
                coalesce(pk.is_pk, false) as is_pk
           from information_schema.columns c
           left join (
                select kcu.column_name, true as is_pk
                  from information_schema.table_constraints tc
                  join information_schema.key_column_usage kcu
                    on kcu.constraint_name = tc.constraint_name
                   and kcu.table_schema = tc.table_schema
                 where tc.table_schema = 'public'
                   and tc.table_name = $1
                   and tc.constraint_type = 'PRIMARY KEY'
           ) pk on pk.column_name = c.column_name
          where c.table_schema = 'public' and c.table_name = $1
          order by c.ordinal_position`,
        [tabla],
    );

    return rows.map((c: any) => ({
        name: c.column_name as string,
        type: c.data_type as string,
        isPk: Boolean(c.is_pk),
        nullable: Boolean(c.is_nullable),
        hasDefault: Boolean(c.has_default),
    }));
}

// ─── Lectura de filas ──────────────────────────────────────────────────────────

/** 'YYYY-MM-DD' local (paridad con PostgREST para columnas date). */
function formatFecha(d: Date): string {
    const p = (n: number) => String(n).padStart(2, '0');
    return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}

export async function getFilas(tabla: string): Promise<Record<string, any>[]> {
    await assertPuedeVer();
    assertTabla(tabla);
    const { rows } = await query(`select * from ${ident(tabla)}`);
    // pg devuelve date/timestamp como Date; el editor espera strings.
    return rows.map((r) => {
        const out: Record<string, any> = {};
        for (const [k, v] of Object.entries(r)) {
            out[k] = v instanceof Date ? formatFecha(v) : v;
        }
        return out;
    });
}

export async function getConteo(tabla: string): Promise<number> {
    await assertPuedeVer();
    assertTabla(tabla);
    try {
        const { rows } = await query(`select count(*)::int as count from ${ident(tabla)}`);
        return rows[0]?.count ?? 0;
    } catch {
        return 0;
    }
}

// ─── Opciones para columnas combo (FK) ─────────────────────────────────────────

export type OpcionesCombo = Record<string, { libre: boolean; opciones: { value: any; label: string }[] }>;

/**
 * Devuelve las opciones de cada columna combo de la tabla (config en
 * COLUMNAS_COMBO): estáticas (p. ej. meses) o leídas de un catálogo. El
 * editor las muestra como <select>, o como input con sugerencias si `libre`.
 */
export async function getOpcionesCombo(tabla: string): Promise<OpcionesCombo> {
    await assertPuedeVer();
    assertTabla(tabla);
    const config = COLUMNAS_COMBO[tabla];
    if (!config) return {};
    const out: OpcionesCombo = {};
    for (const [col, ref] of Object.entries(config)) {
        if (ref.estatico) {
            out[col] = { libre: Boolean(ref.libre), opciones: ref.estatico };
            continue;
        }
        if (!ref.tabla || !ref.valor || !ref.etiqueta) continue;
        const cols = [ref.valor, ref.etiqueta, ...(ref.etiquetaExtra ? [ref.etiquetaExtra] : [])];
        let data: any[] = [];
        try {
            let sql = `select ${[...new Set(cols)].map(ident).join(', ')} from ${ident(ref.tabla)}`;
            const params: unknown[] = [];
            if (ref.filtro) {
                sql += ` where ${ident(String(ref.filtro[0]))} = $1`;
                params.push(ref.filtro[1]);
            }
            sql += ` order by ${ident(ref.etiqueta)} asc`;
            const result = await query(sql, params);
            data = result.rows;
        } catch (err: any) {
            console.error(`Error cargando opciones de ${tabla}.${col}:`, err.message);
            out[col] = { libre: Boolean(ref.libre), opciones: [] };
            continue;
        }
        const opciones = data.map((r: any) => {
            const principal = String(r[ref.etiqueta!] ?? r[ref.valor!]).trim();
            const extra = ref.etiquetaExtra ? String(r[ref.etiquetaExtra] ?? '').trim() : '';
            return {
                value: r[ref.valor!],
                label: extra && extra !== principal ? `${principal} — ${extra}` : principal,
            };
        });
        // Dedupe: necesario cuando las opciones salen de una columna con valores
        // repetidos (p. ej. banco de saldo_bancario).
        const vistos = new Set<string>();
        out[col] = {
            libre: Boolean(ref.libre),
            opciones: opciones.filter((o) => {
                const k = String(o.value);
                if (vistos.has(k)) return false;
                vistos.add(k);
                return true;
            }),
        };
    }
    return out;
}

// ─── Coerción de valores del formulario ────────────────────────────────────────

function esNumerico(type: string) {
    return /int|numeric|double|real|decimal|float|serial/i.test(type);
}
function esBooleano(type: string) {
    return /bool/i.test(type);
}

/** Limpia un payload según el tipo de cada columna (""→null, "5"→5, etc.). */
function coerce(
    valores: Record<string, any>,
    columnas: Columna[],
): Record<string, any> {
    const byName = new Map(columnas.map((c) => [c.name, c]));
    const out: Record<string, any> = {};
    for (const [k, raw] of Object.entries(valores)) {
        const col = byName.get(k);
        if (!col) continue; // ignora columnas desconocidas (anti-inyección)
        if (esBooleano(col.type)) {
            out[k] = Boolean(raw);
            continue;
        }
        const s = raw === null || raw === undefined ? '' : String(raw).trim();
        if (s === '') {
            out[k] = null;
            continue;
        }
        if (esNumerico(col.type)) {
            const n = Number(s);
            out[k] = Number.isFinite(n) ? n : null;
            continue;
        }
        out[k] = s;
    }
    return out;
}

// ─── Escritura (CRUD) ──────────────────────────────────────────────────────────

export async function crearFila(
    tabla: string,
    valores: Record<string, any>,
): Promise<{ ok: boolean; error?: string }> {
    await assertSuperAdmin();
    assertTabla(tabla);
    const columnas = await getColumnas(tabla);
    // Al crear, ignoramos columnas con default si vienen vacías.
    const payload = coerce(valores, columnas);
    for (const c of columnas) {
        if (c.hasDefault && (payload[c.name] === null || payload[c.name] === undefined)) {
            delete payload[c.name];
        }
        // PK vacía: dejar que la genere la BD (columnas identity reportan
        // has_default=false en information_schema, p.ej. informe_impacto.id).
        if (c.isPk && (payload[c.name] === null || payload[c.name] === undefined)) {
            delete payload[c.name];
        }
    }
    try {
        const cols = Object.keys(payload);
        const values = cols.map((c) => payload[c]);
        const placeholders = cols.map((_, i) => `$${i + 1}`);
        await query(
            `insert into ${ident(tabla)} (${cols.map(ident).join(', ')}) values (${placeholders.join(', ')})`,
            values,
        );
    } catch (err: any) {
        return { ok: false, error: err.message };
    }
    invalidarCatalogos(tabla);
    return { ok: true };
}

// ─── Storage local de PDFs (columnas archivo_url) ──────────────────────────────

// Mismo directorio y ruta protegida que el módulo Documentos Corporativos:
// los archivos viven en STORAGE_DOCUMENTS_PATH y se sirven vía
// GET /api/documentos/[archivo] (el proxy de auth exige sesión).
const STORAGE_DIR = path.resolve(
    process.cwd(),
    process.env.STORAGE_DOCUMENTS_PATH || './storage/documentos',
);
const URL_ARCHIVOS_PREFIX = '/api/documentos/';

/** Nombre de archivo local si la URL apunta a nuestro storage; null si es externa. */
function extraerNombreLocal(url: string | null | undefined): string | null {
    if (!url || !url.startsWith(URL_ARCHIVOS_PREFIX)) return null;
    const nombre = path.basename(decodeURIComponent(url.slice(URL_ARCHIVOS_PREFIX.length)));
    return nombre || null;
}

/**
 * Borra del disco el PDF de `url` SOLO si ninguna fila de la tabla lo sigue
 * usando (un mismo informe puede estar vinculado a varios grupos = varias
 * filas con la misma URL). Silencioso ante errores: el borrado de la fila ya
 * ocurrió y no debe revertirse por un problema de limpieza.
 */
async function limpiarArchivoSiHuerfano(tabla: string, url: string | null | undefined) {
    const nombre = extraerNombreLocal(url);
    if (!nombre) return; // URL externa (p. ej. Storage de Supabase antiguo): no tocar
    try {
        const { rows } = await query(
            `select count(*)::int as count from ${ident(tabla)} where archivo_url = $1`,
            [url],
        );
        if ((rows[0]?.count ?? 0) > 0) return; // otra fila aún lo usa
        await fs.unlink(path.join(STORAGE_DIR, nombre));
    } catch (e: any) {
        console.warn('Limpieza de archivo huérfano falló:', e.message);
    }
}

export async function actualizarFila(
    tabla: string,
    pkCol: string,
    pkVal: string | number,
    valores: Record<string, any>,
): Promise<{ ok: boolean; error?: string }> {
    await assertSuperAdmin();
    assertTabla(tabla);
    const columnas = await getColumnas(tabla);
    const payload = coerce(valores, columnas);
    delete payload[pkCol]; // nunca actualizamos la PK

    try {
        // Si se reemplaza archivo_url, recordar el anterior para limpiar el huérfano.
        let urlAnterior: string | null = null;
        if ('archivo_url' in payload) {
            const { rows } = await query(
                `select archivo_url from ${ident(tabla)} where ${ident(pkCol)} = $1`,
                [pkVal],
            );
            urlAnterior = rows[0]?.archivo_url ?? null;
        }

        const cols = Object.keys(payload);
        const values = cols.map((c) => payload[c]);
        const assignments = cols.map((c, i) => `${ident(c)} = $${i + 1}`);
        await query(
            `update ${ident(tabla)} set ${assignments.join(', ')} where ${ident(pkCol)} = $${cols.length + 1}`,
            [...values, pkVal],
        );

        if (urlAnterior && urlAnterior !== payload['archivo_url']) {
            await limpiarArchivoSiHuerfano(tabla, urlAnterior);
        }
    } catch (err: any) {
        return { ok: false, error: err.message };
    }
    invalidarCatalogos(tabla);
    return { ok: true };
}

function sanitizeFileName(fileName: string): string {
    return fileName
        .normalize('NFD')
        .replace(/[̀-ͯ]/g, '')
        .replace(/[^a-zA-Z0-9._-]/g, '_')
        .toLowerCase();
}

/**
 * Guarda un PDF en el storage local y devuelve su URL servida por
 * /api/documentos. Lo usa el editor de catálogos para llenar columnas
 * `archivo_url`.
 */
export async function subirArchivoCatalogo(
    formData: FormData,
): Promise<{ ok: boolean; url?: string; error?: string }> {
    await assertSuperAdmin();
    const file = formData.get('archivo') as File | null;
    if (!file || file.size === 0) {
        return { ok: false, error: 'Debe seleccionar un archivo PDF.' };
    }
    if (file.size > 20 * 1024 * 1024) {
        return { ok: false, error: 'El archivo excede el límite de 20 MB.' };
    }
    try {
        const fileName = `${Date.now()}_${sanitizeFileName(file.name)}`;
        await fs.mkdir(STORAGE_DIR, { recursive: true });
        const buffer = Buffer.from(await file.arrayBuffer());
        await fs.writeFile(path.join(STORAGE_DIR, fileName), buffer);
        return { ok: true, url: `${URL_ARCHIVOS_PREFIX}${encodeURIComponent(fileName)}` };
    } catch (err: any) {
        return { ok: false, error: err.message };
    }
}

export async function eliminarFila(
    tabla: string,
    pkCol: string,
    pkVal: string | number,
): Promise<{ ok: boolean; error?: string }> {
    await assertSuperAdmin();
    assertTabla(tabla);

    // Capturar el archivo_url antes de borrar (si la tabla tiene esa columna)
    // para eliminar también el PDF local cuando quede huérfano.
    let urlArchivo: string | null = null;
    try {
        const { rows } = await query(
            `select archivo_url from ${ident(tabla)} where ${ident(pkCol)} = $1`,
            [pkVal],
        );
        urlArchivo = rows[0]?.archivo_url ?? null;
    } catch { /* la tabla no tiene archivo_url: nada que limpiar */ }

    try {
        await query(`delete from ${ident(tabla)} where ${ident(pkCol)} = $1`, [pkVal]);
    } catch (err: any) {
        const msg = /foreign key|violates/i.test(err.message)
            ? 'No se puede eliminar: el elemento está en uso por otros registros.'
            : err.message;
        return { ok: false, error: msg };
    }

    if (urlArchivo) await limpiarArchivoSiHuerfano(tabla, urlArchivo);

    invalidarCatalogos(tabla);
    return { ok: true };
}
