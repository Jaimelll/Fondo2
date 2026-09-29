/**
 * Validaciones de las órdenes de pago de becas (skill pago-becas).
 *
 * Funciones puras: las usan la importación del Anexo 02 (gestion-servicios/ordenes-pago),
 * los scripts de carga y, del lado del cliente, los indicadores de la ficha del becario.
 * Lo que necesita la BD (saldo, condición del becario, comprobante repetido) lo
 * resuelve quien llama y se lo pasa a validarLineaOP en `contexto`.
 */

export type Severidad = 'error' | 'alerta';
export type Hallazgo = { severidad: Severidad; campo: string; mensaje: string };

// ─── CCI ────────────────────────────────────────────────────────────

/** Solo los dígitos ("002-191-113575458082-50" → "00219111357545808250"). */
export function soloDigitos(s: string | number | null | undefined): string {
  return String(s ?? '').replace(/\D/g, '');
}

/**
 * Dígito de control del CCI: pesos 1,2,1,2… desde la izquierda; si un producto
 * es ≥ 10 se suman sus dígitos; DC = (10 − suma mod 10) mod 10.
 */
export function digitoControlCCI(digitos: string): number {
  let suma = 0;
  for (let i = 0; i < digitos.length; i++) {
    const p = Number(digitos[i]) * (i % 2 === 0 ? 1 : 2);
    suma += p >= 10 ? Math.floor(p / 10) + (p % 10) : p;
  }
  return (10 - (suma % 10)) % 10;
}

export type ResultadoCCI = {
  cci: string;          // normalizado a 20 dígitos (o lo que haya)
  valido: boolean;
  codigoBanco: string | null;
  motivo?: string;
};

/**
 * CCI = banco(3) + oficina(3) + cuenta(12) + DC(2). El dígito 19 controla las
 * posiciones 1-6 y el 20 las posiciones 7-18.
 */
export function validarCCI(valor: string | number | null | undefined): ResultadoCCI {
  const cci = soloDigitos(valor);
  if (cci.length !== 20) {
    return { cci, valido: false, codigoBanco: cci.length >= 3 ? cci.slice(0, 3) : null, motivo: `El CCI tiene ${cci.length} dígitos (deben ser 20).` };
  }
  const dc1 = digitoControlCCI(cci.slice(0, 6));
  const dc2 = digitoControlCCI(cci.slice(6, 18));
  const ok = Number(cci[18]) === dc1 && Number(cci[19]) === dc2;
  return {
    cci,
    valido: ok,
    codigoBanco: cci.slice(0, 3),
    motivo: ok ? undefined : `Dígitos de control no cuadran (esperado ${dc1}${dc2}, trae ${cci.slice(18)}).`,
  };
}

// ─── Nombres y documentos ───────────────────────────────────────────

/**
 * Nombre apto para el portal del BBVA: mayúsculas, sin tildes, sin comas ni
 * símbolos (la OP 196 se rechazó por una coma). La Ñ se conserva.
 */
