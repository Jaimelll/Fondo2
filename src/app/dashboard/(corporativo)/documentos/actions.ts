"use server";

import { createClient } from "@supabase/supabase-js";
import { revalidatePath } from "next/cache";
import { query } from "@/lib/db";

// NOTA (Fase 2): la capa de DATOS ya va contra Postgres (query de lib/db).
// supabase.storage sigue en uso solo para los PDFs — se reemplaza por storage
// local en la Fase 3.
function getSupabase() {
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
    
    if (!url || !key) {
        throw new Error("Supabase environment variables are missing.");
    }
    
    return createClient(url, key, {
        auth: {
            persistSession: false
        }
    });
}

const BUCKET_NAME = "documentos_gerenciales";

/**
 * Sanitizes a filename for Supabase Storage:
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
        const supabase = getSupabase();
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

        const sanitizedFileName = sanitizeFileName(file.name);
        const fileName = `${Date.now()}_${sanitizedFileName}`;
        
        console.log("FILE NAME:", file.name);
        console.log("FILE PATH FINAL:", fileName);

        const { data: uploadData, error: uploadError } = await supabase.storage
            .from(BUCKET_NAME)
            .upload(fileName, file, { 
                contentType: "application/pdf", 
                upsert: true,
                cacheControl: '3600'
            });

        if (uploadError) {
            console.error("Storage upload error:", uploadError);
            const msg = uploadError.message.includes("fetch") ? "Error de conexión con el Storage" : uploadError.message;
            return { success: false, error: `Error Storage: ${msg}` };
        }

        const { data: urlData } = supabase.storage
            .from(BUCKET_NAME)
            .getPublicUrl(uploadData.path);

        try {
            await query(
                `insert into documentos_gerenciales (fecha_documento, nombre_archivo, url_pdf, observaciones)
                 values ($1, $2, $3, $4)`,
                [fecha_documento /* YYYY-MM-DD */, nombre_archivo, urlData.publicUrl, observaciones],
            );
        } catch (dbError: any) {
            console.error("Database insert error:", dbError.message);
            await supabase.storage.from(BUCKET_NAME).remove([uploadData.path]);
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
        const supabase = getSupabase();
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

            const sanitizedFileName = sanitizeFileName(file.name);
            const fileName = `${Date.now()}_${sanitizedFileName}`;
            
            console.log("FILE NAME:", file.name);
            console.log("FILE PATH FINAL:", fileName);

            const { data: uploadData, error: uploadError } = await supabase.storage
                .from(BUCKET_NAME)
                .upload(fileName, file, { 
                    contentType: "application/pdf", 
                    upsert: true,
                    cacheControl: '3600'
                });

            if (uploadError) {
                console.error("Storage update error:", uploadError);
                return { success: false, error: `Error Storage (update): ${uploadError.message}` };
            }

            const { data: urlData } = supabase.storage
                .from(BUCKET_NAME)
                .getPublicUrl(uploadData.path);
            
            updateData.url_pdf = urlData.publicUrl;

            // Cleanup old file
            if (current.url_pdf) {
                const parts = current.url_pdf.split("/");
                const oldPath = parts[parts.length - 1];
                if (oldPath) {
                    await supabase.storage.from(BUCKET_NAME).remove([oldPath]);
                }
            }
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
        const supabase = getSupabase();

        let current: any;
        try {
            const { rows } = await query('select url_pdf from documentos_gerenciales where id = $1', [id]);
            current = rows[0];
            if (!current) throw new Error('not found');
        } catch {
            return { success: false, error: "Error al verificar existencia para eliminación." };
        }

        if (current?.url_pdf) {
            const parts = current.url_pdf.split("/");
            const filePath = parts[parts.length - 1];
            if (filePath) {
                const { error: storageDelError } = await supabase.storage.from(BUCKET_NAME).remove([filePath]);
                if (storageDelError) {
                    console.warn("Storage deletion warning:", storageDelError.message);
                }
            }
        }

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
