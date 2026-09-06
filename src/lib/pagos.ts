/**
 * Convenciones de los pagos registrados en la bitácora (avance_proyecto / avance_beca).
 *
 * - Cada pago es un evento con su monto PARCIAL. El avance del proyecto / beca es la
 *   SUMA de los montos de la bitácora (recalculateProyectoAvance / recalculateBecaAvance).
 * - La orden de pago va en el sustento, al inicio: "OP 138-UPS-AS - S/ 903.40". Así los
 *   skills de pago (pago-planilla, pago-proyecto) pueden verificar que una OP no se
 *   registre dos veces.
 * - El evento de ARRASTRE (creado por scripts/migra_pagos_arrastre.cjs) concentra el
 *   acumulado pagado antes de la trazabilidad por OP. Se reconoce por el prefijo del
 *   sustento. Cuando se reconstruye la historia y se cargan OPs que ya estaban incluidas
 *   en ese acumulado, el pago se registra con `descontarDeArrastre` y el arrastre baja
 *   en el mismo monto, de modo que el avance total no cambia.
 *
 * Sin columnas nuevas en Supabase: todo se apoya en `monto` y `sustento`.
 */

export const ARRASTRE_PREFIX = 'Arrastre:';

export type EventoPago = {
  id?: number | string;
  fecha?: string | null;
  monto?: number | string | null;
  sustento?: string | null;
  [k: string]: any;
};

export function esArrastre(av: EventoPago | null | undefined): boolean {
  return !!av && typeof av.sustento === 'string' && av.sustento.trim().startsWith(ARRASTRE_PREFIX);
}

export function esPago(av: EventoPago | null | undefined): boolean {
  return !!av && (Number(av.monto) || 0) > 0;
}

/** Extrae la referencia de la orden de pago del sustento ("OP 138-UPS-AS"), o null. */
export function extraerOrdenPago(sustento: string | null | undefined): string | null {
  if (!sustento) return null;
  const m = sustento.match(/\bOP\s*\.?\s*(?:N[°ºo]?\s*)?([0-9]{1,6}(?:[-\/][A-Z0-9]+)*)/i);
  return m ? `OP ${m[1].toUpperCase()}` : null;
}

const fechaDe = (av: EventoPago) => (av.fecha ? String(av.fecha).split('T')[0] : '');

/** Orden cronológico (fecha asc, id asc): el mismo que usa el recálculo, invertido. */
export function ordenarCronologico<T extends EventoPago>(avances: T[]): T[] {
  return [...avances].sort((a, b) => {
    const fa = fechaDe(a), fb = fechaDe(b);
    if (fa !== fb) return fa < fb ? -1 : 1;
    return (Number(a.id) || 0) - (Number(b.id) || 0);
  });
}

/**
 * Acumulado pagado hasta cada evento (inclusive), en orden cronológico.
 * Devuelve un Map id -> acumulado. Los eventos sin monto no cambian el acumulado.
 */
export function acumuladosPorEvento(avances: EventoPago[]): Map<any, number> {
  const out = new Map<any, number>();
  let acumulado = 0;
  for (const av of ordenarCronologico(avances)) {
    acumulado = Math.round((acumulado + (Number(av.monto) || 0)) * 100) / 100;
    out.set(av.id, acumulado);
  }
  return out;
}

/** El evento de arrastre vigente (con saldo > 0) de una bitácora, si existe. */
export function arrastreVigente<T extends EventoPago>(avances: T[] | null | undefined): T | null {
  if (!avances) return null;
  return avances.find((av) => esArrastre(av) && (Number(av.monto) || 0) > 0) || null;
}

export function formatSoles(value: any): string {
  const num = Number(value);
  if (isNaN(num)) return 'S/ 0.00';
  return `S/ ${num.toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}
