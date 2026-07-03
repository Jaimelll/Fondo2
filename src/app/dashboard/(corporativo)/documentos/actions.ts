"use server";

import { promises as fs } from "fs";
import path from "path";
import { revalidatePath } from "next/cache";
import { query } from "@/lib/db";

// ─────────────────────────────────────────────────────────────────────────────
// Storage local de PDFs (reemplaza a Supabase Storage). Los archivos viven en
// STORAGE_DOCUMENTS_PATH (por defecto ./storage/documentos) y se sirven vía
// GET /api/documentos/[archivo] (ruta protegida por el proxy de auth).
// Los registros antiguos con url_pdf apuntando al Storage de Supabase siguen
// abriendo esa URL remota; solo los archivos nuevos se guardan en disco.
// ─────────────────────────────────────────────────────────────────────────────

const STORAGE_DIR = path.resolve(
    process.cwd(),
    process.env.STORAGE_DOCUMENTS_PATH || "./storage/documentos",
);

/**
 * Sanitizes a filename:
 * - Removes accents/tildes
 * - Replaces 'ñ' with 'n'
 * - Replaces spaces with '_'
 * - Converts to lowercase
 * - Removes any character that isn't alphanumeric, dot, or hyphen
 */
function sanitizeFileName(fileName: string): string {
    return fileName
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "") // quita tildes
        .replace(/[^a-zA-Z0-9._-]/g, "_") // reemplaza espacios y especiales por _
        .toLowerCase();
}

/** Guarda el PDF en disco y devuelve el nombre final del archivo. */
async function guardarArchivo(file: File): Promise<string> {
    const fileName = `${Date.now()}_${sanitizeFileName(file.name)}`;
    await fs.mkdir(STORAGE_DIR, { recursive: true });
    const buffer = Buffer.from(await file.arrayBuffer());
    await fs.writeFile(path.join(STORAGE_DIR, fileName), buffer);
    return fileName;
}

/** Borra del disco el archivo referido por un url_pdf (si es local y existe). */
async function eliminarArchivo(urlPdf: string | null | undefined) {
    if (!urlPdf) return;
    const fileName = path.basename(decodeURIComponent(urlPdf.split("/").pop() || ""));
    if (!fileName) return;
    try {
        await fs.unlink(path.join(STORAGE_DIR, fileName));
    } catch (err: any) {
        // Registros antiguos apuntan al Storage de Supabase: no hay archivo local.
        console.warn("Storage deletion warning:", err.message);
    }
}

function urlPublica(fileName: string): string {
    return `/api/documentos/${encodeURIComponent(fileName)}`;
}

export async function getDocumentos(search?: string) {
    try {
        // fecha_documento::text conserva el formato 'YYYY-MM-DD' que devolvía
        // PostgREST (la clave duplicada del select sobreescribe a la de d.*).
        let sql = `select d.*, d.fecha_documento::text as fecha_documento
                     from documentos_gerenciales d`;
        const params: unknown[] = [];

        if (search && search.trim()) {
            params.push(`%${search.trim()}%`);
            sql += ` where d.nombre_archivo ilike $1 or d.observaciones ilike $1`;
        }

        sql += ` order by d.fecha_documento desc`;

        const { rows } = await query(sql, params);
        return rows;
    } catch (err: any) {
        console.error("Critical error in getDocumentos:", err.message);
        return [];
    }
}

