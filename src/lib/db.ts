import { Pool, type PoolClient, type QueryResult, type QueryResultRow } from 'pg';

// ─────────────────────────────────────────────────────────────────────────────
// Pool único de Postgres para todo el servidor (auth, permisos y, en fases
// siguientes, la capa de datos). En dev se cachea en globalThis para sobrevivir
// el hot-reload de Next sin agotar conexiones.
// ─────────────────────────────────────────────────────────────────────────────

const globalForPg = globalThis as unknown as { pgPool?: Pool };

export const pool =
    globalForPg.pgPool ??
    new Pool({
        connectionString: process.env.DATABASE_URL,
        max: 10,
    });

if (process.env.NODE_ENV !== 'production') {
    globalForPg.pgPool = pool;
}

export async function query<T extends QueryResultRow = QueryResultRow>(
    text: string,
    params?: unknown[],
): Promise<QueryResult<T>> {
    return pool.query<T>(text, params as never[]);
}

/**
 * Ejecuta `fn` dentro de una transacción con `app.current_user_id` seteado
 * (SET LOCAL vía set_config), de modo que los triggers de auditoría de
 * scripts/schema.sql registren quién hizo el cambio en logs_actualizacion.
 * `userId` debe ser el UUID del usuario autenticado (o null para anónimo).
 */
export async function withAuditUser<T>(
    userId: string | null,
    fn: (client: PoolClient) => Promise<T>,
): Promise<T> {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        await client.query("select set_config('app.current_user_id', $1, true)", [userId ?? '']);
        const result = await fn(client);
        await client.query('COMMIT');
        return result;
    } catch (err) {
        await client.query('ROLLBACK');
        throw err;
    } finally {
        client.release();
    }
}
