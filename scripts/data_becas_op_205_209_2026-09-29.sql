-- ====================================================================
-- Paso 7 — OP 205 a 209 (pendientes de pago), estado EN_TESORERIA, líneas PENDIENTE
-- Generado por scripts/oneoff/genera_op_205_209.cjs el 2026-09-29.
-- Fuente: Anexo 02 y PDF (PS5.UAF.F03 e Informe) de cada OP, correos de Servicios del
--         28/09/2026 (Desktop\SistemaPagos\06_Datos\Becas\insumos\OP205 … OP209).
-- Solo filas visibles de la hoja de pago. No crea eventos en avance_beca: eso lo hace
-- «Registrar pago ejecutado» cuando el banco pague.
-- Idempotente (ON CONFLICT DO NOTHING / NOT EXISTS por fila del Anexo).
-- ====================================================================
-- ── OP 205-UPS-AS/FE-2026 · Anexo «Anexo Nro 02 COSTOS ACADEMICOS - OP 205.xlsx», hoja «ANEXO 2»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values ('205-UPS-AS/FE-2026', 205, 2026, '2026-09-28', '209-UPS-AS/FE-2026', 5, 8, 'REEMBOLSO',
  'COSTOS ACADEMICOS BECA SUPERA -T 2026-II - REEMBOLSO', 6258.27, 8, 'EN_TESORERIA', 'El Anexo tiene 169 filas ocultas (becarios que no cobran) y la hoja «ANEXO 2 (2)» es la copia de la muestra: no se cargan.', 'carga inicial 2026-09-29')
on conflict (codigo) do nothing;
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 676, 1, '2026-II', 66, '46991344', 'BECARIO', 'APAZA ENRIQUEZ YOSELYN BRENDA',
  'DNI', '71154900', 1, '19113575458082', '00219111357545808250', 822.26, 'PENDIENTE', 16, null
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 16);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 695, 1, '2026-II', 17, '46991309', 'BECARIO', 'CARBAJAL QUISPE YOSELIN BRIYID',
  'DNI', '62191422', 1, '22015233320093', '00222011523332009327', 539.00, 'PENDIENTE', 36, null
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 36);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 716, 1, '2026-II', 66, '46991344', 'BECARIO', 'CRUZ ZURITA SANDRA',
  'DNI', '61200795', 1, '194-15303135-0-11', '00219411530313501195', 811.51, 'PENDIENTE', 60, null
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 60);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 749, 1, '2026-II', 7, '46991316', 'BECARIO', 'LUJAN DE LA CRUZ ANGELES CELESTE',
  'DNI', '74723834', 1, '19115253497071', '00219111525349707158', 540.00, 'PENDIENTE', 97, null
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 97);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 751, 1, '2026-II', 75, '46991326', 'BECARIO', 'MAMANI CALDERON JEAN FINAM NIELS',
  'DNI', '60983099', 4, '0011-0814-0292270351-13', '01181400029227035113', 2325.00, 'PENDIENTE', 99, 'El Anexo dice «BCP» pero el CCI es de BBVA (011): manda el CCI. La glosa dice 2026-I, pero los comprobantes son del 2026-II: se registra 2026-II.'
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 99);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 765, 1, '2026-II', 66, '46991344', 'BECARIO', 'NUÑEZ BUSTAMANTE LESLIE YOSELIN',
  'DNI', '60910012', 1, '19115252660026', '00219111525266002655', 731.50, 'PENDIENTE', 114, null
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 114);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 806, 1, '2026-II', 16, '46991304', 'BECARIO', 'TICLIAHUANCA SANTA CRUZ LESLY',
  'DNI', '70704826', 4, '0011-0814-0292331644', '01181400029233164418', 250.00, 'PENDIENTE', 157, 'El Anexo dice «Interbank» pero el CCI es de BBVA (011): manda el CCI. La glosa dice 2026-I, pero los comprobantes son del 2026-II: se registra 2026-II.'
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 157);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 812, 1, '2026-II', 24, '46991313', 'BECARIO', 'TORIBIO PAMO SOFIA',
  'DNI', '60071392', 1, '25515237832085', '00225511523783208585', 239.00, 'PENDIENTE', 163, 'La glosa dice 2026-I, pero los comprobantes son del 2026-II: se registra 2026-II.'
  from public.beca_orden_pago op
 where op.codigo = '205-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 163);

