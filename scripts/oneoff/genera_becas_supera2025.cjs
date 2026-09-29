// ─────────────────────────────────────────────────────────────────────────────
// Genera los scripts de carga de la fase C (pasos 2 a 5) para Supéra-T 2025 I y II
// a partir de los BD de becarios de Servicios (correos del 28/09/2026), y el CSV de
// discrepancias. NO escribe en la base: solo lee (becas_nueva, bancos, concepto_beca)
// y deja los .sql para aplicarlos con psql tras el OK de Jaime.
//
// Uso (dentro del contenedor, con los insumos copiados a /tmp/insumos):
//   docker compose exec -T app node scripts/oneoff/genera_becas_supera2025.cjs [/tmp/insumos] [AAAA-MM-DD]
//
// Salidas:
//   scripts/data_becas_instituciones_<fecha>.sql         paso 2
//   scripts/data_becas_codigos_supera2025_<fecha>.sql    paso 3
//   scripts/data_becas_cuentas_supera2025_<fecha>.sql    paso 4
//   scripts/data_becas_presupuesto_supera2025_<fecha>.sql paso 5
//   respaldos_locales/discrepancias_becas_<fecha>.csv
//
// Los encabezados se buscan por NOMBRE (las posiciones cambian entre convocatorias).
// ─────────────────────────────────────────────────────────────────────────────
require('sucrase/register/ts');
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { Client } = require('pg');
const { validarCCI, normalizarDNI, normalizarCodigoConvenio, soloDigitos } = require('../../src/lib/becas-validacion.ts');
const { leerAnexo02 } = require('../../src/lib/anexo02.ts');

const INSUMOS = process.argv[2] || '/tmp/insumos';
const FECHA = process.argv[3] || new Date().toISOString().slice(0, 10);
const RAIZ = path.resolve(__dirname, '..', '..');
const BD_2025_II = path.join(INSUMOS, 'OP205', '2. BD becarios 2025-II_ejecución 2026 OP 205.xlsx');
const BD_2025_I = path.join(INSUMOS, 'OP206', '1. BD Becarios 2025-I_ejecución 2026 OP 206.xlsx');
const FUENTE_II = 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026';
const FUENTE_I = 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026';

