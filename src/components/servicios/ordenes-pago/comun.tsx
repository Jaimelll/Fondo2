"use client";

// Piezas compartidas por las pantallas de Órdenes de pago de becas.

export const ESTADOS_OP = ['GENERADA', 'ENVIADA', 'EN_TESORERIA', 'PENDIENTE_FIRMA', 'PAGADA', 'OBSERVADA', 'ANULADA'] as const;
export const ESTADOS_OP_MANUALES = ['GENERADA', 'ENVIADA', 'EN_TESORERIA', 'PENDIENTE_FIRMA', 'OBSERVADA'] as const;

export const ETIQUETA_ESTADO: Record<string, string> = {
    GENERADA: 'Generada',
    ENVIADA: 'Enviada',
    EN_TESORERIA: 'En Tesorería',
    PENDIENTE_FIRMA: 'Pendiente de firma',
    PAGADA: 'Pagada',
    OBSERVADA: 'Observada',
    ANULADA: 'Anulada',
    PENDIENTE: 'Pendiente',
    RECHAZADA: 'Rechazada',
};

const COLOR_ESTADO: Record<string, string> = {
    GENERADA: 'bg-slate-100 text-slate-700',
    ENVIADA: 'bg-sky-100 text-sky-800',
    EN_TESORERIA: 'bg-indigo-100 text-indigo-800',
    PENDIENTE_FIRMA: 'bg-amber-100 text-amber-800',
    PAGADA: 'bg-emerald-100 text-emerald-800',
    OBSERVADA: 'bg-orange-100 text-orange-800',
    ANULADA: 'bg-gray-200 text-gray-500 line-through',
    PENDIENTE: 'bg-amber-50 text-amber-700',
    RECHAZADA: 'bg-red-100 text-red-700',
};

export const ETIQUETA_MODALIDAD: Record<string, string> = {
    ABONO_IE: 'Abono a IE',
    REEMBOLSO: 'Reembolso',
    ABONO_BECARIO: 'Abono al becario',
};

export function EstadoBadge({ estado }: { estado: string }) {
    return (
        <span className={`inline-block whitespace-nowrap rounded px-2 py-0.5 text-[10px] font-black uppercase tracking-wide ${COLOR_ESTADO[estado] ?? 'bg-gray-100 text-gray-600'}`}>
            {ETIQUETA_ESTADO[estado] ?? estado}
        </span>
    );
}

export function soles(v: unknown): string {
    const n = Number(v);
    if (!Number.isFinite(n)) return 'S/ 0.00';
    return `S/ ${n.toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

/** 'AAAA-MM-DD' → 'DD/MM/AAAA' */
export function fechaCorta(f: string | null | undefined): string {
    if (!f) return '—';
    const [a, m, d] = String(f).slice(0, 10).split('-');
    return d ? `${d}/${m}/${a}` : String(f);
}

/** CCI en bloques legibles: 002-191-113575458082-50 */
export function cciLegible(cci: string | null | undefined): string {
    const c = String(cci ?? '').trim();
    if (c.length !== 20) return c || '—';
    return `${c.slice(0, 3)}-${c.slice(3, 6)}-${c.slice(6, 18)}-${c.slice(18)}`;
}
