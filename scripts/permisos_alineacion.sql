-- ─────────────────────────────────────────────────────────────────────────────
-- Alinea usuarios_modulos con la matriz vigente de sistema-activa-t
-- (src/config/permissions.ts al commit b0d3621, 21-jul-2026), quitando los
-- módulos descontinuados: Supervisión/Monitoreo, Gestión de Monitores y
-- Evaluación.
--
-- Cambios respecto del seed original de auth_schema.sql:
--   · invitado, herique, arojas y erizabal PIERDEN 'Inf. Gerencial'
--     (restringido el 17-jul a rcarbajal, pricra y el super admin).
--   · rcarbajal y erizabal GANAN 'Catálogos' (solo lectura).
--   · Alta de pconcha (Proyectos, Servicios, Documentos).
--
-- Ojo: la cuenta de pconcha aún no existe en Better-Auth. Crearla aparte:
--   docker compose exec app node scripts/create-user.mjs pconcha@fondoempleo.com.pe '<clave>'
--
-- Uso:
--   docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/permisos_alineacion.sql
--
-- Idempotente: reescribe la matriz completa dentro de una transacción.
-- No la toca el sync de datos (actualizar_bd_servidor.sh no incluye las
-- tablas de auth).
-- ─────────────────────────────────────────────────────────────────────────────

BEGIN;

DELETE FROM usuarios_modulos;

INSERT INTO usuarios_modulos (email, modulo) VALUES
    ('jduran@fondoempleo.com.pe',    'ALL'),

    ('invitado@fondoempleo.com.pe',  'Proyectos'),
    ('invitado@fondoempleo.com.pe',  'Servicios'),

    ('rcarbajal@fondoempleo.com.pe', 'Inf. Gerencial'),
    ('rcarbajal@fondoempleo.com.pe', 'Proyectos'),
    ('rcarbajal@fondoempleo.com.pe', 'Servicios'),
    ('rcarbajal@fondoempleo.com.pe', 'Documentos'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Proyectos'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Servicios'),
    ('rcarbajal@fondoempleo.com.pe', 'Gestión de Aportantes'),
    ('rcarbajal@fondoempleo.com.pe', 'Catálogos'),

    ('pricra@fondoempleo.com.pe',    'Inf. Gerencial'),
    ('pricra@fondoempleo.com.pe',    'Proyectos'),
    ('pricra@fondoempleo.com.pe',    'Servicios'),
    ('pricra@fondoempleo.com.pe',    'Gestión de Aportantes'),

    ('herique@fondoempleo.com.pe',   'Proyectos'),
    ('herique@fondoempleo.com.pe',   'Servicios'),

    ('arojas@fondoempleo.com.pe',    'Proyectos'),
    ('arojas@fondoempleo.com.pe',    'Servicios'),
    ('arojas@fondoempleo.com.pe',    'Gestión de Proyectos'),
    ('arojas@fondoempleo.com.pe',    'Gestión de Servicios'),

    ('erizabal@fondoempleo.com.pe',  'Proyectos'),
    ('erizabal@fondoempleo.com.pe',  'Servicios'),
    ('erizabal@fondoempleo.com.pe',  'Gestión de Proyectos'),
    ('erizabal@fondoempleo.com.pe',  'Gestión de Servicios'),
    ('erizabal@fondoempleo.com.pe',  'Catálogos'),

    ('jleclere@fondoempleo.com.pe',  'Proyectos'),

    ('jbozzo@fondoempleo.com.pe',    'Proyectos'),

    ('emoya@fondoempleo.com.pe',     'Servicios'),
    ('emoya@fondoempleo.com.pe',     'Gestión de Servicios'),

    ('hmeza@fondoempleo.com.pe',     'Proyectos'),
    ('hmeza@fondoempleo.com.pe',     'Servicios'),

    ('pconcha@fondoempleo.com.pe',   'Proyectos'),
    ('pconcha@fondoempleo.com.pe',   'Servicios'),
    ('pconcha@fondoempleo.com.pe',   'Documentos');

COMMIT;

-- Verificación: usuarios con cuenta pero sin módulos, y módulos sin cuenta.
\echo '--- Cuentas sin modulos asignados:'
SELECT u.email FROM "user" u
 WHERE NOT EXISTS (SELECT 1 FROM usuarios_modulos m WHERE m.email = u.email);

\echo '--- Modulos asignados a un correo sin cuenta en Better-Auth:'
SELECT DISTINCT m.email FROM usuarios_modulos m
 WHERE NOT EXISTS (SELECT 1 FROM "user" u WHERE u.email = m.email);
