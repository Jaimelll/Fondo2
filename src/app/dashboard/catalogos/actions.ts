"use server";

// ─────────────────────────────────────────────────────────────────────────────
// Server actions del módulo Catálogos.
//
// Acceso EXCLUSIVO del super admin (jduran). Cada acción revalida la identidad
// del usuario vía la sesión (defensa en profundidad: no confiamos solo en el
// proxy). Capa de datos: Postgres directo; la introspección de columnas se
// hace contra information_schema (reemplaza al RPC catalogo_columnas).
// ─────────────────────────────────────────────────────────────────────────────

import { revalidatePath } from 'next/cache';
import { query } from '@/lib/db';
import { getSession } from '@/lib/session';
import { getNormalizedEmail, SUPER_ADMIN } from '@/config/permissions';
import { esTablaValida, type Columna } from './tablas';

/** Lanza si el usuario actual no es el super admin. */
async function assertSuperAdmin() {
    const session = await getSession();
    if (getNormalizedEmail(session?.user.email) !== SUPER_ADMIN) {
        throw new Error('No autorizado: este módulo es solo para el super admin.');
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
    await assertSuperAdmin();
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

export async function getFilas(tabla: string): Promise<Record<string, any>[]> {
    await assertSuperAdmin();
    assertTabla(tabla);
    const { rows } = await query(`select * from ${ident(tabla)}`);
    return rows;
}

export async function getConteo(tabla: string): Promise<number> {
    await assertSuperAdmin();
    assertTabla(tabla);
    try {
        const { rows } = await query(`select count(*)::int as count from ${ident(tabla)}`);
        return rows[0]?.count ?? 0;
    } catch {
        return 0;
    }
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
    revalidatePath(`/dashboard/catalogos/${tabla}`);
    revalidatePath('/dashboard/catalogos');
    return { ok: true };
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
        const cols = Object.keys(payload);
        const values = cols.map((c) => payload[c]);
        const assignments = cols.map((c, i) => `${ident(c)} = $${i + 1}`);
        await query(
            `update ${ident(tabla)} set ${assignments.join(', ')} where ${ident(pkCol)} = $${cols.length + 1}`,
            [...values, pkVal],
        );
    } catch (err: any) {
        return { ok: false, error: err.message };
    }
    revalidatePath(`/dashboard/catalogos/${tabla}`);
    return { ok: true };
}

export async function eliminarFila(
    tabla: string,
    pkCol: string,
    pkVal: string | number,
): Promise<{ ok: boolean; error?: string }> {
    await assertSuperAdmin();
    assertTabla(tabla);
    try {
        await query(`delete from ${ident(tabla)} where ${ident(pkCol)} = $1`, [pkVal]);
    } catch (err: any) {
        const msg = /foreign key|violates/i.test(err.message)
            ? 'No se puede eliminar: el elemento está en uso por otros registros.'
            : err.message;
        return { ok: false, error: msg };
    }
    revalidatePath(`/dashboard/catalogos/${tabla}`);
    revalidatePath('/dashboard/catalogos');
    return { ok: true };
}
