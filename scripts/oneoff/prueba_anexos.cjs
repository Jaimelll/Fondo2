// Prueba del lector del Anexo 02 (src/lib/anexo02.ts) contra los Anexos de las OP 205-209.
// Uso (dentro del contenedor, con los insumos copiados a /tmp/insumos):
//   docker compose exec -T app node scripts/oneoff/prueba_anexos.cjs
require('sucrase/register/ts');
const fs = require('fs');
const path = require('path');
const { leerAnexo02, periodoDeGlosa, pareceTarjeta } = require('../../src/lib/anexo02.ts');
const { validarCCI } = require('../../src/lib/becas-validacion.ts');

const root = process.argv[2] || '/tmp/insumos';
const esperado = { OP205: [8, 6258.27], OP206: [2, 2221.96], OP207: [6, 10811.99], OP208: [3, 1204.0], OP209: [5, 1682.92] };
for (const dir of fs.readdirSync(root).sort()) {
  const f = fs.readdirSync(path.join(root, dir)).find((x) => /anexo/i.test(x) && x.endsWith('.xlsx'));
  if (!f) continue;
  const r = leerAnexo02(fs.readFileSync(path.join(root, dir, f)));
  const total = Math.round(r.filas.reduce((a, x) => a + x.monto, 0) * 100) / 100;
  const [n, imp] = esperado[dir] || [];
  const ok = r.filas.length === n && Math.abs(total - imp) < 0.005;
  console.log(`\n${ok ? 'OK ' : 'XX '} ${dir}: hoja «${r.hoja.trim()}», ${r.filas.length} líneas, S/ ${total} (esperado ${n} / ${imp}), ocultas ignoradas ${r.filasOcultasIgnoradas}`);
  r.avisos.forEach((a) => console.log('     aviso:', a));
  for (const x of r.filas) {
    const cci = validarCCI(x.cci);
    console.log(`     f${x.fila} dni=${x.dni} ${String(x.titular ?? x.becario).slice(0, 30).padEnd(30)} ${x.codigo_concepto} conv=${x.convenio} ruc=${x.ruc_ie} cci=${x.cci}${cci.valido ? '' : ' (CCI NO VÁLIDO)'} banco=${x.banco} per=${periodoDeGlosa(x.glosa)} S/${x.monto}${pareceTarjeta(x.numero_cuenta) ? ' [¿tarjeta?]' : ''}${x.heredada ? ' [heredada]' : ''}`);
  }
}
