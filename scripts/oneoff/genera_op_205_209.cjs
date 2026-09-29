// ─────────────────────────────────────────────────────────────────────────────
// Paso 7 de la fase C: OP 205 a 209 (pendientes de pago) desde sus Anexo 02.
// Misma lectura y validación que la pantalla «Importar Anexo 02» (src/lib/anexo02.ts y
// src/lib/becas-validacion.ts), más las correcciones puntuales acordadas en el encargo,
// cada una anotada en `observacion` / `observaciones`.
//
// Uso: docker compose exec -T app node scripts/oneoff/genera_op_205_209.cjs [/tmp/insumos] [AAAA-MM-DD]
// Salida: scripts/data_becas_op_205_209_<fecha>.sql
// ─────────────────────────────────────────────────────────────────────────────
require('sucrase/register/ts');
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const { leerAnexo02, periodoDeGlosa, pareceTarjeta } = require('../../src/lib/anexo02.ts');
const { validarCCI, validarLineaOP, resolverConcepto, normalizarNombreBanco, soloDigitos, cuadraTotal } = require('../../src/lib/becas-validacion.ts');

const INSUMOS = process.argv[2] || '/tmp/insumos';
const FECHA = process.argv[3] || new Date().toISOString().slice(0, 10);
const RAIZ = path.resolve(__dirname, '..', '..');

// Cabeceras según la tabla del encargo y los PDF de la OP (fecha de solicitud 28/09/2026).
const OPS = [
  { dir: 'OP205', numero: 205, informe: '209-UPS-AS/FE-2026', modalidad: 'REEMBOLSO', grupo: '8 - Beca Supéra-T 2025 II', importe: 6258.27, lineas: 8,
    periodo: '2026-II', obs: 'El Anexo tiene 169 filas ocultas (becarios que no cobran) y la hoja «ANEXO 2 (2)» es la copia de la muestra: no se cargan.' },
  { dir: 'OP206', numero: 206, informe: '210-UPS-AS/FE-2026', modalidad: 'ABONO_IE', grupo: '8 - Beca Supéra-T 2025 I', importe: 2221.96, lineas: 2,
    obs: 'El PDF de la OP dice «N° 209-UPS-AS/FE-2026», pero su importe (S/ 2,221.96) y su Anexo son los de la 206: se registra como 206. La hoja de pago del Anexo es «ANEXO 2(2)» («ANEXO 2» está oculta).' },
  { dir: 'OP207', numero: 207, informe: '211-UPS-AS/FE-2026', modalidad: 'ABONO_IE', grupo: '8 - Beca Supéra-T 2025 II', importe: 10811.99, lineas: 6,
    obs: 'La «Hoja2» del Anexo es la copia de la muestra: no se carga.' },
  { dir: 'OP208', numero: 208, informe: '212-UPS-AS/FE-2026', modalidad: 'REEMBOLSO', grupo: '8 - Beca Supéra-T 2025 I', importe: 1204.0, lineas: 3,
    obs: 'Reembolso de matrícula, derechos académicos y gastos de titulación (Informe 212); el Anexo lo consigna como OTR-0006-ACADEMICOS y se registra como ACADEMICOS (decisión del 29/09/2026).' },
  { dir: 'OP209', numero: 209, informe: '213-UPS-AS/FE-2026', modalidad: 'REEMBOLSO', grupo: '8 - Beca Supéra-T 2025 I', importe: 1682.92, lineas: 5,
    obs: 'Reembolso de inglés e incentivos (5 líneas, 4 becarios). La «Hoja2» del Anexo (8 becarios, S/ 3,186.28) es la OP 179 ya pagada: no se carga.' },
];

