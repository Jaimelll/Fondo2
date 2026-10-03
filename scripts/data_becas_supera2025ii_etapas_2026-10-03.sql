-- ====================================================================
-- Etapas previas del grupo "Beca Supéra-T 2025 II" (grupo_id = 5) — 2026-10-03
--
-- El grupo no salía en la línea de tiempo de Servicios porque su bitácora
-- (avance_beca) solo tenía pagos (etapa 5 en adelante) y el gráfico exige
-- la fecha de la etapa 1 (Bases) para dibujar la fila.
--
-- Fuente: "Becas_FONDOEMPLEO_al 2.10.26.xlsx", hoja "Registro de becarios"
-- (misma fecha para todo el grupo):
--   Aprobado (3): 27/01/2026 — aprobación en sesión de Consejo Directivo.
--   Firma (4):    03/03/2026 — firma de convenio.
--   Bases (1) y Lanzamiento (2): el Excel no las trae; por indicación de
--   Jaime (03/10/2026) se usa la misma fecha de aprobación, solo para que
--   el grupo se vea. Reemplazar cuando se tengan las fechas reales.
--
-- Firma solo se registra a las becas que ya pasaron de Aprobado, para que
-- un recálculo no adelante la etapa de las que siguen en Aprobado.
-- No toca becas_nueva: los eventos son anteriores a los pagos y tienen
-- monto 0, así que etapa y avance derivados no cambian.
--
-- Idempotente: no inserta si la beca ya tiene un evento de esa etapa.
-- ====================================================================

insert into public.avance_beca (beca_id, etapa_id, fecha, sustento, monto)
select b.id, e.etapa_id, e.fecha, e.sustento, 0
from public.becas_nueva b
cross join (values
  (1, date '2026-01-27', 'Fecha referencial: se usa la de aprobación en Consejo Directivo (sin dato de bases)'),
  (2, date '2026-01-27', 'Fecha referencial: se usa la de aprobación en Consejo Directivo (sin dato de lanzamiento)'),
  (3, date '2026-01-27', 'Aprobación en sesión de Consejo Directivo (Excel Becas al 02/10/2026)'),
  (4, date '2026-03-03', 'Firma de convenio (Excel Becas al 02/10/2026)')
) as e(etapa_id, fecha, sustento)
where b.grupo_id = 5
  and (e.etapa_id < 4 or b.etapa_id >= 4)
  and not exists (
    select 1 from public.avance_beca a
    where a.beca_id = b.id and a.etapa_id = e.etapa_id
  )
order by b.id, e.etapa_id;
