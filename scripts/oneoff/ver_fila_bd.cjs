// Muestra columna → valor de las filas de un BD de becarios que contengan un texto (DNI o nombre).
// Uso: docker compose exec -T app node scripts/oneoff/ver_fila_bd.cjs <archivo.xlsx> <hoja> <filaEncabezado> <texto> [colDesde] [colHasta]
const XLSX = require('xlsx');
const [, , archivo, hoja, filaEnc, texto, desde = '1', hasta = '120'] = process.argv;
const wb = XLSX.readFile(archivo);
const ws = wb.Sheets[wb.SheetNames.find((s) => s.trim() === hoja.trim())];
const datos = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '', raw: true });
const enc = datos[Number(filaEnc) - 1] || [];
const filas = datos.map((r, i) => [r, i]).filter(([r]) => r.some((c) => String(c).includes(texto)));
console.log(`filas de datos: ${datos.length - Number(filaEnc)}; coincidencias: ${filas.length}`);
for (const [r, i] of filas.slice(0, 3)) {
  console.log(`\n--- fila ${i + 1}`);
  for (let c = Number(desde) - 1; c < Math.min(Number(hasta), r.length); c++) {
    if (r[c] === '' || r[c] === null) continue;
    console.log(`${String(c + 1).padStart(4)} ${XLSX.utils.encode_col(c).padEnd(3)} ${String(enc[c] ?? '').replace(/\s+/g, ' ').slice(0, 45).padEnd(45)} = ${String(r[c]).slice(0, 60)}`);
  }
}
