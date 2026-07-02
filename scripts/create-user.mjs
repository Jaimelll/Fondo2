// ─────────────────────────────────────────────────────────────────────────────
// Crea (o resetea la contraseña de) un usuario de Better-Auth directamente en
// la base. No hay registro público: este script es la única vía de alta.
//
// Uso (siempre dentro del contenedor app):
//   docker compose exec app node scripts/create-user.mjs <email> <password> [nombre]
//
// El hash es bcrypt (cost 12), igual que el verify configurado en
// src/lib/auth.ts. Los permisos del usuario se gestionan aparte, en la tabla
// usuarios_modulos.
// ─────────────────────────────────────────────────────────────────────────────

import pg from 'pg';
import bcrypt from 'bcryptjs';
import { randomUUID } from 'node:crypto';

const [email, password, nombre] = process.argv.slice(2);

if (!email || !password) {
    console.error('Uso: node scripts/create-user.mjs <email> <password> [nombre]');
    process.exit(1);
}
if (password.length < 8) {
    console.error('La contraseña debe tener al menos 8 caracteres (mínimo de Better-Auth).');
    process.exit(1);
}

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
const norm = email.toLowerCase().trim();
const name = nombre || norm.split('@')[0];
const hash = await bcrypt.hash(password, 12);

const client = await pool.connect();
try {
    await client.query('BEGIN');

    const { rows } = await client.query(
        `insert into "user" (id, name, email, "emailVerified")
         values ($1, $2, $3, true)
         on conflict (email) do update set name = excluded.name, "updatedAt" = now()
         returning id`,
        [randomUUID(), name, norm],
    );
    const userId = rows[0].id;

    const upd = await client.query(
        `update "account" set password = $1, "updatedAt" = now()
         where "userId" = $2 and "providerId" = 'credential'`,
        [hash, userId],
    );
    if (upd.rowCount === 0) {
        await client.query(
            `insert into "account" (id, "accountId", "providerId", "userId", password)
             values ($1, $2, 'credential', $3, $4)`,
            [randomUUID(), String(userId), userId, hash],
        );
    }

    await client.query('COMMIT');
    console.log(`Usuario listo: ${norm} (id ${userId}). Recuerda asignarle módulos en usuarios_modulos.`);
} catch (err) {
    await client.query('ROLLBACK');
    console.error('Error creando usuario:', err.message);
    process.exitCode = 1;
} finally {
    client.release();
    await pool.end();
}
