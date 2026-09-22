-- Beneficiarios de becas (22-sep-2026)
-- Cada beca es una persona: beneficiarios debe ser 1. Nueve becas de Beca Trabajadores 2026
-- (ids 854-859 y 1137-1139, cargadas a mano) tenían 0 y hacían que la línea de tiempo de
-- Servicios mostrara 96 beneficiarios en vez de 105, y el KPI 1.183 en vez de 1.192.
-- Idempotente. Correr con: psql -v ON_ERROR_STOP=1 -f este_archivo.sql
BEGIN;
UPDATE becas_nueva SET beneficiarios = 1 WHERE beneficiarios IS NULL OR beneficiarios = 0;
COMMIT;

-- Verificación (esperado: total_becas = beneficiarios = 1192; distintos_de_1 = 0)
SELECT COUNT(*) AS total_becas, SUM(beneficiarios) AS beneficiarios,
       COUNT(*) FILTER (WHERE beneficiarios IS DISTINCT FROM 1) AS distintos_de_1
FROM becas_nueva;
SELECT g.descripcion, COUNT(*) AS becas, SUM(b.beneficiarios) AS beneficiarios
FROM becas_nueva b JOIN grupo g ON g.id = b.grupo_id
WHERE b.linea_id = 7 GROUP BY g.descripcion, g.orden ORDER BY g.orden;