export function normalizarNombreBanco(nombre: string | null | undefined): string {
  return String(nombre ?? '')
    .toUpperCase()
    .replace(/Ñ/g, '\u0000')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/\u0000/g, 'Ñ')
    .replace(/[^A-ZÑ0-9 ]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

/** Caracteres que el portal rechaza (para reportarlos, no para corregir en silencio). */
export function caracteresNoPermitidos(nombre: string | null | undefined): string[] {
  const fuera = String(nombre ?? '').match(/[^A-Za-zÑñÁÉÍÓÚáéíóúÜü0-9 ]/g) ?? [];
  return Array.from(new Set(fuera));
}

/** DNI de 8 dígitos a partir de lo que traen los Anexos ("00071154900" → "71154900"). */
export function normalizarDNI(valor: string | number | null | undefined): string {
  const d = soloDigitos(valor);
  if (d.length > 8 && /^0+/.test(d)) return d.slice(-8);
  return d.padStart(8, '0');
}

/** 'Código 102-2026-FE' → '102-2026-FE' */
export function normalizarCodigoConvenio(valor: string | null | undefined): string | null {
  const m = String(valor ?? '').match(/(\d{1,4}-\d{4}-[A-Z]+)/i);
  return m ? m[1].toUpperCase() : null;
}

/** Monto de texto de Excel ("2,325.00", "S/ 822.26") a número con 2 decimales. */
export function parseMonto(valor: string | number | null | undefined): number {
  if (typeof valor === 'number') return Math.round(valor * 100) / 100;
  const n = Number(String(valor ?? '').replace(/[^0-9.-]/g, ''));
  return Number.isFinite(n) ? Math.round(n * 100) / 100 : 0;
}

// ─── Conceptos ──────────────────────────────────────────────────────

export type ConceptoBeca = { id: number; codigo: string; nombre: string; tipo: string; abono_por_defecto: 'IE' | 'BECARIO'; codigos_anexo: string[] };

/**
 * Resuelve el concepto de una fila del Anexo por alias exacto ('OTR-0006-ACADEMICOS');
 * si no hay alias exacto, por el sufijo ('…-ACADEMICOS'), porque el número del
 * medio cambia según la convocatoria.
 */
export function resolverConcepto(codigoAnexo: string | null | undefined, conceptos: ConceptoBeca[]): ConceptoBeca | null {
  const c = String(codigoAnexo ?? '').trim().toUpperCase();
  if (!c) return null;
  const exacto = conceptos.find((k) => k.codigos_anexo.some((a) => a.toUpperCase() === c));
  if (exacto) return exacto;
  const sufijo = c.split('-').pop();
  if (!sufijo) return null;
  const porSufijo = conceptos.filter((k) => k.codigos_anexo.some((a) => a.toUpperCase().split('-').pop() === sufijo));
  return porSufijo.length === 1 ? porSufijo[0] : null;
}

// ─── Validación de una línea de OP ──────────────────────────────────

export type LineaOP = {
  tipo_abono: 'IE' | 'BECARIO';
  beneficiario_nombre: string;
  beneficiario_doc_tipo: 'DNI' | 'RUC' | 'CE';
  beneficiario_doc: string;
  cci: string | null;
  banco_codigo_declarado?: string | null; // código del banco que dice el Anexo, si se pudo mapear
  monto: number;
  comprobante_numero?: string | null;
};

export type ContextoLinea = {
  becaEncontrada: boolean;
  condicionBeca?: string | null;      // 'Activo', 'Cancelado', …
  saldoConcepto?: number | null;      // de v_beca_saldo; null = sin presupuesto cargado
  comprobanteRepetido?: boolean;
  bancoConocido?: boolean;            // el código CCI existe en `bancos`
  rucIE?: string | null;              // RUC de la IE (para abono a IE)
};

export function validarLineaOP(l: LineaOP, ctx: ContextoLinea): Hallazgo[] {
  const h: Hallazgo[] = [];
  const add = (severidad: Severidad, campo: string, mensaje: string) => h.push({ severidad, campo, mensaje });

  if (!ctx.becaEncontrada) add('error', 'becario', 'El DNI no corresponde a ninguna beca registrada.');
  else if (ctx.condicionBeca && ctx.condicionBeca !== 'Activo') {
    add(ctx.condicionBeca === 'Cancelado' ? 'error' : 'alerta', 'becario', `La beca está en condición «${ctx.condicionBeca}».`);
  }

  const cci = validarCCI(l.cci);
  if (!l.cci) add('error', 'cci', 'Falta el CCI.');
  else if (!cci.valido) add('error', 'cci', cci.motivo ?? 'CCI no válido.');
  if (cci.codigoBanco && ctx.bancoConocido === false) add('alerta', 'banco', `El código de banco ${cci.codigoBanco} no está en el catálogo de bancos.`);
  if (cci.codigoBanco && l.banco_codigo_declarado && l.banco_codigo_declarado !== cci.codigoBanco) {
    add('alerta', 'banco', `El banco consignado no coincide con el CCI (${cci.codigoBanco}). Manda el CCI.`);
  }

  const raros = caracteresNoPermitidos(l.beneficiario_nombre);
  if (raros.length) add('alerta', 'beneficiario', `El nombre trae caracteres que el portal BBVA rechaza: ${raros.join(' ')}`);

  if (l.tipo_abono === 'IE') {
    if (l.beneficiario_doc_tipo !== 'RUC') add('error', 'documento', 'Abono a la IE: el beneficiario debe ir con RUC (tipo R), no con DNI.');
    if (ctx.rucIE && soloDigitos(l.beneficiario_doc) !== soloDigitos(ctx.rucIE)) add('alerta', 'documento', `El RUC no coincide con el de la institución (${ctx.rucIE}).`);
  } else if (l.beneficiario_doc_tipo === 'RUC') {
    add('error', 'documento', 'Abono al becario: el beneficiario debe ir con DNI (tipo L), no con RUC.');
  }

  if (!(l.monto > 0)) add('error', 'monto', 'El monto debe ser mayor que cero.');
  if (ctx.saldoConcepto === null || ctx.saldoConcepto === undefined) {
    add('alerta', 'saldo', 'No hay presupuesto cargado para este concepto.');
  } else if (l.monto > ctx.saldoConcepto + 0.005) {
    add('alerta', 'saldo', `El monto supera el saldo del concepto (saldo S/ ${ctx.saldoConcepto.toFixed(2)}).`);
  }

  if (ctx.comprobanteRepetido) add('error', 'comprobante', `El comprobante ${l.comprobante_numero} ya se reembolsó en otra OP.`);
  return h;
}

/** Σ líneas = importe de la OP (tolerancia de medio céntimo). */
export function cuadraTotal(importe: number, montos: number[]): { cuadra: boolean; suma: number; diferencia: number } {
  const suma = Math.round(montos.reduce((a, b) => a + (Number(b) || 0), 0) * 100) / 100;
  const diferencia = Math.round((Number(importe) - suma) * 100) / 100;
  return { cuadra: Math.abs(diferencia) < 0.005, suma, diferencia };
}

/** Número de OP desde el código ('205-UPS-AS/FE-2026' → {numero: 205, anio: 2026}). */
export function parseCodigoOP(codigo: string): { numero: number; anio: number | null } | null {
  const m = String(codigo).match(/(\d{1,6})\s*-\s*UPS[^\d]*(\d{4})?/i);
  if (!m) return null;
  return { numero: Number(m[1]), anio: m[2] ? Number(m[2]) : null };
}

/** Sustento del evento de avance_beca para una línea pagada (convención de src/lib/pagos.ts). */
export function sustentoPagoOP(numeroOP: number, monto: number): string {
  return `OP ${numeroOP}-UPS-AS - S/ ${Number(monto).toFixed(2)}`;
}