const norm = (s) => String(s ?? '').normalize('NFD').replace(/[̀-ͯ]/g, '').toUpperCase().replace(/[^A-Z0-9 ]/g, ' ').replace(/\s+/g, ' ').trim();
const sql = (v) => (v === null || v === undefined || v === '' ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const num = (v) => {
  if (v === null || v === undefined || v === '') return null;
  const n = typeof v === 'number' ? v : Number(String(v).replace(/[^0-9.-]/g, ''));
  return Number.isFinite(n) ? Math.round(n * 100) / 100 : null;
};
const tokens = (s) => new Set(norm(s).split(' ').filter((t) => t.length > 1));
function mismoNombre(a, b) {
  const A = tokens(a), B = tokens(b);
  let comunes = 0;
  for (const t of A) if (B.has(t)) comunes++;
  return comunes >= Math.min(3, Math.min(A.size, B.size));
}

// ─── Lectura de hojas por nombre de encabezado ────────────────────────────────
function leerHoja(archivo, hoja, claveEncabezado) {
  const wb = XLSX.readFile(archivo, { sheetRows: 3000 });
  const nombre = wb.SheetNames.find((s) => s.trim() === hoja.trim());
  if (!nombre) throw new Error(`No existe la hoja «${hoja}» en ${path.basename(archivo)}`);
  const datos = XLSX.utils.sheet_to_json(wb.Sheets[nombre], { header: 1, defval: '', raw: true });
  const iEnc = datos.findIndex((r) => r.some((c) => norm(c) === norm(claveEncabezado)));
  if (iEnc < 0) throw new Error(`No encontré el encabezado «${claveEncabezado}» en «${hoja}»`);
  const enc = datos[iEnc].map(norm);
  // Busca la columna cuyo encabezado calza (exacto primero, luego «empieza con»), desde `desde`.
  const col = (texto, { desde = 0, contiene = false } = {}) => {
    const t = norm(texto);
    let i = enc.findIndex((e, k) => k >= desde && e === t);
    if (i < 0) i = enc.findIndex((e, k) => k >= desde && (contiene ? e.includes(t) : e.startsWith(t)));
    return i;
  };
  return { datos, iEnc, enc, col };
}

// ─── BD 2025-II ──────────────────────────────────────────────────────────────
function leerBD2025II() {
  const h = leerHoja(BD_2025_II, 'BD Becarios 2025-II', 'N° Documento de identidad');
  const c = {
    convenio: h.col('Código legal Convenio'),
    nombre: h.col('APELLIDOS Y NOMBRES DEL BECARIO'),
    dni: h.col('N° Documento de identidad'),
    ie: h.col('Nombre de la Institución Educativa'),
    titularTipo: h.col('Titular de la Cuenta', { contiene: true }),
    titularNombre: h.col('Apellidos y Nombres del Titular de la Cuenta'),
    titularDni: h.col('DNI Titular Cuenta'),
    cuenta: h.col('N° Cuenta'),
    cci: h.col('N° CCI'),
    banco: h.col('Entidad Bancaria'),
    condicion: h.col('CONDICIÓN DEL BECARIO'),
    subvencion: h.col('Subvención'),                 // total (no la cuota/mes)
    dispositivo: h.col('Dispositivo Electrónico'),
    incentivos: h.col('Incentivos adicionales'),
    ingles: h.col('Inglés 1 año'),
    nivelacion: h.col('Nivelación'),
    noAcad: h.col('COSTOS NO ACADÉMICOS'),
    titulacion: h.col('Gastos de Titulación'),
    acad: h.col('COSTOS ACADÈMICOS'),
    total: h.col('PRESUPUESTO TOTAL'),
    // Bloque «REGISTRO ADM.»: COSTOS NO ACADÉMICOS / ACADÉMICOS / PRESUPUESTO TOTAL. Es el que
    // cuadra con becas_nueva.presupuesto; los no académicos son iguales al programado.
    acadRegAdm: h.col('ACADÉMICOS'),
  };
  c.totalRegAdm = h.col('PRESUPUESTO TOTAL', { desde: c.acadRegAdm });
  for (const [k, v] of Object.entries(c)) if (v < 0) throw new Error(`BD 2025-II: falta la columna ${k}`);
  // El código interno (CU-/CT-) no tiene encabezado: es la columna anterior al convenio.
  c.interno = c.convenio - 1;
  const filas = [];
  for (let i = h.iEnc + 1; i < h.datos.length; i++) {
    const r = h.datos[i];
    const dni = soloDigitos(r[c.dni]);
    if (!dni || !String(r[c.nombre]).trim()) continue;
    filas.push({
      fila: i + 1,
      convocatoria: '2025-II',
      interno: String(r[c.interno] ?? '').trim() || null,
      convenio: normalizarCodigoConvenio(String(r[c.convenio] ?? '')),
      nombre: String(r[c.nombre]).trim(),
      dni: normalizarDNI(dni),
      ie: String(r[c.ie] ?? '').trim(),
      condicion: String(r[c.condicion] ?? '').trim(),
      titularTipo: String(r[c.titularTipo] ?? '').trim(),
      titularNombre: String(r[c.titularNombre] ?? '').trim(),
      titularDni: soloDigitos(r[c.titularDni]),
      cuenta: String(r[c.cuenta] ?? '').trim(),
      cci: String(r[c.cci] ?? '').trim(),
      banco: String(r[c.banco] ?? '').trim(),
      ppto: {
        SUBVENCION: num(r[c.subvencion]),
        DISPOSITIVO: num(r[c.dispositivo]),
        INCENTIVO: num(r[c.incentivos]),
        INGLES: num(r[c.ingles]),
        NIVELACION: num(r[c.nivelacion]),
        // Decisión 29/09/2026: ACADEMICOS = «ACADÉMICOS» del bloque REG. ADM. (incluye titulación,
        // que se paga como ACADEMICOS); el programado «COSTOS ACADÈMICOS» queda solo como referencia.
        ACADEMICOS: num(r[c.acadRegAdm]),
      },
      noAcad: num(r[c.noAcad]),
      acadTotal: num(r[c.acadRegAdm]),
      acadProgramado: num(r[c.acad]),
      titulacion: num(r[c.titulacion]),
      total: num(r[c.totalRegAdm]),
      totalProgramado: num(r[c.total]),
    });
  }
  return filas;
}

// ─── BD 2025-I (hoja «OP's 2026») ─────────────────────────────────────────────
function leerBD2025I() {
  const h = leerHoja(BD_2025_I, "OP's 2026", 'N° Documento de identidad');
  const c = {
    nombre: h.col('Apellidos y Nombres del Becario'),
    dni: h.col('N° Documento de identidad'),
    ie: h.col('Nombre de la Institución Educativa'),
    condicion: h.col('CONDICIÓN DEL BECARIO'),
    titularTipo: h.col('Titular de la Cuenta', { contiene: true }),
    titularNombre: h.col('Apellidos y Nombres del Titular de la Cuenta'),
    titularDni: h.col('N° DNI Titular Cuenta'),
    cuenta: h.col('N° Cuenta'),
    cci: h.col('Código de Cuenta interbancario (CCI)'),
    banco: h.col('Entidad Bancaria'),
    cuentaContable: h.col('Cuenta Contable'),
    razonSocial: h.col('Razón Social de la Institución Educativa'),
    ruc: h.col('N° RUC'),
    cuentaIE: h.col('N° Cuenta Bancaria'),
  };
  for (const [k, v] of Object.entries(c)) if (v < 0) throw new Error(`BD 2025-I: falta la columna ${k}`);
  c.cciIE = h.col('Código de Cuenta Interbancario (CCI)', { desde: c.cuentaIE });
  c.bancoIE = h.col('Entidad Bancaria', { desde: c.cuentaIE });
  // Totales programados (NO ACADÉMICOS, ACADÉMICOS, TOTAL): su encabezado «PPTO PROGRAMADO /
  // COSTOS NO ACADÉMICOS» está en las filas de arriba del encabezado principal.
  c.noAcad = -1;
  for (let i = 0; i < h.iEnc && c.noAcad < 0; i++) {
    c.noAcad = h.datos[i].findIndex((x) => norm(x) === 'COSTOS NO ACADEMICOS');
  }
  const filas = [];
  for (let i = h.iEnc + 1; i < h.datos.length; i++) {
    const r = h.datos[i];
    const dni = soloDigitos(r[c.dni]);
    if (!dni || !String(r[c.nombre]).trim()) continue;
    filas.push({
      fila: i + 1,
      convocatoria: '2025-I',
      nombre: String(r[c.nombre]).trim(),
      dni: normalizarDNI(dni),
      ie: String(r[c.ie] ?? '').trim(),
      condicion: String(r[c.condicion] ?? '').trim(),
      titularTipo: String(r[c.titularTipo] ?? '').trim(),
      titularNombre: String(r[c.titularNombre] ?? '').trim(),
      titularDni: soloDigitos(r[c.titularDni]),
      cuenta: String(r[c.cuenta] ?? '').trim(),
      cci: String(r[c.cci] ?? '').trim(),
      banco: String(r[c.banco] ?? '').trim(),
      ieDatos: {
        cuentaContable: String(r[c.cuentaContable] ?? '').trim(),
        razonSocial: String(r[c.razonSocial] ?? '').trim(),
        ruc: soloDigitos(r[c.ruc]),
        cuenta: String(r[c.cuentaIE] ?? '').trim(),
        cci: c.cciIE >= 0 ? String(r[c.cciIE] ?? '').trim() : '',
        banco: c.bancoIE >= 0 ? String(r[c.bancoIE] ?? '').trim() : '',
      },
      noAcad: c.noAcad >= 0 ? num(r[c.noAcad]) : null,
      acadTotal: c.noAcad >= 0 ? num(r[c.noAcad + 1]) : null,
      total: c.noAcad >= 0 ? num(r[c.noAcad + 2]) : null,
    });
  }
  return filas;
}

// ─── Principal ───────────────────────────────────────────────────────────────
(async () => {
  const db = new Client({ connectionString: process.env.DATABASE_URL });
  await db.connect();
  const { rows: becas } = await db.query(`
    select b.id, b.nombre, lpad(regexp_replace(coalesce(b.documento,''), '\\D', '', 'g'), 8, '0') as dni,
           b.grupo_id, g.descripcion as grupo, c.descripcion as condicion, b.presupuesto::float8 as presupuesto,
           b.codigo_convenio, b.codigo_interno, i.descripcion as ie
      from becas_nueva b
      left join grupo g on g.id = b.grupo_id
      left join condicion c on c.id = b.condicion_id
      left join institucion i on i.id = b.institucion_id
     where g.descripcion in ('8 - Beca Supéra-T 2025 I', '8 - Beca Supéra-T 2025 II')`);
  const { rows: bancos } = await db.query('select id, codigo_cci, sigla, nombre from bancos');
  const { rows: conceptos } = await db.query('select id, codigo from concepto_beca');
  const { rows: instituciones } = await db.query('select id, descripcion, ruc from institucion');
  await db.end();

  const conceptoId = Object.fromEntries(conceptos.map((c) => [c.codigo, c.id]));
  const disc = [];
  const D = (paso, convocatoria, fila, dni, nombre, becaId, tipo, detalle) =>
    disc.push({ paso, convocatoria, fila, dni, nombre, becaId, tipo, detalle });

  const bd = [...leerBD2025II(), ...leerBD2025I()];
  const grupoDe = { '2025-II': '8 - Beca Supéra-T 2025 II', '2025-I': '8 - Beca Supéra-T 2025 I' };

  // Emparejar por DNI dentro del grupo de la convocatoria.
  const emparejadas = [];
  const usadas = new Set();
  for (const f of bd) {
    const cands = becas.filter((b) => b.grupo === grupoDe[f.convocatoria] && b.dni === f.dni);
    if (cands.length === 0) {
      const porNombre = becas.filter((b) => b.grupo === grupoDe[f.convocatoria] && mismoNombre(b.nombre, f.nombre));
      D('3', f.convocatoria, f.fila, f.dni, f.nombre, porNombre[0]?.id ?? '', 'BD sin beca en fondo2',
        porNombre.length ? `Por nombre calza con id ${porNombre[0].id} (DNI fondo2 ${porNombre[0].dni}); no se carga` : `Condición en el BD: ${f.condicion || '—'}`);
      continue;
    }
    if (cands.length > 1) {
      D('3', f.convocatoria, f.fila, f.dni, f.nombre, cands.map((b) => b.id).join(' '), 'DNI repetido en fondo2', 'Más de una beca con este DNI en el grupo; no se carga');
      continue;
    }
    const b = cands[0];
    if (usadas.has(b.id)) {
      D('3', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Becario repetido en el BD', 'Otra fila del BD ya se emparejó con esta beca; no se carga');
      continue;
    }
    usadas.add(b.id);
    if (!mismoNombre(b.nombre, f.nombre)) D('3', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Nombre distinto', `fondo2: ${b.nombre}`);
    const condBD = norm(f.condicion);
    if (condBD && norm(b.condicion) !== condBD) D('3', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Condición distinta', `BD: ${f.condicion} · fondo2: ${b.condicion ?? '—'}`);
    emparejadas.push({ f, b });
  }
  for (const b of becas) {
    if (!usadas.has(b.id)) D('3', b.grupo.endsWith('II') ? '2025-II' : '2025-I', '', b.dni, b.nombre, b.id, 'Beca de fondo2 sin fila en el BD', `Condición fondo2: ${b.condicion ?? '—'}`);
  }

  const bancoPorCCI = (cci) => bancos.find((k) => k.codigo_cci === cci.slice(0, 3)) ?? null;
  const bancoPorTexto = (t) => {
    const x = norm(t);
    if (!x) return null;
    return bancos.find((k) => norm(k.sigla) === x || norm(k.nombre) === x) ?? bancos.find((k) => norm(k.nombre).includes(x) || x.includes(norm(k.sigla))) ?? null;
  };

  // ── Paso 2: instituciones (RUC y cuenta de la IE) ──
  // Abono directo confirmado en los Anexos: UPN (OP 206 y 207). Del BD 2025-I se
  // recogen además RUC/cuenta de las demás IE para mostrárselos a Jaime (no se cargan).
  const ieBD = new Map();
  for (const f of bd.filter((x) => x.ieDatos && x.ieDatos.ruc)) {
    const k = f.ieDatos.ruc;
    if (!ieBD.has(k)) ieBD.set(k, { ...f.ieDatos, nombres: new Set(), becarios: 0 });
    const e = ieBD.get(k);
    e.nombres.add(f.ie);
    e.becarios++;
  }
  const anexosIE = [];
  for (const dir of ['OP206', 'OP207']) {
    const f = fs.readdirSync(path.join(INSUMOS, dir)).find((x) => /anexo/i.test(x) && x.endsWith('.xlsx'));
    for (const l of leerAnexo02(fs.readFileSync(path.join(INSUMOS, dir, f))).filas) if (l.ruc_ie) anexosIE.push({ op: dir, ...l });
  }
  const iesAnexo = new Map();
  for (const l of anexosIE) iesAnexo.set(l.ruc_ie, l);
  const sqlIE = [];
  const propuestaIE = [];
  for (const [ruc, l] of iesAnexo) {
    const cands = instituciones.filter((i) => norm(i.descripcion).startsWith(norm(l.institucion)) || norm(i.descripcion).includes(norm(l.institucion)));
    const cci = validarCCI(l.cci);
    const banco = cci.codigoBanco ? bancoPorCCI(cci.cci) : null;
    if (cands.length !== 1) {
      D('2', '', '', ruc, l.institucion, cands.map((c) => c.id).join(' '), 'IE dudosa', `${cands.length} instituciones calzan por nombre; no se carga`);
      continue;
    }
    propuestaIE.push(`${cands[0].id} ${cands[0].descripcion} ← RUC ${ruc}, ${banco?.sigla ?? '?'} ${l.numero_cuenta}, CCI ${cci.cci} (${cci.valido ? 'válido' : 'NO válido'})`);
    sqlIE.push(`-- ${cands[0].descripcion}: Anexo 02 de las ${anexosIE.filter((x) => x.ruc_ie === ruc).map((x) => x.op).filter((v, i, a) => a.indexOf(v) === i).join(' y ')}
update public.institucion
   set ruc = coalesce(ruc, ${sql(ruc)}),
       tiene_convenio = true,
       banco_id = coalesce(banco_id, ${banco ? banco.id : 'null'}),
       cuenta_bancaria = coalesce(cuenta_bancaria, ${sql(l.numero_cuenta)}),
       cci = coalesce(cci, ${sql(cci.cci)}),
       observacion = coalesce(observacion, ${sql(`Cuenta tomada del Anexo 02 (${FECHA}); CCI ${cci.valido ? 'con dígitos de control válidos' : 'NO válido'}. Cuenta contable por convocatoria: va en la línea de la OP.`)})
 where id = ${cands[0].id};`);
  }
  const otrasIE = [...ieBD.values()].filter((e) => !iesAnexo.has(e.ruc));

  // ── Paso 3: códigos ──
  const sqlCod = [];
  for (const { f, b } of emparejadas) {
    if (f.convocatoria !== '2025-II') continue; // el BD 2025-I no trae código de convenio ni interno
    if (!f.convenio && !f.interno) continue;
    if (b.codigo_convenio && f.convenio && b.codigo_convenio !== f.convenio) D('3', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Código de convenio distinto', `fondo2 ${b.codigo_convenio} · BD ${f.convenio}`);
    sqlCod.push(`update public.becas_nueva set codigo_convenio = coalesce(codigo_convenio, ${sql(f.convenio)}), codigo_interno = coalesce(codigo_interno, ${sql(f.interno)}) where id = ${b.id}; -- ${f.nombre}`);
  }
  const convDup = new Map();
  for (const { f } of emparejadas) if (f.convenio) convDup.set(f.convenio, [...(convDup.get(f.convenio) ?? []), f.nombre]);
  for (const [cv, ns] of convDup) if (ns.length > 1) D('3', '', '', '', ns.join(' / '), '', 'Código de convenio compartido', `${cv} lo usan ${ns.length} becarios (suele ser un convenio con la IE, no con el becario)`);

  // ── Paso 4: cuentas ──
  const sqlCta = [];
  let validas = 0, noValidas = 0;
  for (const { f, b } of emparejadas) {
    const fuente = f.convocatoria === '2025-II' ? FUENTE_II : FUENTE_I;
    if (!f.cci && !f.cuenta) { D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Sin cuenta', 'El BD no trae cuenta ni CCI'); continue; }
    const cci = validarCCI(f.cci);
    const banco = cci.cci.length === 20 ? bancoPorCCI(cci.cci) : null;
    const obs = [];
    if (cci.valido) validas++; else { noValidas++; D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'CCI no válido', `${f.cci} · ${cci.motivo}`); }
    const declarado = bancoPorTexto(f.banco);
    if (banco && declarado && declarado.codigo_cci !== banco.codigo_cci) {
      obs.push(`El BD dice «${f.banco}» pero el CCI es de ${banco.sigla}`);
      D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Banco no coincide con el CCI', `BD: ${f.banco} · CCI: ${banco.sigla} (${banco.codigo_cci})`);
    }
    if (cci.codigoBanco && cci.cci.length === 20 && !banco) D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Banco fuera del catálogo', `Código CCI ${cci.codigoBanco} (${f.banco})`);
    const esBecario = /BECARIO/i.test(f.titularTipo) || (f.titularDni && normalizarDNI(f.titularDni) === f.dni);
    const titularDni = f.titularDni ? normalizarDNI(f.titularDni) : (esBecario ? f.dni : null);
    if (!titularDni) { D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Sin DNI del titular', `Titular: ${f.titularNombre || '—'}; no se carga`); continue; }
    if (!esBecario) obs.push(`Titular: ${f.titularTipo || 'aval'}`);
    let numeroCuenta = f.cuenta || null;
    if (numeroCuenta && soloDigitos(numeroCuenta).length === 16 && /^[45]/.test(soloDigitos(numeroCuenta))) {
      obs.push('En «N° cuenta» venía un número con forma de tarjeta; no se guarda');
      D('4', f.convocatoria, f.fila, f.dni, f.nombre, b.id, 'Número de tarjeta en la cuenta', 'Se deja solo el CCI');
      numeroCuenta = null;
    }
    if (cci.cci && cci.cci.length !== 20) obs.push(`CCI en el BD: ${f.cci}`);
    sqlCta.push(`insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select ${b.id}, ${sql(esBecario ? 'BECARIO' : 'AVAL')}, ${sql(f.titularNombre || f.nombre)}, ${sql(titularDni)}, ${banco ? banco.id : 'null'}, ${sql(numeroCuenta)}, ${sql(cci.cci.length === 20 ? cci.cci : null)}, ${cci.valido}, true, ${sql(fuente)}, ${sql(obs.join('. ') || null)}
where not exists (select 1 from public.beca_cuenta where beca_id = ${b.id} and vigente);`);
  }

  // ── Paso 5: presupuesto ──
  //   2025-II: por concepto (Subvención, Dispositivo, Incentivos, Inglés, Nivelación) + ACADEMICOS del REG. ADM.
  //   2025-I:  el BD no trae el desglose de no académicos: solo se carga ACADEMICOS (decisión 29/09/2026).
  for (const { f } of emparejadas) if (f.convocatoria === '2025-I') f.ppto = { ACADEMICOS: f.acadTotal };
  const sqlPre = [];
  const totPorGrupo = {};
  for (const { f, b } of emparejadas) {
    const g = f.convocatoria;
    totPorGrupo[g] ??= { bd: 0, fondo2: 0, cargado: 0, n: 0 };
    totPorGrupo[g].bd += f.total ?? 0;
    totPorGrupo[g].fondo2 += b.presupuesto ?? 0;
    totPorGrupo[g].n++;
    if (f.total !== null && b.presupuesto !== null && Math.abs(f.total - b.presupuesto) >= 0.01) {
      D('5', g, f.fila, f.dni, f.nombre, b.id, 'Presupuesto total distinto', `BD ${f.total.toFixed(2)} · fondo2 ${Number(b.presupuesto).toFixed(2)}`);
    }
    const suma = Object.values(f.ppto).reduce((a, v) => a + (v ?? 0), 0);
    if (g === '2025-II' && f.total !== null && Math.abs(suma - f.total) >= 0.01) D('5', g, f.fila, f.dni, f.nombre, b.id, 'Conceptos no suman el total', `Σ conceptos ${suma.toFixed(2)} · PRESUPUESTO TOTAL (REG. ADM.) ${f.total.toFixed(2)}`);
    const fuente = g === '2025-II' ? FUENTE_II : FUENTE_I;
    for (const [cod, monto] of Object.entries(f.ppto)) {
      if (monto === null || monto === 0) continue;
      totPorGrupo[g].cargado += monto;
      sqlPre.push(`insert into public.beca_presupuesto (beca_id, concepto_id, programado, fuente) values (${b.id}, ${conceptoId[cod]}, ${monto.toFixed(2)}, ${sql(fuente)})
on conflict (beca_id, concepto_id) do update set programado = excluded.programado, updated_at = now() where beca_presupuesto.fuente = excluded.fuente;`);
    }
  }

  // ── Escribir archivos ──
  const cab = (titulo, fuente, extra = '') => `-- ====================================================================
-- ${titulo}
-- Generado por scripts/oneoff/genera_becas_supera2025.cjs el ${FECHA}.
-- Fuente: ${fuente}
-- Idempotente. No toca becas_nueva.avance ni avance_beca.${extra}
-- ====================================================================
`;
  const out = (nombre, texto) => { fs.writeFileSync(path.join(RAIZ, 'scripts', nombre), texto); console.log('escrito scripts/' + nombre); };
  out(`data_becas_instituciones_${FECHA}.sql`, cab('Paso 2 — RUC y cuenta de las IE con abono directo', 'Anexo 02 de las OP 206 y 207 (UPN).', '\n-- Solo completa campos vacíos (coalesce): no pisa lo editado en Catálogos.') + sqlIE.join('\n\n') + '\n');
  out(`data_becas_codigos_supera2025_${FECHA}.sql`, cab('Paso 3 — becas_nueva.codigo_convenio / codigo_interno (Supéra-T 2025 II)', FUENTE_II + ', emparejado por DNI.', '\n-- El BD 2025-I no trae código de convenio ni código interno.') + sqlCod.join('\n') + '\n');
  out(`data_becas_cuentas_supera2025_${FECHA}.sql`, cab('Paso 4 — beca_cuenta vigente (Supéra-T 2025 I y II)', `${FUENTE_II}; ${FUENTE_I} (hoja «OP's 2026»). Emparejado por DNI.`, '\n-- Solo inserta si la beca no tiene ya una cuenta vigente.') + sqlCta.join('\n') + '\n');
  out(`data_becas_presupuesto_supera2025_${FECHA}.sql`, cab('Paso 5 — beca_presupuesto por concepto (Supéra-T 2025 I y II)',
    `${FUENTE_II}: Subvención, Dispositivo, Incentivos, Inglés 1 año, Nivelación y ACADÉMICOS del bloque REG. ADM. ` +
    `(incluye titulación; Σ = becas_nueva.presupuesto). ${FUENTE_I} (hoja «OP's 2026»): solo ACADÉMICOS del PPTO PROGRAMADO ` +
    '(el BD no desglosa los no académicos; pendiente pedirlo a Servicios).',
    '\n-- Re-aplicable: actualiza solo las filas que cargó este mismo origen (fuente).') + sqlPre.join('\n') + '\n');

  const csv = ['paso;convocatoria;fila_bd;dni;nombre;beca_id;tipo;detalle', ...disc.map((d) => [d.paso, d.convocatoria, d.fila, d.dni, d.nombre, d.becaId, d.tipo, d.detalle].map((v) => `"${String(v ?? '').replace(/"/g, '""')}"`).join(';'))].join('\r\n');
  const csvPath = path.join(RAIZ, 'respaldos_locales', `discrepancias_becas_${FECHA}.csv`);
  fs.writeFileSync(csvPath, '﻿' + csv);
  console.log('escrito respaldos_locales/' + path.basename(csvPath));

  // ── Resumen ──
  const cuenta = (t) => disc.filter((d) => d.tipo === t).length;
  console.log('\n== RESUMEN');
  console.log(`BD 2025-II: ${bd.filter((f) => f.convocatoria === '2025-II').length} filas · BD 2025-I: ${bd.filter((f) => f.convocatoria === '2025-I').length} filas`);
  console.log(`Emparejadas por DNI: ${emparejadas.length} (2025-II ${emparejadas.filter((e) => e.f.convocatoria === '2025-II').length}, 2025-I ${emparejadas.filter((e) => e.f.convocatoria === '2025-I').length})`);
  console.log(`Paso 2: ${sqlIE.length} IE → ${propuestaIE.join(' | ')}`);
  console.log(`        otras IE con RUC/cuenta en el BD 2025-I (no se cargan): ${otrasIE.length}`);
  for (const e of otrasIE) console.log(`          RUC ${e.ruc} ${[...e.nombres][0]} · ${e.banco} ${e.cuenta} · CCI ${soloDigitos(e.cci)} (${validarCCI(e.cci).valido ? 'válido' : 'NO válido'}) · ${e.becarios} becarios`);
  console.log(`Paso 3: ${sqlCod.length} becas con código`);
  console.log(`Paso 4: ${sqlCta.length} cuentas · CCI válidos ${validas} · no válidos ${noValidas}`);
  console.log(`Paso 5: ${sqlPre.length} filas de presupuesto`);
  for (const [g, t] of Object.entries(totPorGrupo)) console.log(`        ${g}: ${t.n} becas · Σ PRESUPUESTO TOTAL BD ${t.bd.toFixed(2)} · Σ becas_nueva.presupuesto ${t.fondo2.toFixed(2)} · cargado por concepto ${t.cargado.toFixed(2)}`);
  console.log('Discrepancias por tipo:');
  for (const t of [...new Set(disc.map((d) => d.tipo))]) console.log(`   ${String(cuenta(t)).padStart(4)}  ${t}`);
})().catch((e) => { console.error(e); process.exit(1); });
