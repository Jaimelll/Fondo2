// Lista los encabezados (filas 1-5) de las hojas de los BD de becarios, con su número de columna.
// Uso: docker compose exec -T app node scripts/oneoff/explora_bd_becarios.cjs <archivo.xlsx> [hoja] [filaMax]
const XLSX = require('xlsx');
const [, , archivo, hojaFiltro, filaMax = '6'] = process.argv;
const wb = XLSX.readFile(archivo, { sheetRows: Number(filaMax) + 2 });
for (const sn of wb.SheetNames) {
  if (hojaFiltro && sn.trim() !== hojaFiltro.trim()) continue;
  const oculta = wb.Workbook?.Sheets?.find((s) => s.name === sn)?.Hidden;
  const datos = XLSX.utils.sheet_to_json(wb.Sheets[sn], { header: 1, defval: '', raw: false });
  console.log(`\n==== «${sn}»${oculta ? ' (oculta)' : ''} ref=${wb.Sheets[sn]['!ref']}`);
  if (!hojaFiltro) continue;
  const n = Math.max(...datos.slice(0, Number(filaMax)).map((r) => r.length));
  for (let c = 0; c < n; c++) {
    const partes = datos.slice(0, Number(filaMax)).map((r) => String(r[c] ?? '').replace(/\s+/g, ' ').trim()).filter(Boolean);
    if (partes.length) console.log(`${String(c + 1).padStart(4)} ${XLSX.utils.encode_col(c).padEnd(3)} ${partes.join(' ‖ ').slice(0, 150)}`);
  }
}
