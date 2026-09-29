// ─────────────────────────────────────────────────────────────────────────────
// Paso 6 de la fase C: reconstruye beca_orden_pago / beca_orden_pago_detalle a partir
// de los eventos de avance_beca cuyo sustento trae OP ("OP 173-UPS-AS - S/ 990.00").
// NO crea eventos ni toca el avance: cada línea queda PAGADA y enlazada a su evento.
//
// De dónde sale cada dato:
//   - importe, becarios, monto y fecha de cada línea → los eventos de avance_beca
//   - fecha de emisión, informe, concepto, tipo de abono → el bloque de esa OP en el BD
//     de la convocatoria (solo Supéra-T 2025 I y II; «Total (S/.) Académicos a IE's», …)
//   - día de pago, TXT, N° de orden, fecha de ejecución → ESTADO DDMMAAAA.csv de pago-Eli
//   - cuenta del becario / de la IE → la fila del becario en el BD
// Lo que no se puede determinar queda con un valor por defecto y anotado en `observacion`.
//
// Uso: docker compose exec -T app node scripts/oneoff/genera_op_historicas.cjs [/tmp/insumos] [/tmp/pagoeli] [AAAA-MM-DD]
// Salida: scripts/data_becas_op_historicas_<fecha>.sql y un resumen por consola.
// ─────────────────────────────────────────────────────────────────────────────
require('sucrase/register/ts');
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const { leerBloques, norm } = require('./bloques_op_bd.cjs');
const { validarCCI, normalizarDNI, normalizarNombreBanco, soloDigitos } = require('../../src/lib/becas-validacion.ts');
const { extraerOrdenPago } = require('../../src/lib/pagos.ts');

const INSUMOS = process.argv[2] || '/tmp/insumos';
const PAGOELI = process.argv[3] || '/tmp/pagoeli';
const FECHA = process.argv[4] || new Date().toISOString().slice(0, 10);
const RAIZ = path.resolve(__dirname, '..', '..');
const ANIO = 2026;

