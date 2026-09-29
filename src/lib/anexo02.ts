/**
 * Lectura del Anexo 02 (lista de pago de una OP de becas) desde el .xlsx de Servicios.
 *
 * Reglas aprendidas de los Anexos de las OP 205-209 (ver CLAUDE.md, «Órdenes de pago de becas»):
 *  - Solo cuentan las filas VISIBLES: las ocultas (hidden="1") son becarios que no cobran.
 *  - Las hojas ocultas no se leen. Entre las visibles, las copias de la muestra traen
 *    una columna «ALEATORIO» y se descartan (Anexo 205 «ANEXO 2 (2)», Anexo 209 «Hoja2»).
 *  - Los encabezados se ubican por NOMBRE, no por posición: cada convocatoria mueve columnas.
 *  - Una fila que trae concepto y monto pero no titular/DNI/CCI es un segundo concepto
 *    del becario de la fila anterior: hereda su cuenta (Huacachino en la OP 209).
 */
import * as XLSX from 'xlsx';
import { normalizarDNI, parseMonto, soloDigitos, normalizarCodigoConvenio } from './becas-validacion';

export type FilaAnexo = {
  fila: number;                 // número de fila en Excel (1-based)
  cuenta_contable: string | null;
  institucion: string | null;
  ruc_ie: string | null;
  titular: string | null;       // titular de la cuenta (reembolso) o null
  becario: string | null;       // nombre del becario si la hoja lo trae aparte
  dni: string | null;           // DNI normalizado a 8 dígitos
  numero_cuenta: string | null;
  cci: string | null;           // solo dígitos
  banco: string | null;         // texto tal como viene
  codigo_concepto: string | null;
  convenio: string | null;      // '102-2026-FE'
  glosa: string | null;
  monto: number;
  heredada: boolean;            // la cuenta se heredó de la fila anterior
};

export type LecturaAnexo = {
  hoja: string;
  hojasVisibles: { nombre: string; esMuestra: boolean; esCandidata: boolean }[];
  filaEncabezado: number;
  filas: FilaAnexo[];
  filasOcultasIgnoradas: number;
  avisos: string[];
};

const norm = (s: unknown) =>
  String(s ?? '')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toUpperCase()
    .replace(/\s+/g, ' ')
    .trim();

type Campo = keyof Omit<FilaAnexo, 'fila' | 'monto' | 'heredada'> | 'monto';

// Primer patrón que calce gana; el orden importa ("CUENTA BANCARIA" antes que "CUENTA").
const PATRONES: [Campo, RegExp][] = [
  ['cci', /INTERBANCARI/],
  ['numero_cuenta', /CUENTA BANCARIA|N.? ?CUENTA/],
  ['titular', /TITULAR/],
  ['ruc_ie', /RUC/],
  ['institucion', /INSTITUCION EDUCATIVA|DESC\.? CUENTA|INSTITUCION/],
  ['cuenta_contable', /^CUENTA$/],
  ['becario', /^BECARIO$|APELLIDOS Y NOMBRES/],
  ['dni', /^DNI$|^DNI BECARIO$|N.? ?DNI/],
  ['banco', /^BANCO$/],
  ['codigo_concepto', /^DOCUMENTO$/],
  ['glosa', /^CONCEPTO$|^GLOSA$/],
  ['monto', /MONTO A PAGAR|NETODOL|^IMPORTE|^MONTO$/],
];

function mapearEncabezado(fila: unknown[]): Partial<Record<Campo, number>> | null {
  const cols: Partial<Record<Campo, number>> = {};
  fila.forEach((celda, i) => {
    const t = norm(celda);
    if (!t) return;
    for (const [campo, re] of PATRONES) {
      if (cols[campo] === undefined && re.test(t)) {
        cols[campo] = i;
        break;
      }
    }
  });
  // Un encabezado de pago tiene al menos CCI y monto.
  return cols.cci !== undefined && cols.monto !== undefined ? cols : null;
}

function buscarEncabezado(datos: unknown[][], max = 40) {
  for (let i = 0; i < Math.min(max, datos.length); i++) {
    const cols = mapearEncabezado(datos[i] ?? []);
    if (cols) {
      const esMuestra = (datos[i] ?? []).some((c) => norm(c) === 'ALEATORIO');
      return { indice: i, cols, esMuestra };
    }
  }
  return null;
}

/**
 * Lee el Anexo 02. `hojaPreferida` fuerza la hoja (si el usuario la eligió en la
 * vista previa); si no, se toma la hoja visible con encabezado de pago que no sea
 * una muestra, prefiriendo las que se llaman «ANEXO 2…».
 */