-- ── OP 206-UPS-AS/FE-2026 · Anexo «Anexo 02 pagos SUPERA-T - OP N 206.xlsx», hoja «ANEXO 2(2)»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values ('206-UPS-AS/FE-2026', 206, 2026, '2026-09-28', '210-UPS-AS/FE-2026', 4, 8, 'ABONO_IE',
  'COSTOS ACADÉMICOS BECA SUPERA-T - 2026-II', 2221.96, 2, 'EN_TESORERIA', 'El PDF de la OP dice «N° 209-UPS-AS/FE-2026», pero su importe (S/ 2,221.96) y su Anexo son los de la 206: se registra como 206. La hoja de pago del Anexo es «ANEXO 2(2)» («ANEXO 2» está oculta).', 'carga inicial 2026-09-29')
on conflict (codigo) do nothing;
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 25, 1, '2026-II', 61, '46991231', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 1506.96, 'PENDIENTE', 10, null
  from public.beca_orden_pago op
 where op.codigo = '206-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 10);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 40, 1, '2026-II', 61, '46991231', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 715.00, 'PENDIENTE', 11, 'El Anexo trae el DNI 19259518, que no es el del becario (DNI 61242496; en el BD de becarios figura como DNI de su aval): emparejado por nombre.'
  from public.beca_orden_pago op
 where op.codigo = '206-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 11);

-- ── OP 207-UPS-AS/FE-2026 · Anexo «Anexo 02 pagos OP 207.xlsx», hoja «ANEXO 2»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values ('207-UPS-AS/FE-2026', 207, 2026, '2026-09-28', '211-UPS-AS/FE-2026', 5, 8, 'ABONO_IE',
  'COSTOS ACADÉMICOS BECA SUPERA-T - 2026-II', 10811.99, 6, 'EN_TESORERIA', 'La «Hoja2» del Anexo es la copia de la muestra: no se carga.', 'carga inicial 2026-09-29')
on conflict (codigo) do nothing;
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 699, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 1844.00, 'PENDIENTE', 39, null
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 39);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 835, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 2411.75, 'PENDIENTE', 70, 'La beca figura como «Pendiente» en fondo2 (en el BD, Activo).'
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 70);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 834, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 3013.12, 'PENDIENTE', 71, 'La beca figura como «Pendiente» en fondo2 (en el BD, Activo).'
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 71);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 750, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 807.00, 'PENDIENTE', 91, null
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 91);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 771, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 344.12, 'PENDIENTE', 112, null
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 112);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 800, 1, '2026-II', 61, '46991342', 'IE', 'UNIVERSIDAD PRIVADA DEL NORTE',
  'RUC', '20215276024', 1, '570-0062527-0-59', '00257000006252705900', 2392.00, 'PENDIENTE', 138, null
  from public.beca_orden_pago op
 where op.codigo = '207-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 138);

-- ── OP 208-UPS-AS/FE-2026 · Anexo «Anexo 02 pagos OP Nro 208.xlsx», hoja «ANEXO 2»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values ('208-UPS-AS/FE-2026', 208, 2026, '2026-09-28', '212-UPS-AS/FE-2026', 4, 8, 'REEMBOLSO',
  'COSTOS ACADEMICOS BECA SUPERA -T 2026-II - REEMBOLSO', 1204.00, 3, 'EN_TESORERIA', 'Reembolso de matrícula, derechos académicos y gastos de titulación (Informe 212); el Anexo lo consigna como OTR-0006-ACADEMICOS y se registra como ACADEMICOS (decisión del 29/09/2026).', 'carga inicial 2026-09-29')