const sql = (v) => (v === null || v === undefined || v === '' ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const r2 = (n) => Math.round(Number(n) * 100) / 100;
const casi = (a, b) => Math.abs(Number(a) - Number(b)) < 0.005;

// ─── BD de las convocatorias con bloques por OP ──────────────────────────────
const BDS = [
  { grupo: '8 - Beca Supéra-T 2025 II', archivo: path.join(INSUMOS, 'OP205', '2. BD becarios 2025-II_ejecución 2026 OP 205.xlsx'), hoja: 'BD Becarios 2025-II',
    cols: { dni: 'N° Documento de identidad', titular: 'Apellidos y Nombres del Titular de la Cuenta', titularDni: 'DNI Titular Cuenta', cuenta: 'N° Cuenta', cci: 'N° CCI' } },
  { grupo: '8 - Beca Supéra-T 2025 I', archivo: path.join(INSUMOS, 'OP206', '1. BD Becarios 2025-I_ejecución 2026 OP 206.xlsx'), hoja: "OP's 2026",
    cols: { dni: 'N° Documento de identidad', titular: 'Apellidos y Nombres del Titular de la Cuenta', titularDni: 'N° DNI Titular Cuenta', cuenta: 'N° Cuenta', cci: 'Código de Cuenta interbancario (CCI)',
            cuentaContable: 'Cuenta Contable', razonSocial: 'Razón Social de la Institución Educativa', ruc: 'N° RUC', cuentaIE: 'N° Cuenta Bancaria' } },
];

function cargarBD(def) {
  const { datos, iEnc, bloques } = leerBloques(def.archivo, def.hoja);
  const enc = datos[iEnc].map(norm);
  const col = (t, desde = 0) => enc.findIndex((e, k) => k >= desde && e === norm(t));
  const c = Object.fromEntries(Object.entries(def.cols).map(([k, t]) => [k, col(t)]));
  if (c.cuentaIE !== undefined && c.cuentaIE >= 0) c.cciIE = c.cuentaIE + 1;
  const filas = new Map();
  for (let i = iEnc + 1; i < datos.length; i++) {
    const r = datos[i];
    const dni = soloDigitos(r[c.dni]);
    if (!dni) continue;
    filas.set(normalizarDNI(dni), { r, i });
  }
  const porOP = new Map();
  for (const b of bloques) if (b.op) porOP.set(b.op, b);
  return { ...def, c, filas, porOP };
}

function fechaSana(f) {
  if (!f) return { fecha: null, nota: null };
  let [y, m, d] = f.split('-').map(Number);
  if (m > 12 && d <= 12) [m, d] = [d, m]; // los BD mezclan d/m y m/d
  const fecha = `${y}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
  if (y !== ANIO || m > 12 || d > 31) return { fecha: null, nota: `Fecha de OP en el BD: ${f}` };
  return { fecha, nota: null };
}

function conceptoDeBloque(b) {
  const t = norm(b.tipo);
  if (/INGLES/.test(t)) return 'INGLES';
  if (/INCENTIV/.test(t)) return 'INCENTIVO';
  if (/NIVELAC/.test(t)) return 'NIVELACION';
  if (/DISPOSITIVO/.test(t)) return 'DISPOSITIVO';
  if (/NO ACAD/.test(t)) {
    const det = b.detalle.map((d) => norm(d.titulo));
    return det.some((d) => /SUBVENCION|ALIMENTACION/.test(d)) ? 'SUBVENCION' : det.some((d) => /DISPOSITIVO/.test(d)) ? 'DISPOSITIVO' : 'SUBVENCION';
  }
  return 'ACADEMICOS';
}
const tipoAbonoDeBloque = (b) => (/A IE|IE.?S\b/.test(norm(b.tipo)) ? 'IE' : 'BECARIO');
const modalidadDeBloque = (b) => (tipoAbonoDeBloque(b) === 'IE' ? 'ABONO_IE' : /REEMBOLSO/.test(norm(b.tipo)) ? 'REEMBOLSO' : 'ABONO_BECARIO');

// ─── ESTADO*.csv de pago-Eli ─────────────────────────────────────────────────
function leerEstados() {
  const out = new Map();
  if (!fs.existsSync(PAGOELI)) return out;
  for (const dia of fs.readdirSync(PAGOELI)) {
    const f = path.join(PAGOELI, dia, 'ESTADO.csv');
    if (!fs.existsSync(f)) continue;
    const lineas = fs.readFileSync(f, 'utf8').replace(/^﻿/, '').split(/\r?\n/).filter(Boolean);
    const partir = (l) => { const o = []; let cur = '', q = false; for (const ch of l) { if (ch === '"') q = !q; else if (ch === ';' && !q) { o.push(cur); cur = ''; } else cur += ch; } o.push(cur); return o; };
    const enc = partir(lineas[0]);
    for (const l of lineas.slice(1)) {
      const v = Object.fromEntries(partir(l).map((x, i) => [enc[i], x.trim()]));
      const m = String(v.op).match(/^(\d+)-UPS-AS/i);
      if (!m || !/BECA/i.test(v.expediente ?? '')) continue;
      const aISO = (s) => { const x = String(s ?? '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return x ? `${x[3]}-${x[2]}-${x[1]}` : null; };
      out.set(Number(m[1]), {
        dia_pago: `${dia.slice(4, 8)}-${dia.slice(2, 4)}-${dia.slice(0, 2)}`,
        txt: v.txt || null, motivo: v.motivo || '', nro_orden: v.nro_orden || null,
        fecha_ejecucion: aISO(v.fecha_ejecucion), importe_cargado: v.importe_cargado ? Number(v.importe_cargado) : null,
        situacion: v.situacion || '', importe: Number(v.importe),
      });
    }
  }
  return out;
}

(async () => {
  const db = new Client({ connectionString: process.env.DATABASE_URL });
  await db.connect();
  const { rows: eventos } = await db.query(`
    select a.id, a.beca_id, a.fecha::text as fecha, a.monto::float8 as monto, a.sustento,
           b.nombre, lpad(regexp_replace(coalesce(b.documento,''), '\\D', '', 'g'), 8, '0') as dni,
           b.grupo_id, g.descripcion as grupo, b.linea_id, b.institucion_id, i.descripcion as ie, i.ruc as ie_ruc
      from avance_beca a
      join becas_nueva b on b.id = a.beca_id
      left join grupo g on g.id = b.grupo_id
      left join institucion i on i.id = b.institucion_id
     where a.sustento ~* '^\\s*OP\\s' and a.monto > 0
     order by a.id`);
  const { rows: conceptos } = await db.query('select id, codigo from concepto_beca');
  const { rows: bancos } = await db.query('select id, codigo_cci from bancos');
  const { rows: ya } = await db.query('select numero, anio, codigo from beca_orden_pago');
  await db.end();
  const conceptoId = Object.fromEntries(conceptos.map((c) => [c.codigo, c.id]));
  const bancoId = (cci) => bancos.find((b) => b.codigo_cci === String(cci).slice(0, 3))?.id ?? null;

  const bds = BDS.map(cargarBD);
  const estados = leerEstados();

  // Agrupar eventos por número de OP.
  const porOP = new Map();
  const sinNumero = [];
  for (const e of eventos) {
    const ref = extraerOrdenPago(e.sustento);
    const n = Number(ref?.match(/^OP (\d+)/)?.[1]);
    if (!n) { sinNumero.push(e); continue; }
    if (!porOP.has(n)) porOP.set(n, []);
    porOP.get(n).push({ ...e, ref });
  }

  const bloquesSQL = [];
  const resumen = [];
  let conceptoDefecto = 0, lineasTot = 0;
  for (const n of [...porOP.keys()].sort((a, b) => a - b)) {
    const evs = porOP.get(n);
    const codigo = `${n}-UPS-AS/FE-${ANIO}`;
    if (ya.some((o) => Number(o.numero) === n && Number(o.anio) === ANIO)) { resumen.push(`OP ${n}: ya existe en beca_orden_pago, se omite`); continue; }
    const est = estados.get(n);
    const obsCab = [`Reconstruida el ${FECHA} desde ${evs.length} evento(s) de avance_beca (carga histórica, sin crear eventos).`];
    const refs = [...new Set(evs.map((e) => e.ref))];
    if (refs.length > 1) obsCab.push(`Sustentos con referencias distintas: ${refs.join(', ')}.`);

    // Bloque del BD (el de la convocatoria de la mayoría de sus becas).
    let bloque = null, bd = null;
    for (const x of bds) if (evs.some((e) => e.grupo === x.grupo) && x.porOP.has(n)) { bd = x; bloque = x.porOP.get(n); break; }
    const f = fechaSana(bloque?.fechaOP);
    if (f.nota) obsCab.push(f.nota + '.');
    const informe = bloque?.informe ? `${String(bloque.informe).match(/\d+/)[0]}-UPS-AS/FE-${ANIO}` : null;

    const lineas = [];
    for (const e of evs) {
      const obs = [];
      let concepto = 'ACADEMICOS', tipo = null, fila = null;
      if (e.ref !== `OP ${n}-UPS-AS`) obs.push(`Sustento con referencia «${e.ref}».`);
      const bdBeca = bds.find((x) => x.grupo === e.grupo);
      const bl = bdBeca?.porOP.get(n) ?? null;
      if (bl) {
        fila = bdBeca.filas.get(e.dni)?.r ?? null;
        concepto = conceptoDeBloque(bl);
        tipo = tipoAbonoDeBloque(bl);
        if (fila) {
          const vTot = Number(fila[bl.colTotal]) || 0;
          const inc = bl.detalle.find((d) => /^TOTAL .*INCENTIV/.test(norm(d.titulo)));
          const vInc = inc ? Number(fila[inc.col]) || 0 : 0;
          if (casi(e.monto, vTot)) { /* concepto del bloque */ }
          else if (vInc && casi(e.monto, vInc)) concepto = 'INCENTIVO';
          else if (vInc && casi(e.monto, vTot + vInc)) obs.push(`Incluye incentivos adicionales por S/ ${vInc.toFixed(2)} (un solo evento en la bitácora).`);
          else {
            // El monto del evento no es el del bloque (p. ej. OP 97-106: eventos que concentran
            // pagos de varias OP): el concepto no se puede determinar → regla del encargo.
            concepto = concepto === 'ACADEMICOS' ? 'ACADEMICOS' : 'SUBVENCION';
            conceptoDefecto++;
            obs.push(`Concepto no determinado: en el BD el bloque de la OP ${n} trae S/ ${vTot.toFixed(2)}${vInc ? ` + incentivos S/ ${vInc.toFixed(2)}` : ''} para este becario; se registra como ${concepto} según el tipo del bloque.`);
          }
        } else obs.push('El becario no está en el BD de su convocatoria.');
      } else {
        conceptoDefecto++;
        obs.push(`Concepto no determinado (${bdBeca ? 'la OP no tiene bloque en el BD' : 'sin BD de la convocatoria'}): se registra como ACADEMICOS.`);
      }
      if (!tipo) {
        const m = norm(est?.motivo);
        tipo = /RUC|INSTITUC|TIPO R/.test(m) ? 'IE' : /BECARIO|DNI|TIPO L/.test(m) ? 'BECARIO' : /MIBECA/i.test(norm(e.grupo)) ? 'IE' : 'BECARIO';
        if (!est?.motivo) obs.push(`Tipo de abono supuesto (${tipo}).`);
      }

      // Beneficiario y cuenta.
      let benef, doc, docTipo, cci = null, cuenta = null, cuentaContable = null;
      if (tipo === 'IE') {
        const ie = bdBeca?.c.razonSocial >= 0 && fila ? {
          nombre: String(fila[bdBeca.c.razonSocial] ?? '').trim(), ruc: soloDigitos(fila[bdBeca.c.ruc]),
          cuenta: String(fila[bdBeca.c.cuentaIE] ?? '').trim(), cci: soloDigitos(fila[bdBeca.c.cciIE]),
          cc: String(fila[bdBeca.c.cuentaContable] ?? '').trim(),
        } : null;
        benef = ie?.nombre || e.ie || 'INSTITUCION EDUCATIVA';
        doc = ie?.ruc || soloDigitos(e.ie_ruc) || '';
        docTipo = 'RUC';
        cci = ie?.cci || null; cuenta = ie?.cuenta || null; cuentaContable = ie?.cc || null;
        if (!doc) obs.push('RUC de la IE no registrado.');
      } else {
        benef = fila ? String(fila[bdBeca.c.titular] ?? '').trim() || e.nombre : e.nombre;
        doc = fila ? normalizarDNI(soloDigitos(fila[bdBeca.c.titularDni]) || e.dni) : e.dni;
        docTipo = 'DNI';
        if (fila) { cci = soloDigitos(fila[bdBeca.c.cci]) || null; cuenta = String(fila[bdBeca.c.cuenta] ?? '').trim() || null; }
      }
      if (cci && cci.length !== 20) { obs.push(`CCI del BD: ${cci}.`); cci = null; }
      if (cuenta && soloDigitos(cuenta).length === 16 && /^[45]/.test(soloDigitos(cuenta))) cuenta = null;
      if (cci && !validarCCI(cci).valido) obs.push('CCI del BD con dígitos de control no válidos.');
      lineas.push({ e, concepto, tipo, benef: normalizarNombreBanco(benef), doc, docTipo, cci, cuenta, cuentaContable, obs });
    }

    const tipos = new Set(lineas.map((l) => l.tipo));
    const modalidad = bloque ? modalidadDeBloque(bloque) : tipos.size === 1 ? (tipos.has('IE') ? 'ABONO_IE' : 'ABONO_BECARIO') : null;
    const grupos = [...new Set(evs.map((e) => e.grupo_id))];
    const lineaIds = evs.map((e) => e.linea_id);
    const lineaId = lineaIds.sort((a, b) => lineaIds.filter((x) => x === b).length - lineaIds.filter((x) => x === a).length)[0] ?? null;
    const importe = r2(evs.reduce((a, e) => a + e.monto, 0));
    if (est && !casi(est.importe, importe)) obsCab.push(`El ESTADO de pago-Eli dice S/ ${est.importe.toFixed(2)}; la bitácora suma S/ ${importe.toFixed(2)}.`);
    if (est?.situacion) obsCab.push(`pago-Eli: ${est.situacion}.`);

    lineasTot += lineas.length;
    resumen.push(`OP ${String(n).padStart(3)} ${String(evs.length).padStart(3)} lín. S/ ${importe.toFixed(2).padStart(11)} ${bloque ? `BD: ${bloque.tipo}` : 'sin bloque en BD'}${est ? ` · pago-Eli ${est.dia_pago}` : ''}`);

    const cab = `insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios,
   estado, dia_pago, txt_archivo, nro_orden_banco, fecha_ejecucion, importe_cargado, observaciones, created_by)
values (${sql(codigo)}, ${n}, ${ANIO}, ${sql(f.fecha)}, ${sql(informe)}, ${grupos.length === 1 ? grupos[0] : 'null'}, ${lineaId ?? 'null'},
  ${sql(modalidad)}, ${sql(bloque ? bloque.tipo.replace(/^Total \(S\/\.\)\s*/i, '') : null)}, ${importe.toFixed(2)}, ${new Set(evs.map((e) => e.beca_id)).size},
  'PAGADA', ${sql(est?.dia_pago)}, ${sql(est?.txt)}, ${sql(est?.nro_orden)}, ${sql(est?.fecha_ejecucion)}, ${est?.importe_cargado ?? 'null'},
  ${sql(obsCab.join(' '))}, 'carga histórica ${FECHA}')
on conflict (codigo) do nothing;`;
    const det = lineas.map((l) => `insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre, beneficiario_doc_tipo,
   beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, avance_beca_id, observacion)
