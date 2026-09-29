-- ====================================================================
-- Verificación de las órdenes de pago de becas (fase D del encargo pago-becas).
-- Solo lectura. Uso:
--   docker compose exec -T db psql -U fondo2 -d fondo2 < scripts/verifica_becas_pagos.sql
-- Correr igual en local y en el servidor y comparar.
-- ====================================================================
\pset footer off

\echo '=== 1. SUM(avance) por grupo (debe ser idéntico a la foto inicial) ==='
select coalesce(g.descripcion, '(sin grupo)') as grupo, count(*) as becas, sum(b.avance)::numeric(14,2) as sum_avance
  from becas_nueva b left join grupo g on g.id = b.grupo_id
 group by g.descripcion order by 1;
select count(*) as eventos_avance_beca from avance_beca;

\echo '=== 2a. OP históricas: Σ detalle vs Σ de sus eventos (solo las que NO cuadran) ==='
select op.codigo, op.importe, sum(d.monto) as suma_detalle, sum(a.monto) as suma_eventos, count(*) as lineas
  from beca_orden_pago op
  join beca_orden_pago_detalle d on d.orden_pago_id = op.id
  left join avance_beca a on a.id = d.avance_beca_id
 where op.estado = 'PAGADA'
 group by op.id, op.codigo, op.importe
having sum(d.monto) <> op.importe or sum(d.monto) <> coalesce(sum(a.monto), -1)
 order by op.numero;

\echo '=== 2b. Resumen de OP pagadas y enlaces ==='
select count(distinct op.id) as op_pagadas,
       count(d.id) as lineas_pagadas,
       count(d.id) filter (where d.avance_beca_id is null) as pagadas_sin_evento,
       (select count(*) from avance_beca where sustento ~* '^\s*OP\s') as eventos_con_op,
       (select count(*) from avance_beca a where sustento ~* '^\s*OP\s'
          and not exists (select 1 from beca_orden_pago_detalle x where x.avance_beca_id = a.id)) as eventos_op_sin_linea
  from beca_orden_pago op join beca_orden_pago_detalle d on d.orden_pago_id = op.id
 where d.estado = 'PAGADA';

\echo '=== 3. OP pendientes (205-209) ==='
select op.codigo, op.informe_codigo, op.modalidad, op.estado, op.importe,
       sum(d.monto) as suma_lineas, count(d.id) as lineas, count(distinct d.beca_id) as becarios,
       case when sum(d.monto) = op.importe then 'cuadra' else 'NO CUADRA' end as cuadre
  from beca_orden_pago op join beca_orden_pago_detalle d on d.orden_pago_id = op.id
 where op.estado <> 'PAGADA'
 group by op.id order by op.numero;

\echo '=== 4. beca_cuenta: CCI válidos / no válidos (vigentes) ==='
select count(*) as cuentas_vigentes,
       count(*) filter (where cci_valido) as cci_validos,
       count(*) filter (where not cci_valido) as cci_no_validos,
       count(*) filter (where cci_valido is null) as sin_verificar
  from beca_cuenta where vigente;
select bc.beca_id, b.nombre, bc.cci, bc.observacion
  from beca_cuenta bc join becas_nueva b on b.id = bc.beca_id
 where bc.vigente and not coalesce(bc.cci_valido, false);

\echo '=== 5. beca_presupuesto por grupo vs becas_nueva.presupuesto ==='
select g.descripcion as grupo,
       count(distinct p.beca_id) as becas_con_ppto,
       sum(p.programado)::numeric(14,2) as programado_cargado,
       (select sum(b2.presupuesto) from becas_nueva b2 where b2.grupo_id = g.id
          and exists (select 1 from beca_presupuesto p2 where p2.beca_id = b2.id))::numeric(14,2) as presupuesto_fondo2_mismas_becas
  from beca_presupuesto p join becas_nueva b on b.id = p.beca_id join grupo g on g.id = b.grupo_id
 group by g.id, g.descripcion order by 1;
select g.descripcion as grupo, c.codigo as concepto, sum(p.programado)::numeric(14,2) as programado
  from beca_presupuesto p join becas_nueva b on b.id = p.beca_id join grupo g on g.id = b.grupo_id
  join concepto_beca c on c.id = p.concepto_id
 group by g.descripcion, c.codigo, c.orden order by 1, c.orden;

\echo '=== 6. Otros controles ==='
select 'saldos negativos (ejecutado > programado)' as control, count(*) from v_beca_saldo where saldo < 0
union all
select 'líneas con concepto por defecto (histórico)', count(*) from beca_orden_pago_detalle where observacion like '%Concepto no determinado%'
union all
select 'IE con cuenta registrada', count(*) from institucion where cci is not null;
