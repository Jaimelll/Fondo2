"use server";

import { withAuditUser } from '@/lib/db';
import { getSession } from '@/lib/session';

// ─────────────────────────────────────────────────────────────────────────────
// Server actions del módulo Edición. Escriben en `metricas`, que tiene trigger
// de auditoría → se envuelven en withAuditUser para que logs_actualizacion
// registre quién hizo el cambio.
// ─────────────────────────────────────────────────────────────────────────────

function colName(col: string): string {
    if (!/^[\p{L}_][\p{L}\p{N}_]*$/u.test(col)) {
        throw new Error(`Columna no válida: "${col}"`);
    }
    return `"${col}"`;
}

async function getAuditUserId(): Promise<string | null> {
    try {
        const session = await getSession();
        return session?.user.id ?? null;
    } catch {
        return null;
    }
}

export async function actualizarMetrica(id: any, updates: Record<string, any>): Promise<{ error: string | null }> {
    try {
        const userId = await getAuditUserId();
        const cols = Object.keys(updates);
        const values = cols.map((c) => updates[c]);
        const assignments = cols.map((c, i) => `${colName(c)} = $${i + 1}`);
        await withAuditUser(userId, (client) =>
            client.query(`update metricas set ${assignments.join(', ')} where id = $${cols.length + 1}`, [...values, id]),
        );
        return { error: null };
    } catch (err: any) {
        console.error('Error actualizando metricas:', err);
        return { error: err.message };
    }
}

export async function insertarMetrica(updates: Record<string, any>): Promise<{ error: string | null }> {
    try {
        const userId = await getAuditUserId();
        const cols = Object.keys(updates);
        const values = cols.map((c) => updates[c]);
        const placeholders = cols.map((_, i) => `$${i + 1}`);
        await withAuditUser(userId, (client) =>
            client.query(`insert into metricas (${cols.map(colName).join(', ')}) values (${placeholders.join(', ')})`, values),
        );
        return { error: null };
    } catch (err: any) {
        console.error('Error insertando metricas:', err);
        return { error: err.message };
    }
}
