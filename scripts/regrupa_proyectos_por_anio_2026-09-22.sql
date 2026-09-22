-- Reagrupación de proyectos por año de concurso (22-sep-2026)
-- La línea (L1..L6) deja de formar parte del grupo: para eso está el filtro Línea.
-- Idempotente: se puede ejecutar más de una vez. Correr con: psql -v ON_ERROR_STOP=1 -f este_archivo.sql
--
-- Sobreviven (id → nuevo nombre):            Se fusionan y se borran:
--   27  Actíva-T 2024                          32, 35            → 27
--   28  Actíva-T 2025                          30, 33            → 28
--   29  Actíva-T 2026                          31, 34, 36        → 29
--   40  Sectorial 2026                         (sin cambio de miembros)
--   37  Propuestas Sectorial 2026              (no se dibuja en la línea de tiempo)
--   45  Aportantes REPSOL 2026
--   41  Apoyo a Trabajadores 2024              43                → 41
--   42  Apoyo a Trabajadores 2025              44                → 42
--   49  Apoyo a Trabajadores 2022 (L-07)       47 (vacío), 50    → 49
--   46  Concursal 2022
--   39  Concursal 2018
-- Los grupos de becas (tipo 1) no se tocan.
BEGIN;

-- 1. Reasignar todo lo que apunte a los grupos que se fusionan (proyectos, becas, informes de impacto)
CREATE TEMP TABLE fusion (viejo int PRIMARY KEY, nuevo int NOT NULL) ON COMMIT DROP;
INSERT INTO fusion VALUES
  (32, 27), (35, 27),
  (30, 28), (33, 28),
  (31, 29), (34, 29), (36, 29),
  (43, 41),
  (44, 42),
  (47, 49), (50, 49);

UPDATE proyectos       p SET grupo_id = f.nuevo FROM fusion f WHERE p.grupo_id = f.viejo;
UPDATE becas_nueva     b SET grupo_id = f.nuevo FROM fusion f WHERE b.grupo_id = f.viejo;
UPDATE informe_impacto i SET grupo_id = f.nuevo FROM fusion f WHERE i.grupo_id = f.viejo;

-- 2. Borrar los grupos fusionados, solo si ya nada los referencia
DELETE FROM grupo g
WHERE g.id IN (SELECT viejo FROM fusion)
  AND NOT EXISTS (SELECT 1 FROM proyectos       WHERE grupo_id = g.id)
  AND NOT EXISTS (SELECT 1 FROM becas_nueva     WHERE grupo_id = g.id)
  AND NOT EXISTS (SELECT 1 FROM informe_impacto WHERE grupo_id = g.id);

-- 3. Nombres y orden de los grupos de proyectos (tipo 2)
UPDATE grupo SET descripcion = 'Actíva-T 2024',                    orden = 1  WHERE id = 27;
UPDATE grupo SET descripcion = 'Actíva-T 2025',                    orden = 2  WHERE id = 28;
UPDATE grupo SET descripcion = 'Actíva-T 2026',                    orden = 3  WHERE id = 29;
UPDATE grupo SET descripcion = 'Sectorial 2026',                   orden = 4  WHERE id = 40;
UPDATE grupo SET descripcion = 'Propuestas Sectorial 2026',        orden = 5  WHERE id = 37;
UPDATE grupo SET descripcion = 'Aportantes REPSOL 2026',           orden = 6  WHERE id = 45;
UPDATE grupo SET descripcion = 'Apoyo a Trabajadores 2024',        orden = 7  WHERE id = 41;
UPDATE grupo SET descripcion = 'Apoyo a Trabajadores 2025',        orden = 8  WHERE id = 42;
UPDATE grupo SET descripcion = 'Apoyo a Trabajadores 2022 (L-07)', orden = 9  WHERE id = 49;
UPDATE grupo SET descripcion = 'Concursal 2022',                   orden = 10 WHERE id = 46;
UPDATE grupo SET descripcion = 'Concursal 2018',                   orden = 11 WHERE id = 39;

COMMIT;

-- 4. Verificación (esperado: 11 grupos de proyectos; Actíva-T 2024 = 37, 2025 = 28, 2026 = 43;
--    Apoyo a Trabajadores 2024 = 19, 2025 = 18, 2022 = 10; Sectorial 2026 = 11; Propuestas = 7;
--    REPSOL = 1; Concursal 2022 = 6; Concursal 2018 = 1; ningún grupo fusionado sobrevive)
SELECT g.id, g.orden, g.descripcion, COUNT(p.id) AS proyectos,
       ROUND(SUM(p.monto_fondoempleo)/1e6, 2) AS mm, SUM(p.beneficiarios) AS benef,
       (SELECT COUNT(*) FROM informe_impacto i WHERE i.grupo_id = g.id) AS informes
FROM grupo g LEFT JOIN proyectos p ON p.grupo_id = g.id
WHERE g.tipo = 2 GROUP BY g.id ORDER BY g.orden;
SELECT COUNT(*) AS grupos_fusionados_restantes FROM grupo WHERE id IN (30,31,32,33,34,35,36,43,44,47,50);
