-- Beca Trabajadores por año (22-sep-2026)
-- Los grupos "7 - Beca Trabajadores -Trabajadores" (1) y "-Hijos de trabajadores" (2) se
-- reparten por periodo en tres grupos: 2024 (id 1), 2025 (id 52), 2026 (id 3). Los ids 52 y 3
-- ya existían vacíos. El grupo 2 se borra. Los demás grupos de becas no cambian.
-- Idempotente. Correr con: psql -v ON_ERROR_STOP=1 -f este_archivo.sql
BEGIN;

UPDATE becas_nueva SET grupo_id = 1  WHERE linea_id = 7 AND periodo = 2024 AND grupo_id IS DISTINCT FROM 1;
UPDATE becas_nueva SET grupo_id = 52 WHERE linea_id = 7 AND periodo = 2025 AND grupo_id IS DISTINCT FROM 52;
UPDATE becas_nueva SET grupo_id = 3  WHERE linea_id = 7 AND periodo = 2026 AND grupo_id IS DISTINCT FROM 3;

-- Por si algo más apuntara al grupo 2 (hoy no hay proyectos ni informes en él)
UPDATE proyectos       SET grupo_id = 1 WHERE grupo_id = 2;
UPDATE informe_impacto SET grupo_id = 1 WHERE grupo_id = 2;

DELETE FROM grupo g
WHERE g.id = 2
  AND NOT EXISTS (SELECT 1 FROM becas_nueva     WHERE grupo_id = 2)
  AND NOT EXISTS (SELECT 1 FROM proyectos       WHERE grupo_id = 2)
  AND NOT EXISTS (SELECT 1 FROM informe_impacto WHERE grupo_id = 2);

UPDATE grupo SET descripcion = '7 - Beca Trabajadores 2024', orden = 1 WHERE id = 1;
UPDATE grupo SET descripcion = '7 - Beca Trabajadores 2025', orden = 2 WHERE id = 52;
UPDATE grupo SET descripcion = '7 - Beca Trabajadores 2026', orden = 3 WHERE id = 3;

COMMIT;

-- Verificación (esperado: 2024 = 77 becas y ~0.43 MM; 2025 = 139 y ~0.73 MM; 2026 = 105 y ~1.05 MM;
--   ninguna beca de línea 7 sin grupo; el grupo 2 ya no existe)
SELECT g.id, g.orden, g.descripcion, COUNT(b.id) AS becas, ROUND(SUM(b.presupuesto)/1e6, 2) AS mm,
       (SELECT COUNT(*) FROM informe_impacto i WHERE i.grupo_id = g.id) AS informes
FROM grupo g LEFT JOIN becas_nueva b ON b.grupo_id = g.id
WHERE g.tipo = 1 GROUP BY g.id ORDER BY g.orden, g.id;
SELECT COUNT(*) AS linea7_sin_grupo FROM becas_nueva WHERE linea_id = 7 AND grupo_id IS NULL;
SELECT COUNT(*) AS grupo2_restante FROM grupo WHERE id = 2;
