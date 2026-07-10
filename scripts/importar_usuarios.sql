-- Importa a Better-Auth los usuarios exportados de Supabase
-- (/tmp/usuarios_supabase.csv dentro del contenedor db).
-- Idempotente: usuarios ya existentes se conservan tal cual (no pisa contrasenas).
BEGIN;

CREATE TEMP TABLE su (id uuid, email text, name text, hash text, created_at timestamptz);
\copy su FROM /tmp/usuarios_supabase.csv WITH CSV HEADER

-- Usuarios (conserva el UUID de Supabase para que la auditoria siga cuadrando)
INSERT INTO "user" (id, name, email, "emailVerified", "createdAt")
SELECT s.id, s.name, s.email, true, s.created_at
FROM su s
ON CONFLICT (email) DO NOTHING;

-- Credenciales: el hash bcrypt de Supabase es compatible con el verify de fondo2
INSERT INTO "account" (id, "accountId", "providerId", "userId", password)
SELECT gen_random_uuid(), u.id::text, 'credential', u.id, s.hash
FROM su s
JOIN "user" u ON u.email = s.email
WHERE s.hash LIKE '$2%'
  AND NOT EXISTS (
    SELECT 1 FROM "account" a
    WHERE a."userId" = u.id AND a."providerId" = 'credential'
  );

COMMIT;

\echo '--- Usuarios totales en fondo2:'
SELECT count(*) AS usuarios FROM "user";
\echo '--- Sin hash compatible (resetear con create-user.mjs):'
SELECT email FROM su WHERE hash IS NULL OR hash NOT LIKE '$2%';
\echo '--- Usuarios sin modulos asignados (agregar en usuarios_modulos):'
SELECT u.email FROM "user" u
WHERE NOT EXISTS (SELECT 1 FROM usuarios_modulos m WHERE m.email = u.email);
