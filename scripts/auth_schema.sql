-- ─────────────────────────────────────────────────────────────────────────────
-- Tablas de Better-Auth + permisos por módulo (usuarios_modulos).
-- Aplicar sobre la base fondo2 DESPUÉS de scripts/schema.sql:
--   docker compose exec -T db psql -U fondo2 -d fondo2 < scripts/auth_schema.sql
-- Idempotente (IF NOT EXISTS / ON CONFLICT).
--
-- Nota: columnas en camelCase entre comillas porque es el naming por defecto
-- del adaptador de Better-Auth. Los ids son uuid (generateId configurado en
-- src/lib/auth.ts) para ser compatibles con logs_actualizacion.usuario_id.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS "user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" text NOT NULL,
    "email" text NOT NULL UNIQUE,
    "emailVerified" boolean NOT NULL DEFAULT false,
    "image" text,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "expiresAt" timestamptz NOT NULL,
    "token" text NOT NULL UNIQUE,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "ipAddress" text,
    "userAgent" text,
    "userId" uuid NOT NULL REFERENCES "user"("id") ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS session_userid_idx ON "session" ("userId");

CREATE TABLE IF NOT EXISTS "account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" uuid NOT NULL REFERENCES "user"("id") ON DELETE CASCADE,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamptz,
    "refreshTokenExpiresAt" timestamptz,
    "scope" text,
    "password" text,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS account_userid_idx ON "account" ("userId");

CREATE TABLE IF NOT EXISTS "verification" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "identifier" text NOT NULL,
    "value" text NOT NULL,
    "expiresAt" timestamptz NOT NULL,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now()
);

-- ─────────────────────────────────────────────────────────────────────────────
-- Permisos por módulo (reemplaza MODULOS_POR_USUARIO de config/permissions.ts).
-- modulo = 'ALL' significa acceso total. El email va en minúsculas.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS usuarios_modulos (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email text NOT NULL,
    modulo text NOT NULL,
    UNIQUE (email, modulo)
);

-- Seed: matriz vigente al momento de la migración (sin los módulos eliminados
-- Supervisión, Gestión de Monitores y Evaluación).
INSERT INTO usuarios_modulos (email, modulo) VALUES
    ('jduran@fondoempleo.com.pe',    'ALL'),
    ('invitado@fondoempleo.com.pe',  'Inf. Gerencial'),
    ('invitado@fondoempleo.com.pe',  'Proyectos'),
    ('invitado@fondoempleo.com.pe',  'Servicios'),
    ('rcarbajal@fondoempleo.com.pe', 'Inf. Gerencial'),
    ('rcarbajal@fondoempleo.com.pe', 'Proyectos'),
    ('rcarbajal@fondoempleo.com.pe', 'Servicios'),
    ('rcarbajal@fondoempleo.com.pe', 'Documentos'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Proyectos'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Servicios'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Aportantes'),
    ('pricra@fondoempleo.com.pe',    'Inf. Gerencial'),
    ('pricra@fondoempleo.com.pe',    'Proyectos'),
    ('pricra@fondoempleo.com.pe',    'Servicios'),
    ('pricra@fondoempleo.com.pe',    'Gestión de Aportantes'),
    ('herique@fondoempleo.com.pe',   'Inf. Gerencial'),
    ('herique@fondoempleo.com.pe',   'Proyectos'),
    ('herique@fondoempleo.com.pe',   'Servicios'),
    ('arojas@fondoempleo.com.pe',    'Inf. Gerencial'),
    ('arojas@fondoempleo.com.pe',    'Proyectos'),
    ('arojas@fondoempleo.com.pe',    'Servicios'),
    ('arojas@fondoempleo.com.pe',    'Gestión de Proyectos'),
    ('arojas@fondoempleo.com.pe',    'Gestión de Servicios'),
    ('erizabal@fondoempleo.com.pe',  'Inf. Gerencial'),
    ('erizabal@fondoempleo.com.pe',  'Proyectos'),
    ('erizabal@fondoempleo.com.pe',  'Servicios'),
    ('erizabal@fondoempleo.com.pe',  'Gestión de Proyectos'),
    ('erizabal@fondoempleo.com.pe',  'Gestión de Servicios'),
    ('jleclere@fondoempleo.com.pe',  'Proyectos'),
    ('jbozzo@fondoempleo.com.pe',    'Proyectos'),
    ('emoya@fondoempleo.com.pe',     'Servicios'),
    ('emoya@fondoempleo.com.pe',     'Gestión de Servicios'),
    ('hmeza@fondoempleo.com.pe',     'Proyectos'),
    ('hmeza@fondoempleo.com.pe',     'Servicios')
ON CONFLICT (email, modulo) DO NOTHING;
