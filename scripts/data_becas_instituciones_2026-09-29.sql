-- ====================================================================
-- Paso 2 — RUC y cuenta de las IE con abono directo
-- Generado por scripts/oneoff/genera_becas_supera2025.cjs el 2026-09-29.
-- Fuente: Anexo 02 de las OP 206 y 207 (UPN).
-- Idempotente. No toca becas_nueva.avance ni avance_beca.
-- Solo completa campos vacíos (coalesce): no pisa lo editado en Catálogos.
-- ====================================================================
-- Universidad Privada del Norte - UPN: Anexo 02 de las OP206 y OP207
update public.institucion
   set ruc = coalesce(ruc, '20215276024'),
       tiene_convenio = true,
       banco_id = coalesce(banco_id, 1),
       cuenta_bancaria = coalesce(cuenta_bancaria, '570-0062527-0-59'),
       cci = coalesce(cci, '00257000006252705900'),
       observacion = coalesce(observacion, 'Cuenta tomada del Anexo 02 (2026-09-29); CCI con dígitos de control válidos. Cuenta contable por convocatoria: va en la línea de la OP.')
 where id = 61;
