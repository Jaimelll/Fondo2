-- ====================================================================
-- Seeds de catálogos para las órdenes de pago de becas — 2026-09-29
--
-- Fuente:
--   bancos:        los 6 del encargo (confirmar el resto con Tesorería).
--   concepto_beca: alias recogidos de los Anexo 02 y BD de becarios de las
--                  OP 205-209 (Desktop\SistemaPagos\06_Datos\Becas\insumos),
--                  aprobados por Jaime el 29/09/2026. TITULACION no tiene
--                  código propio en los Anexos (la OP 208 lo paga como
--                  OTR-0006-ACADEMICOS y se registra como ACADEMICOS).
--
-- Idempotente: ON CONFLICT DO NOTHING (no pisa lo editado en Catálogos).
-- Requiere scripts/migration_becas_pagos.sql.
-- ====================================================================

insert into public.bancos (codigo_cci, nombre, sigla) values
  ('002', 'Banco de Crédito del Perú', 'BCP'),
  ('003', 'Interbank', 'Interbank'),
  ('009', 'Scotiabank Perú', 'Scotiabank'),
  ('011', 'BBVA Perú', 'BBVA'),
  ('018', 'Banco de la Nación', 'BN'),
  ('038', 'Banco Interamericano de Finanzas', 'BanBif')
on conflict (codigo_cci) do nothing;

insert into public.concepto_beca (codigo, nombre, tipo, abono_por_defecto, codigos_anexo, orden) values
  ('ACADEMICOS',  'Costos académicos (matrícula, derechos, seguro, carné, otros gastos)', 'ACADEMICO',    'IE',      '{OTR-0001-ACADEMICOS,OTR-0006-ACADEMICOS}', 1),
  ('SUBVENCION',  'Subvención (alimentación, alojamiento, pasajes, internet)',            'NO_ACADEMICO', 'BECARIO', '{OTR-0001-GNOACADEMI,OTR-0006-GNOACADEMI}', 2),
  ('DISPOSITIVO', 'Dispositivo electrónico',                                              'NO_ACADEMICO', 'BECARIO', '{OTR-0002-DISPELECTR}', 3),
  ('INCENTIVO',   'Incentivos adicionales',                                               'INCENTIVO',    'BECARIO', '{OTR-0003-INCENTADIC}', 4),
  ('INGLES',      'Inglés 1 año',                                                         'NO_ACADEMICO', 'BECARIO', '{OTR-0004-INGLES1ANO}', 5),
  ('NIVELACION',  'Nivelación',                                                           'NO_ACADEMICO', 'BECARIO', '{OTR-0005-NIVELACION}', 6),
  ('TITULACION',  'Gastos de titulación',                                                 'TITULACION',   'IE',      '{}', 7)
on conflict (codigo) do nothing;
