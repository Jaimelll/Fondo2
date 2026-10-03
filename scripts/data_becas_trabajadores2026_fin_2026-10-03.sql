-- ====================================================================
-- Fin proyectado de las becas "Beca Trabajadores 2026" (grupo_id = 3) — 2026-10-03
--
-- La barra del grupo en la línea de tiempo de Servicios terminaba el
-- 29/08/2026 porque solo las 25 becas ya culminadas tenían evento
-- "Ejecutado" (etapa 6); las 80 que siguen en Firma/Ejecución no tenían
-- fecha de fin.
--
-- Fuente: "Becas_FONDOEMPLEO_al 2.10.26.xlsx", hoja "Registro de becarios",
-- columna "Fin de carrera": fecha exacta en los cursos cortos; semestre en
-- las carreras (AAAA-I -> 31/07/AAAA, AAAA-II -> 31/12/AAAA). Emparejado
-- por DNI: 53 de las 80 becas sin fin están en el Excel.
--
-- Solo se proyectan fines FUTUROS (posteriores al 03/10/2026) y solo a
-- becas que no tienen ningún evento de etapa 6.
-- No toca becas_nueva; monto 0, no altera el avance.
--
-- Idempotente: no inserta si la beca ya tiene un evento de etapa 6.
-- ====================================================================

insert into public.avance_beca (beca_id, etapa_id, fecha, sustento, monto)
select b.id, 6, v.fecha, 'Fin proyectado: fin de carrera según Excel Becas al 02/10/2026', 0
from (values
  (842, date '2026-08-28'),
  (843, date '2026-09-27'),
  (844, date '2026-10-06'),
  (845, date '2026-10-28'),
  (846, date '2026-08-23'),
  (847, date '2026-10-24'),
  (848, date '2026-08-27'),
  (849, date '2026-08-28'),
  (850, date '2026-09-30'),
  (851, date '2026-09-21'),
  (852, date '2028-12-31'),
  (853, date '2029-07-31'),
  (854, date '2026-12-15'),
  (855, date '2026-07-29'),
  (856, date '2026-07-29'),
  (857, date '2026-07-29'),
  (858, date '2026-07-29'),
  (859, date '2026-07-29'),
  (1137, date '2026-08-28'),
  (1138, date '2026-08-28'),
  (1139, date '2026-08-28'),
  (1140, date '2026-10-20'),
  (1141, date '2026-10-20'),
  (1142, date '2026-10-20'),
  (1143, date '2026-10-20'),
  (1144, date '2026-10-20'),
  (1145, date '2026-10-20'),
  (1146, date '2026-10-20'),
  (1147, date '2026-10-20'),
  (1148, date '2026-10-20'),
  (1149, date '2026-10-20'),
  (1150, date '2026-10-23'),
  (1151, date '2026-10-23'),
  (1152, date '2026-10-23'),
  (1153, date '2026-10-23'),
  (1154, date '2026-10-23'),
  (1155, date '2026-10-23'),
  (1156, date '2026-10-23'),
  (1157, date '2026-10-23'),
  (1158, date '2026-10-23'),
  (1159, date '2026-10-23'),
  (1160, date '2028-12-31'),
  (1161, date '2030-12-31'),
  (1162, date '2030-12-31'),
  (1163, date '2031-07-31'),
  (1164, date '2029-12-31'),
  (1165, date '2031-07-31'),
  (1166, date '2029-12-31'),
  (1167, date '2030-07-31'),
  (1168, date '2026-12-31'),
  (1169, date '2030-12-31'),
  (1170, date '2027-12-31'),
  (1171, date '2028-07-31')

) as v(beca_id, fecha)
join public.becas_nueva b on b.id = v.beca_id and b.grupo_id = 3
where v.fecha > date '2026-10-03'
  and not exists (
    select 1 from public.avance_beca a
    where a.beca_id = b.id and a.etapa_id = 6
  )
order by b.id;
