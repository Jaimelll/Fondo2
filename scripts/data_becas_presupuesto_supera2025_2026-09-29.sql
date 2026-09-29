-- ====================================================================
-- Paso 5 — beca_presupuesto por concepto (Supéra-T 2025 I y II)
-- Generado por scripts/oneoff/genera_becas_supera2025.cjs el 2026-09-29.
-- Fuente: BD becarios 2025-II (OP 205), correo Servicios 28/09/2026: Subvención, Dispositivo, Incentivos, Inglés 1 año, Nivelación y ACADÉMICOS del bloque REG. ADM. (incluye titulación; Σ = becas_nueva.presupuesto). BD becarios 2025-I (OP 206), correo Servicios 28/09/2026 (hoja «OP's 2026»): solo ACADÉMICOS del PPTO PROGRAMADO (el BD no desglosa los no académicos; pendiente pedirlo a Servicios).
-- Idempotente. No toca becas_nueva.avance ni avance_beca.
-- Re-aplicable: actualiza solo las filas que cargó este mismo origen (fuente).
-- ====================================================================
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (667, 1, 19085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (668, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 2, 42204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (669, 1, 74886.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (670, 1, 24829.53, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (671, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 2, 42204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (672, 1, 74886.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 2, 42204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (673, 1, 89136.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (674, 1, 19085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (675, 1, 51713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (677, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (678, 1, 64764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (679, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (680, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (681, 1, 24829.53, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (682, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 2, 26102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (837, 1, 65520.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (683, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 2, 12000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (684, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (685, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 2, 16102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (686, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (687, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (688, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 2, 12000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (689, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (690, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (691, 1, 121764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (692, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 2, 16102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (693, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (694, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (676, 1, 76085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (695, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (696, 1, 21797.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (697, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 2, 52204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (839, 1, 54390.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (698, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (699, 1, 94463.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (700, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (701, 1, 121764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 2, 12000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (702, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (703, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 2, 39153.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (833, 1, 86205.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (704, 1, 76085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (705, 1, 23169.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (706, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (707, 1, 180000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (708, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (709, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (710, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 2, 12000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (711, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (712, 1, 64764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 2, 42204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (713, 1, 89136.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (714, 1, 108713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (715, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 2, 52204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (831, 1, 163590.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (716, 1, 80213.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 2, 8000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (717, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (718, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (719, 1, 51713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (720, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (721, 1, 24829.53, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (722, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 2, 48730.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (723, 1, 25610.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (724, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (725, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (727, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (728, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (729, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 2, 48730.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (730, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (731, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 2, 52204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (835, 1, 41790.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 2, 39153.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (834, 1, 29505.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (732, 1, 24829.53, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (733, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 2, 35679.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (734, 1, 38661.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 2, 42204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (735, 1, 60636.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (736, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (737, 1, 108713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 2, 65256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (830, 1, 90825.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (738, 1, 107514.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 2, 12000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (739, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (740, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (741, 1, 64764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (742, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (743, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (744, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 2, 35679.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (745, 1, 81411.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (746, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 2, 16102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (747, 1, 41086.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 2, 5539.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (832, 1, 10342.50, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (748, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (749, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 2, 48730.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (750, 1, 82610.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (751, 1, 194213.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 2, 8000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (752, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (753, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (754, 1, 108713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (755, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (756, 1, 94463.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (757, 1, 34561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (758, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (759, 1, 47585.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (760, 1, 64764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 2, 55256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (761, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (762, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 2, 52204.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (829, 1, 54390.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (763, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 2, 16102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (764, 1, 58238.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (765, 1, 94463.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (766, 1, 47612.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 2, 24000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (767, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (768, 1, 24829.53, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (769, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 2, 91358.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (836, 1, 223545.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 2, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (770, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 2, 9576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (771, 1, 121764.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 2, 22628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (772, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (773, 1, 24406.33, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (774, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (775, 1, 24406.33, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 2, 65256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (838, 1, 119700.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (776, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (777, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (778, 1, 33015.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (779, 1, 24406.33, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (780, 1, 69971.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (781, 1, 33015.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (782, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (783, 1, 35797.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (784, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (785, 1, 21623.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (786, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (787, 1, 35841.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (788, 1, 41591.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (789, 1, 27341.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (790, 1, 121341.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (791, 1, 21623.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (792, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (793, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (794, 1, 64341.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (795, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (796, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (797, 1, 21623.67, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 2, 10000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (798, 1, 47189.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (799, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 2, 39153.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (800, 1, 49437.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (801, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (802, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 2, 65256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (803, 1, 280000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 2, 13051.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (804, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 2, 65256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (805, 1, 66085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (806, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 2, 8000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (807, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 2, 65256.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (808, 1, 66085.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (809, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (810, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (811, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (812, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 2, 26102.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (813, 1, 33988.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (814, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (815, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (816, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (817, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (818, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 2, 81358.40, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (819, 1, 121232.60, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 2, 13051.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (820, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 2, 13051.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (821, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (822, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (823, 1, 41713.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (824, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 2, 19576.80, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (825, 1, 30000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (826, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 2, 13051.20, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (827, 1, 20000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 2, 32628.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 3, 2159.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 4, 1000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 5, 6000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 6, 2000.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (828, 1, 24561.00, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (1, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (2, 1, 13400.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (3, 1, 3630.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (4, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (5, 1, 6680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (6, 1, 5100.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (7, 1, 85419.50, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (8, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (9, 1, 16650.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (10, 1, 6260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (11, 1, 54350.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (12, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (13, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (14, 1, 4680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (15, 1, 35550.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (16, 1, 33854.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (17, 1, 3840.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (18, 1, 152000.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (19, 1, 10980.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (20, 1, 3840.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (21, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (22, 1, 4680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (23, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (24, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (25, 1, 28187.40, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (26, 1, 17180.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (27, 1, 4050.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (28, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (29, 1, 17700.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (30, 1, 33854.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (31, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (32, 1, 3630.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (33, 1, 12660.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (34, 1, 47000.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (35, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (36, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (37, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (38, 1, 3630.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (39, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (40, 1, 32300.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (41, 1, 22514.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (42, 1, 214575.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (43, 1, 44160.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (44, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (45, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (46, 1, 25260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (47, 1, 23270.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (48, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (49, 1, 7515.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (50, 1, 23270.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (51, 1, 21455.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (52, 1, 4680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (53, 1, 6680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (54, 1, 33854.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (55, 1, 133100.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (56, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (57, 1, 3630.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (58, 1, 76429.40, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (59, 1, 4680.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (60, 1, 5840.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (61, 1, 8838.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (62, 1, 6050.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (63, 1, 9305.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (64, 1, 38390.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (65, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (66, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (67, 1, 23270.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (68, 1, 8838.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (69, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (70, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (71, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (72, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (73, 1, 23156.60, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (74, 1, 10350.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (75, 1, 5100.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (76, 1, 25260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (77, 1, 25260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (78, 1, 4260.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (79, 1, 4050.00, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (80, 1, 25689.20, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026')
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;