export function leerAnexo02(buffer: ArrayBuffer | Buffer, hojaPreferida?: string | null): LecturaAnexo {
  // sheetRows: los Anexos 208/209 declaran ~1 048 000 filas por formato; ninguna
  // lista de pago pasa de unos cientos, así que basta con las primeras 10 000.
  const wb = XLSX.read(buffer, { type: 'buffer', cellStyles: true, cellDates: false, sheetRows: 10000 });
  const avisos: string[] = [];

  const visibles = wb.SheetNames.filter((n) => !(wb.Workbook?.Sheets?.find((s) => s.name === n)?.Hidden));
  const info = visibles.map((nombre) => {
    const datos = XLSX.utils.sheet_to_json<unknown[]>(wb.Sheets[nombre], { header: 1, defval: '', raw: false, blankrows: true });
    const enc = buscarEncabezado(datos);
    return { nombre, datos, enc };
  });

  const candidatas = info.filter((h) => h.enc && !h.enc.esMuestra);
  let elegida =
    (hojaPreferida && info.find((h) => h.nombre === hojaPreferida && h.enc)) ||
    candidatas.find((h) => /^\s*ANEXO\s*0?2/i.test(h.nombre)) ||
    candidatas[0];
  if (!elegida) {
    throw new Error('No encontré una hoja visible con encabezados de pago (CÓDIGO INTERBANCARIO y MONTO).');
  }
  if (candidatas.length > 1) {
    avisos.push(`Hay ${candidatas.length} hojas visibles con lista de pago (${candidatas.map((c) => `«${c.nombre.trim()}»`).join(', ')}). Se usa «${elegida.nombre.trim()}»; revisa que sea la correcta.`);
  }
  for (const h of info) {
    if (h.enc?.esMuestra) avisos.push(`La hoja «${h.nombre.trim()}» es una copia de la muestra (columna ALEATORIO): no se carga.`);
  }

  const ws = wb.Sheets[elegida.nombre];
  const ocultas = new Set<number>();
  (ws['!rows'] ?? []).forEach((r, i) => { if (r?.hidden) ocultas.add(i); });

  const { indice, cols } = elegida.enc!;
  const celda = (fila: unknown[], campo: Campo) => {
    const i = cols[campo];
    if (i === undefined) return null;
    const v = String(fila[i] ?? '').trim();
    return v === '' ? null : v;
  };

  const filas: FilaAnexo[] = [];
  let ocultasIgnoradas = 0;
  let anterior: FilaAnexo | null = null;
  for (let i = indice + 1; i < elegida.datos.length; i++) {
    const f = elegida.datos[i] ?? [];
    if (ocultas.has(i)) {
      if (celda(f, 'cci') || celda(f, 'dni')) ocultasIgnoradas++;
      continue;
    }
    const monto = parseMonto(celda(f, 'monto'));
    const tieneDatos = monto > 0 && (celda(f, 'codigo_concepto') || celda(f, 'cci') || celda(f, 'dni'));
    if (!tieneDatos) continue;

    const sinPersona = !celda(f, 'cci') && !celda(f, 'dni') && !celda(f, 'titular') && !celda(f, 'becario');
    const heredada = sinPersona && anterior !== null;
    const base = heredada ? anterior! : null;
    const fila: FilaAnexo = {
      fila: i + 1,
      cuenta_contable: celda(f, 'cuenta_contable') ?? base?.cuenta_contable ?? null,
      institucion: celda(f, 'institucion') ?? base?.institucion ?? null,
      ruc_ie: soloDigitos(celda(f, 'ruc_ie')) || base?.ruc_ie || null,
      titular: celda(f, 'titular') ?? base?.titular ?? null,
      becario: celda(f, 'becario') ?? base?.becario ?? null,
      dni: celda(f, 'dni') ? normalizarDNI(celda(f, 'dni')) : base?.dni ?? null,
      numero_cuenta: celda(f, 'numero_cuenta') ?? base?.numero_cuenta ?? null,
      cci: soloDigitos(celda(f, 'cci')) || base?.cci || null,
      banco: celda(f, 'banco') ?? base?.banco ?? null,
      codigo_concepto: celda(f, 'codigo_concepto')?.toUpperCase() ?? null,
      // El código de convenio viene en «CONVENIO» o en «REFERENCIA BECARIO» según el
      // Anexo: se toma la primera celda de la fila con forma 'Código NNN-AAAA-FE'.
      convenio:
        f.map((c) => (/\d-\d{4}-FE/i.test(String(c)) ? normalizarCodigoConvenio(String(c)) : null)).find(Boolean) ??
        (heredada ? base?.convenio ?? null : null),
      glosa: celda(f, 'glosa'),
      monto,
      heredada,
    };
    if (heredada) avisos.push(`Fila ${fila.fila}: no trae cuenta; hereda la de la fila ${anterior!.fila} (${anterior!.titular ?? anterior!.becario ?? anterior!.dni}).`);
    filas.push(fila);
    anterior = fila;
  }

  return {
    hoja: elegida.nombre,
    hojasVisibles: info.map((h) => ({ nombre: h.nombre, esMuestra: Boolean(h.enc?.esMuestra), esCandidata: Boolean(h.enc && !h.enc.esMuestra) })),
    filaEncabezado: indice + 1,
    filas,
    filasOcultasIgnoradas: ocultasIgnoradas,
    avisos,
  };
}

/** Periodo académico de la glosa ('… 2026-II - REEMBOLSO' → '2026-II'). */
export function periodoDeGlosa(glosa: string | null | undefined): string | null {
  const m = String(glosa ?? '').match(/\b(20\d{2})\s*-\s*(II|I)\b/i);
  return m ? `${m[1]}-${m[2].toUpperCase()}` : null;
}

/** Número y año de OP a partir del nombre del archivo ('Anexo 02 pagos OP Nro 208.xlsx' → 208). */
export function numeroOPDeArchivo(nombre: string): number | null {
  const m = nombre.match(/\bOP\b\D{0,8}(\d{2,4})/i);
  return m ? Number(m[1]) : null;
}

/** Un número de cuenta de 16 dígitos que empieza en 4 o 5 parece una tarjeta (Visa/Mastercard). */
export function pareceTarjeta(numeroCuenta: string | null | undefined): boolean {
  const d = soloDigitos(numeroCuenta);
  return d.length === 16 && /^[45]/.test(d);
}
