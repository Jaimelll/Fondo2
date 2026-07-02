import { betterAuth } from 'better-auth';
import { nextCookies } from 'better-auth/next-js';
import bcrypt from 'bcryptjs';
import { pool } from './db';

// ─────────────────────────────────────────────────────────────────────────────
// Instancia de Better-Auth sobre el Postgres propio (tablas en
// scripts/auth_schema.sql). Solo email + password; el registro público está
// deshabilitado: los usuarios se crean con scripts/create-user.mjs.
// ─────────────────────────────────────────────────────────────────────────────

export const auth = betterAuth({
    database: pool,
    secret: process.env.BETTER_AUTH_SECRET,
    baseURL: process.env.BETTER_AUTH_URL,
    emailAndPassword: {
        enabled: true,
        disableSignUp: true,
        password: {
            hash: (password) => bcrypt.hash(password, 12),
            verify: ({ hash, password }) => bcrypt.compare(password, hash),
        },
    },
    advanced: {
        database: {
            // UUIDs para que logs_actualizacion.usuario_id (uuid) y los triggers
            // de auditoría (current_setting(...)::uuid) sigan funcionando.
            generateId: () => crypto.randomUUID(),
        },
    },
    // nextCookies debe ir al final: permite que auth.api.* setee cookies desde
    // server actions y route handlers de Next.
    plugins: [nextCookies()],
});