select op.id, ${l.e.beca_id}, ${conceptoId[l.concepto]}, ${l.e.institucion_id ?? 'null'}, ${sql(l.cuentaContable)}, ${sql(l.tipo)}, ${sql(l.benef)}, ${sql(l.docTipo)},
  ${sql(l.doc) === 'null' ? "''" : sql(l.doc)}, ${l.cci ? bancoId(l.cci) ?? 'null' : 'null'}, ${sql(l.cuenta)}, ${sql(l.cci)}, ${l.e.monto.toFixed(2)}, 'PAGADA', ${l.e.id}, ${sql(l.obs.join(' ') || null)}
  from public.beca_orden_pago op
 where op.codigo = ${sql(codigo)}
   and exists (select 1 from public.avance_beca a where a.id = ${l.e.id} and a.beca_id = ${l.e.beca_id} and a.monto = ${l.e.monto.toFixed(2)})
   and not exists (select 1 from public.beca_orden_pago_detalle x where x.avance_beca_id = ${l.e.id});`);
    bloquesSQL.push(`-- ── OP ${codigo} · ${evs.length} línea(s) · S/ ${importe.toFixed(2)}\n${cab}\n${det.join('\n')}`);
  }

  const encabezado = `-- ====================================================================
-- Paso 6 — Histórico de órdenes de pago de becas (reconstruido desde avance_beca)
-- Generado por scripts/oneoff/genera_op_historicas.cjs el ${FECHA}.
-- Fuente: eventos de avance_beca con sustento «OP nnn-UPS-AS …» (${eventos.length} eventos, ${porOP.size} OP);
--         bloques por OP de los BD de becarios Supéra-T 2025 I y II (correo Servicios 28/09/2026);
--         ESTADO DDMMAAAA.csv de pago-Eli (${[...estados.keys()].length} OP de becas).
-- NO crea eventos ni cambia el avance: cada línea queda PAGADA y enlazada a su evento.
-- Idempotente: la cabecera va con ON CONFLICT DO NOTHING y cada línea solo se inserta si su
-- evento existe con la misma beca y monto y todavía no está enlazado. Si la base cambió,
-- regenerar el script contra esa base.
-- ====================================================================
`;
  const salida = path.join(RAIZ, 'scripts', `data_becas_op_historicas_${FECHA}.sql`);
  fs.writeFileSync(salida, encabezado + bloquesSQL.join('\n\n') + '\n');
  console.log('escrito', path.relative(RAIZ, salida));
  console.log(resumen.join('\n'));
  console.log(`\nOP: ${bloquesSQL.length} · líneas: ${lineasTot} · con concepto por defecto: ${conceptoDefecto} · eventos sin número de OP: ${sinNumero.length}`);
})().catch((e) => { console.error(e); process.exit(1); });