on conflict (codigo) do nothing;
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 2, 1, '2026-II', 16, '46991209', 'BECARIO', 'ALARCON AYALA ANALY LILIA',
  'DNI', '72905485', 1, '19407523395087', '00219410752339508793', 250.00, 'PENDIENTE', 9, null
  from public.beca_orden_pago op
 where op.codigo = '208-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 9);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 9, 1, '2026-II', 8, '46991202', 'BECARIO', 'BASURTO RUIZ DORINA NAYELLY',
  'DNI', '73857414', 1, '19107526631056', '00219110752663105655', 410.00, 'PENDIENTE', 16, null
  from public.beca_orden_pago op
 where op.codigo = '208-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 16);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 63, 1, '2026-II', 17, '46991210', 'BECARIO', 'REYES RUEDA FATIMA LUCERO',
  'DNI', '60028218', 1, null, '00219110780075705153', 544.00, 'PENDIENTE', 70, 'En «cuenta bancaria» venía lo que parece un número de tarjeta de 16 dígitos: no se guarda, queda solo el CCI.'
  from public.beca_orden_pago op
 where op.codigo = '208-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 70);

-- ── OP 209-UPS-AS/FE-2026 · Anexo «Anexo 02 pagos OP Nro 209.xlsx», hoja «ANEXO 2»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values ('209-UPS-AS/FE-2026', 209, 2026, '2026-09-28', '213-UPS-AS/FE-2026', 4, 8, 'REEMBOLSO',
  'COSTOS NO ACADEMICOS BECA SUPÉRA -T 2025 - INGLÉS', 1682.92, 4, 'EN_TESORERIA', 'Reembolso de inglés e incentivos (5 líneas, 4 becarios). La «Hoja2» del Anexo (8 becarios, S/ 3,186.28) es la OP 179 ya pagada: no se carga.', 'carga inicial 2026-09-29')
on conflict (codigo) do nothing;
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 9, 5, null, 8, '46991202', 'BECARIO', 'BASURTO RUIZ DORINA NAYELLY',
  'DNI', '73857414', 1, '19107526631056', '00219110752663105655', 259.00, 'PENDIENTE', 16, null
  from public.beca_orden_pago op
 where op.codigo = '209-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 16);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 33, 4, null, 23, '46991211', 'BECARIO', 'HUACACHINO SANTOS JEAN PIERRE',
  'DNI', '73664278', 1, '36507499740041', '00236510749974004155', 500.00, 'PENDIENTE', 40, null
  from public.beca_orden_pago op
 where op.codigo = '209-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 40);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 33, 5, null, 23, '46991211', 'BECARIO', 'HUACACHINO SANTOS JEAN PIERRE',
  'DNI', '73664278', 1, '36507499740041', '00236510749974004155', 272.64, 'PENDIENTE', 41, 'La fila del Anexo no trae cuenta: hereda la de la fila anterior (mismo becario).'
  from public.beca_orden_pago op
 where op.codigo = '209-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 41);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 41, 5, null, 23, '46991211', 'BECARIO', 'LOAYZA GUTIERREZ JOSE NOLBERTO',
  'DNI', '70677054', 1, '47009492393028', '00247010949239302835', 325.64, 'PENDIENTE', 49, 'El Anexo trae el DNI 70677054, que no es el del becario (DNI 60489032; en el BD de becarios figura como DNI de su aval): emparejado por nombre. OJO: es un abono al becario y se pagaría con el DNI 70677054; el titular de la cuenta es el becario (DNI 60489032). Confirmar con Servicios antes de generar el TXT.'
  from public.beca_orden_pago op
 where op.codigo = '209-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 49);
insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, 56, 5, null, 23, '46991211', 'BECARIO', 'PEREIRA CANAQUIRI MARILY',
  'DNI', '76947785', 1, '39007518142054', '00239010751814205439', 325.64, 'PENDIENTE', 64, null
  from public.beca_orden_pago op
 where op.codigo = '209-UPS-AS/FE-2026'
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = 64);
