-- Sincroniza usuarios_modulos con la matriz de permisos vigente en el
-- original (commits 047aedf y 867035d de sistema-activa-t):
--   - 'Inf. Gerencial' restringido: solo rcarbajal, pricra y el super admin.
--   - 'Catálogos' visible (solo lectura) para rcarbajal y erizabal.
--   - pconcha con Proyectos, Servicios y Documentos.
-- Idempotente: se puede correr más de una vez.

BEGIN;

DELETE FROM usuarios_modulos
 WHERE modulo = 'Inf. Gerencial'
   AND email IN (
       'arojas@fondoempleo.com.pe',
       'erizabal@fondoempleo.com.pe',
       'herique@fondoempleo.com.pe',
       'invitado@fondoempleo.com.pe'
   );

INSERT INTO usuarios_modulos (email, modulo) VALUES
    ('erizabal@fondoempleo.com.pe',  'Catálogos'),
    ('rcarbajal@fondoempleo.com.pe', 'Catálogos'),
    ('pconcha@fondoempleo.com.pe',   'Proyectos'),
    ('pconcha@fondoempleo.com.pe',   'Servicios'),
    ('pconcha@fondoempleo.com.pe',   'Documentos')
ON CONFLICT (email, modulo) DO NOTHING;

COMMIT;

-- Verificación
SELECT email, string_agg(modulo, ' | ' ORDER BY modulo) AS modulos
  FROM usuarios_modulos GROUP BY email ORDER BY email;