const sql = (v) => (v === null || v === undefined || v === '' ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const normTxt = (s) => String(s ?? '').normalize('NFD').replace(/[̀-ͯ]/g, '').toUpperCase().replace(/[^A-Z0-9 ]/g, ' ').replace(/\s+/g, ' ').trim();
const tokens = (s) => new Set(normTxt(s).split(' ').filter((t) => t.length > 1));
const mismoNombre = (a, b) => { const A = tokens(a), B = tokens(b); let n = 0; for (const t of A) if (B.has(t)) n++; return n >= Math.min(3, A.size, B.size); };

(async () => {
  const db = new Client({ connectionString: process.env.DATABASE_URL });
  await db.connect();
  const { rows: becas } = await db.query(`
    select b.id, b.nombre, lpad(regexp_replace(coalesce(b.documento,''), '\\D', '', 'g'), 8, '0') as dni, b.grupo_id, g.descripcion as grupo,
           b.linea_id, b.institucion_id, c.descripcion as condicion
      from becas_nueva b left join grupo g on g.id = b.grupo_id left join condicion c on c.id = b.condicion_id`);
  const { rows: conceptos } = await db.query('select id, codigo, nombre, tipo, abono_por_defecto, codigos_anexo from concepto_beca');
  const { rows: bancos } = await db.query('select id, codigo_cci, sigla, nombre from bancos');
  const { rows: instituciones } = await db.query('select id, descripcion, ruc from institucion');
  const { rows: grupos } = await db.query('select id, descripcion from grupo');
  await db.end();

  const bancoPorTexto = (t) => {
    const x = normTxt(t);
    if (!x) return null;
    return bancos.find((b) => normTxt(b.sigla) === x || normTxt(b.nombre) === x) ?? bancos.find((b) => normTxt(b.nombre).includes(x) || x.split(' ').includes(normTxt(b.sigla))) ?? null;
  };

  const partes = [];
  for (const op of OPS) {
    const archivo = fs.readdirSync(path.join(INSUMOS, op.dir)).find((x) => /anexo/i.test(x) && x.endsWith('.xlsx'));
    const lectura = leerAnexo02(fs.readFileSync(path.join(INSUMOS, op.dir, archivo)));
    const grupoId = grupos.find((g) => g.descripcion === op.grupo)?.id;
    const codigo = `${op.numero}-UPS-AS/FE-2026`;
    const lineas = [];
    for (const f of lectura.filas) {
      const obs = [];
      let beca = becas.filter((b) => b.dni === f.dni);
      if (beca.length > 1) beca = beca.filter((b) => b.grupo_id === grupoId);
      beca = beca[0] ?? null;
      if (!beca) {
        // Caso Llicán (OP 206): el Anexo trae el DNI del aval. Se busca por nombre dentro del grupo.
        const nombre = f.becario ?? f.titular;
        const cands = becas.filter((b) => b.grupo_id === grupoId && mismoNombre(b.nombre, nombre));
        if (cands.length === 1) {
          beca = cands[0];
          obs.push(`El Anexo trae el DNI ${f.dni}, que no es el del becario (DNI ${beca.dni}; en el BD de becarios figura como DNI de su aval): emparejado por nombre.`);
          if (!(Boolean(f.ruc_ie) && !f.titular)) {
            obs.push(`OJO: es un abono al becario y se pagaría con el DNI ${f.dni}; el titular de la cuenta es el becario (DNI ${beca.dni}). Confirmar con Servicios antes de generar el TXT.`);
          }
        } else throw new Error(`${op.dir} fila ${f.fila}: no encuentro la beca (DNI ${f.dni}, ${nombre})`);
      }
      if (beca.grupo_id !== grupoId) obs.push(`La beca es del grupo «${beca.grupo}».`);
      if (beca.condicion && beca.condicion !== 'Activo') obs.push(`La beca figura como «${beca.condicion}» en fondo2 (en el BD, Activo).`);

      const concepto = resolverConcepto(f.codigo_concepto, conceptos);
      if (!concepto) throw new Error(`${op.dir} fila ${f.fila}: concepto ${f.codigo_concepto} sin alias`);
      const esIE = Boolean(f.ruc_ie) && !f.titular;
      const cci = validarCCI(f.cci);
      if (!cci.valido) throw new Error(`${op.dir} fila ${f.fila}: CCI no válido ${f.cci}`);
      const banco = bancos.find((b) => b.codigo_cci === cci.codigoBanco) ?? null;
      const declarado = bancoPorTexto(f.banco);
      if (banco && declarado && declarado.codigo_cci !== banco.codigo_cci) obs.push(`El Anexo dice «${f.banco}» pero el CCI es de ${banco.sigla} (${banco.codigo_cci}): manda el CCI.`);
      let numeroCuenta = f.numero_cuenta;
      if (pareceTarjeta(numeroCuenta)) { obs.push('En «cuenta bancaria» venía lo que parece un número de tarjeta de 16 dígitos: no se guarda, queda solo el CCI.'); numeroCuenta = null; }
      let periodo = periodoDeGlosa(f.glosa);
      if (op.periodo && periodo && periodo !== op.periodo) { obs.push(`La glosa dice ${periodo}, pero los comprobantes son del ${op.periodo}: se registra ${op.periodo}.`); periodo = op.periodo; }
      if (f.heredada) obs.push('La fila del Anexo no trae cuenta: hereda la de la fila anterior (mismo becario).');

      const ieId = esIE ? instituciones.find((i) => soloDigitos(i.ruc) === f.ruc_ie)?.id ?? instituciones.find((i) => normTxt(i.descripcion).startsWith(normTxt(f.institucion)))?.id ?? null
                        : instituciones.find((i) => normTxt(i.descripcion) === normTxt(f.institucion))?.id ?? beca.institucion_id;
      const l = {
        fila: f.fila, beca, concepto, periodo, ieId, cuentaContable: f.cuenta_contable,
        tipo: esIE ? 'IE' : 'BECARIO',
        benef: normalizarNombreBanco(esIE ? f.institucion : (f.titular ?? f.becario)),
        docTipo: esIE ? 'RUC' : 'DNI', doc: esIE ? f.ruc_ie : f.dni,
        banco, cuenta: numeroCuenta, cci: cci.cci, monto: f.monto, obs,
      };
      const alertas = validarLineaOP(
        { tipo_abono: l.tipo, beneficiario_nombre: l.benef, beneficiario_doc_tipo: l.docTipo, beneficiario_doc: l.doc, cci: l.cci, monto: l.monto },
        { becaEncontrada: true, condicionBeca: 'Activo', saldoConcepto: Infinity, bancoConocido: Boolean(banco) },
      );
      const errores = alertas.filter((h) => h.severidad === 'error');
      if (errores.length) throw new Error(`${op.dir} fila ${f.fila}: ${errores.map((e) => e.mensaje).join(' ')}`);
      lineas.push(l);
    }
    const cuadre = cuadraTotal(op.importe, lineas.map((l) => l.monto));
    if (!cuadre.cuadra || lineas.length !== op.lineas) throw new Error(`${op.dir}: ${lineas.length} líneas / S/ ${cuadre.suma} (esperado ${op.lineas} / ${op.importe})`);
    const lineaId = lineas.map((l) => l.beca.linea_id).sort()[0] ?? null;
    console.log(`OK ${codigo}: ${lineas.length} líneas, S/ ${cuadre.suma.toFixed(2)}, ${new Set(lineas.map((l) => l.beca.id)).size} becarios`);
    for (const l of lineas) if (l.obs.length) console.log(`     f${l.fila} ${l.beca.nombre}: ${l.obs.join(' ')}`);

    partes.push(`-- ── OP ${codigo} · Anexo «${archivo}», hoja «${lectura.hoja.trim()}»
insert into public.beca_orden_pago
  (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion, importe, n_becarios, estado, observaciones, created_by)
values (${sql(codigo)}, ${op.numero}, 2026, '2026-09-28', ${sql(op.informe)}, ${grupoId}, ${lineaId ?? 'null'}, ${sql(op.modalidad)},
  ${sql(lectura.filas[0]?.glosa)}, ${op.importe.toFixed(2)}, ${new Set(lineas.map((l) => l.beca.id)).size}, 'EN_TESORERIA', ${sql(op.obs)}, 'carga inicial ${FECHA}')
on conflict (codigo) do nothing;
${lineas.map((l) => `insert into public.beca_orden_pago_detalle
  (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono, beneficiario_nombre,
   beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto, estado, fila_anexo, observacion)
select op.id, ${l.beca.id}, ${l.concepto.id}, ${sql(l.periodo)}, ${l.ieId ?? 'null'}, ${sql(l.cuentaContable)}, ${sql(l.tipo)}, ${sql(l.benef)},
  ${sql(l.docTipo)}, ${sql(l.doc)}, ${l.banco?.id ?? 'null'}, ${sql(l.cuenta)}, ${sql(l.cci)}, ${l.monto.toFixed(2)}, 'PENDIENTE', ${l.fila}, ${sql(l.obs.join(' ') || null)}
  from public.beca_orden_pago op
 where op.codigo = ${sql(codigo)}
   and not exists (select 1 from public.beca_orden_pago_detalle d where d.orden_pago_id = op.id and d.fila_anexo = ${l.fila});`).join('\n')}`);
  }

  const encabezado = `-- ====================================================================
-- Paso 7 — OP 205 a 209 (pendientes de pago), estado EN_TESORERIA, líneas PENDIENTE
-- Generado por scripts/oneoff/genera_op_205_209.cjs el ${FECHA}.
-- Fuente: Anexo 02 y PDF (PS5.UAF.F03 e Informe) de cada OP, correos de Servicios del
--         28/09/2026 (Desktop\\SistemaPagos\\06_Datos\\Becas\\insumos\\OP205 … OP209).
-- Solo filas visibles de la hoja de pago. No crea eventos en avance_beca: eso lo hace
-- «Registrar pago ejecutado» cuando el banco pague.
-- Idempotente (ON CONFLICT DO NOTHING / NOT EXISTS por fila del Anexo).
-- ====================================================================
`;
  const salida = path.join(RAIZ, 'scripts', `data_becas_op_205_209_${FECHA}.sql`);
  fs.writeFileSync(salida, encabezado + partes.join('\n\n') + '\n');
  console.log('escrito', path.relative(RAIZ, salida));
})().catch((e) => { console.error('XX', e.message); process.exit(1); });
