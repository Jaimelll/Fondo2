// Bloques por OP de los BD de becarios: cada bloque empieza con una columna de etiquetas
// «N° OP / Fecha OP / Informe N° / Fecha CP» y a su derecha los valores; en la fila del
// encabezado está «Total (S/.) <tipo>» y luego las columnas de detalle por concepto.
// Exporta leerBloques(archivo, hoja, claveEncabezado) y, ejecutado solo, los lista.
const XLSX = require('xlsx');

const norm = (s) => String(s ?? '').normalize('NFD').replace(/[̀-ͯ]/g, '').toUpperCase().replace(/\s+/g, ' ').trim();

function fechaExcel(v) {
  if (typeof v === 'number') {
    const d = XLSX.SSF.parse_date_code(v);
    return d ? `${d.y}-${String(d.m).padStart(2, '0')}-${String(d.d).padStart(2, '0')}` : null;
  }
  const m = String(v ?? '').match(/(\d{1,2})\/(\d{1,2})\/(\d{2,4})/);
  if (!m) return null;
  const y = m[3].length === 2 ? `20${m[3]}` : m[3];
  return `${y}-${m[1].padStart(2, '0')}-${m[2].padStart(2, '0')}`; // m/d/aa (formato de los BD)
}

function leerBloques(archivo, hoja, claveEncabezado = 'N° Documento de identidad') {
  const wb = XLSX.readFile(archivo, { sheetRows: 3000 });
  const nombre = wb.SheetNames.find((s) => s.trim() === hoja.trim());
  const datos = XLSX.utils.sheet_to_json(wb.Sheets[nombre], { header: 1, defval: '', raw: true });
  const iEnc = datos.findIndex((r) => r.some((c) => norm(c) === norm(claveEncabezado)));
  const ancho = Math.max(...datos.slice(0, iEnc + 1).map((r) => r.length));
  const inicios = [];
  for (let c = 0; c < ancho; c++) {
    const etiquetas = datos.slice(0, iEnc + 1).map((r) => norm(r[c]));
    if (etiquetas.includes('N° OP') || etiquetas.some((e) => /^N.? OP$/.test(e))) inicios.push(c);
  }
  const bloques = inicios.map((c, k) => {
    const filas = datos.slice(0, iEnc + 1);
    const fila = (re) => filas.findIndex((r) => re.test(norm(r[c])));
    const iOP = fila(/^N.? OP$/), iFecha = fila(/^FECHA OP$/), iInf = fila(/^INFORME/), iCP = fila(/^FECHA CP$/);
    const v = (i) => (i >= 0 ? filas[i][c + 1] : '');
    const fin = k + 1 < inicios.length ? inicios[k + 1] : ancho;
    const detalle = [];
    for (let j = c + 2; j < fin; j++) {
      const t = String(datos[iEnc][j] ?? '').replace(/\s+/g, ' ').trim();
      if (t) detalle.push({ col: j, titulo: t });
    }
    return {
      colEtiqueta: c,
      colTotal: c + 1,
      op: Number(String(v(iOP)).replace(/\D/g, '')) || null,
      fechaOP: fechaExcel(v(iFecha)),
      informe: String(v(iInf) ?? '').trim() || null,
      fechaCP: fechaExcel(v(iCP)),
      tipo: String(datos[iEnc][c + 1] ?? '').replace(/\s+/g, ' ').trim(),
      detalle,
    };
  });
  return { datos, iEnc, bloques };
}

module.exports = { leerBloques, fechaExcel, norm };

if (require.main === module) {
  const [, , archivo, hoja] = process.argv;
  const { bloques } = leerBloques(archivo, hoja);
  for (const b of bloques) {
    console.log(`OP ${String(b.op).padStart(4)} ${b.fechaOP ?? '—'} inf ${b.informe ?? '—'} | ${b.tipo} | ${b.detalle.map((d) => d.titulo).join(' · ').slice(0, 160)}`);
  }
}