export async function createDocumento(formData: FormData) {
    try {
        const fecha_documento = formData.get("fecha_documento") as string;
        const nombre_archivo = formData.get("nombre_archivo") as string;
        const observaciones = formData.get("observaciones") as string;
        const file = formData.get("archivo") as File | null;

        if (!file || file.size === 0) {
            return { success: false, error: "Debe subir un archivo PDF." };
        }

        // Limit size to 20MB
        if (file.size > 20 * 1024 * 1024) {
            return { success: false, error: "El archivo excede el límite de 20 MB." };
        }

        let fileName: string;
        try {
            fileName = await guardarArchivo(file);
        } catch (uploadError: any) {
            console.error("Storage upload error:", uploadError);
            return { success: false, error: `Error Storage: ${uploadError.message}` };
        }

        try {
            await query(
                `insert into documentos_gerenciales (fecha_documento, nombre_archivo, url_pdf, observaciones)
                 values ($1, $2, $3, $4)`,
                [fecha_documento /* YYYY-MM-DD */, nombre_archivo, urlPublica(fileName), observaciones],
            );
        } catch (dbError: any) {
            console.error("Database insert error:", dbError.message);
            await eliminarArchivo(urlPublica(fileName));
            return { success: false, error: `Error DB: ${dbError.message}` };
        }

        revalidatePath("/dashboard/corporativo/documentos");
        return { success: true };
    } catch (err: any) {
        console.error("Unexpected error in createDocumento:", err.message);
        return { success: false, error: "Error inesperado al procesar la solicitud." };
    }
}

export async function updateDocumento(id: string, formData: FormData) {
    try {
        const fecha_documento = formData.get("fecha_documento") as string;
        const nombre_archivo = formData.get("nombre_archivo") as string;
        const observaciones = formData.get("observaciones") as string;
        const file = formData.get("archivo") as File | null;

        const { rows: currentRows } = await query(
            'select * from documentos_gerenciales where id = $1',
            [id],
        );
        const current = currentRows[0];

        if (!current) {
            return { success: false, error: "No se encontró el documento en la base de datos." };
        }

        const updateData: any = {
            fecha_documento,
            nombre_archivo,
            observaciones,
            updated_at: new Date().toISOString(),
        };

        if (file && file.size > 0) {
            // Limit size to 20MB
            if (file.size > 20 * 1024 * 1024) {
                return { success: false, error: "El nuevo archivo excede los 20 MB." };
            }

            let fileName: string;
            try {
                fileName = await guardarArchivo(file);
            } catch (uploadError: any) {
                console.error("Storage update error:", uploadError);
                return { success: false, error: `Error Storage (update): ${uploadError.message}` };
            }

            updateData.url_pdf = urlPublica(fileName);

            // Cleanup old file
            await eliminarArchivo(current.url_pdf);
        }

        try {
            const cols = Object.keys(updateData);
            const values = cols.map((c) => updateData[c]);
            const assignments = cols.map((c, i) => `"${c}" = $${i + 1}`);
            await query(
                `update documentos_gerenciales set ${assignments.join(', ')} where id = $${cols.length + 1}`,
                [...values, id],
            );
        } catch (dbUpdateError: any) {
            console.error("Database update error:", dbUpdateError.message);
            return { success: false, error: `Error DB (update): ${dbUpdateError.message}` };
        }

        revalidatePath("/dashboard/corporativo/documentos");
        return { success: true };
    } catch (err: any) {
        console.error("Unexpected error in updateDocumento:", err.message);
        return { success: false, error: "Fallo crítico en la actualización." };
    }
}

export async function deleteDocumento(id: string) {
    try {
        let current: any;
        try {
            const { rows } = await query('select url_pdf from documentos_gerenciales where id = $1', [id]);
            current = rows[0];
            if (!current) throw new Error('not found');
        } catch {
            return { success: false, error: "Error al verificar existencia para eliminación." };
        }

        await eliminarArchivo(current.url_pdf);

        try {
            await query('delete from documentos_gerenciales where id = $1', [id]);
        } catch (dbDelError: any) {
            return { success: false, error: `Error DB (delete): ${dbDelError.message}` };
        }

        revalidatePath("/dashboard/corporativo/documentos");
        return { success: true };
    } catch (err: any) {
        console.error("Unexpected error in deleteDocumento:", err.message);
        return { success: false, error: "Error al procesar la eliminación." };
    }
}
