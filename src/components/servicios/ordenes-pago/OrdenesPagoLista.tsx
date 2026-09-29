"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import * as XLSX from "xlsx";
import { Download, FileUp, Search } from "lucide-react";
import { ESTADOS_OP, ETIQUETA_ESTADO, ETIQUETA_MODALIDAD, EstadoBadge, fechaCorta, soles } from "./comun";

type Orden = {
    id: number;
    codigo: string;
    numero: number;
    anio: number;
    fecha_emision: string | null;
    informe_codigo: string | null;
    grupo_id: number | null;
    grupo: string | null;
    grupos_lineas: string;
    grupo_ids: number[];
    modalidad: string | null;
    descripcion: string | null;
    importe: number;
    suma_lineas: number;
    n_becarios: number | null;
    lineas: number;
    pagadas: number;
    estado: string;
    dia_pago: string | null;
    fecha_ejecucion: string | null;
    nro_orden_banco: string | null;
};

export default function OrdenesPagoLista({
    ordenes,
    grupos,
}: {
    ordenes: Orden[];
    grupos: { value: number; label: string }[];
}) {
    const [estado, setEstado] = useState('all');
    const [grupo, setGrupo] = useState('all');
    const [desde, setDesde] = useState('');
    const [hasta, setHasta] = useState('');
    const [q, setQ] = useState('');

    const filtradas = useMemo(() => {
        const term = q.trim().toLowerCase();
        return ordenes.filter((o) => {
            if (estado !== 'all' && o.estado !== estado) return false;
            if (grupo !== 'all') {
                const g = Number(grupo);
                if (o.grupo_id !== g && !(o.grupo_ids ?? []).includes(g)) return false;
            }
            // Rango sobre la fecha de emisión (o la de ejecución si no hay emisión).
            const f = o.fecha_emision ?? o.fecha_ejecucion ?? '';
            if (desde && (!f || f < desde)) return false;
            if (hasta && (!f || f > hasta)) return false;
            if (term && !`${o.codigo} ${o.descripcion ?? ''} ${o.informe_codigo ?? ''} ${o.nro_orden_banco ?? ''}`.toLowerCase().includes(term)) return false;
            return true;
        });
    }, [ordenes, estado, grupo, desde, hasta, q]);

    const total = filtradas.reduce((a, o) => a + Number(o.importe || 0), 0);

    function exportar() {
        if (filtradas.length === 0) {
            alert('No hay órdenes para exportar.');
            return;
        }
        const filas = filtradas.map((o) => ({
            'Código OP': o.codigo,
            'Fecha emisión': o.fecha_emision ?? '',
            'Informe': o.informe_codigo ?? '',
            'Grupo': o.grupo ?? o.grupos_lineas,
            'Modalidad': o.modalidad ? ETIQUETA_MODALIDAD[o.modalidad] ?? o.modalidad : '',
            'Descripción': o.descripcion ?? '',
            'N° becarios': o.n_becarios ?? '',
            'Líneas': o.lineas,
            'Líneas pagadas': o.pagadas,
            'Importe (S/)': Number(o.importe),
            'Σ líneas (S/)': Number(o.suma_lineas),
            'Estado': ETIQUETA_ESTADO[o.estado] ?? o.estado,
            'Día de pago': o.dia_pago ?? '',
            'Fecha ejecución': o.fecha_ejecucion ?? '',
            'N° orden banco': o.nro_orden_banco ?? '',
        }));
        const ws = XLSX.utils.json_to_sheet(filas);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Órdenes de pago');
        XLSX.writeFile(wb, `Ordenes_pago_becas_${new Date().toISOString().split('T')[0]}.xlsx`);
    }

    const sel = 'h-9 w-full rounded-lg border border-gray-200 px-3 py-1 text-[11px] focus:outline-none';
    return (
        <div className="space-y-4">
            <div className="flex flex-wrap items-end justify-between gap-3">
                <div className="grid flex-1 grid-cols-2 gap-3 md:grid-cols-5">
                    <div className="space-y-1">
                        <label className="px-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Estado</label>
                        <select className={sel} value={estado} onChange={(e) => setEstado(e.target.value)}>
                            <option value="all">Todos</option>
                            {ESTADOS_OP.map((e) => <option key={e} value={e}>{ETIQUETA_ESTADO[e]}</option>)}
                        </select>
                    </div>
                    <div className="space-y-1">
                        <label className="px-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Grupo</label>
                        <select className={sel} value={grupo} onChange={(e) => setGrupo(e.target.value)}>
                            <option value="all">Todos</option>
                            {grupos.map((g) => <option key={g.value} value={g.value}>{g.label}</option>)}
                        </select>
                    </div>
                    <div className="space-y-1">
                        <label className="px-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Desde</label>
                        <input type="date" className={sel} value={desde} onChange={(e) => setDesde(e.target.value)} />
                    </div>
                    <div className="space-y-1">
                        <label className="px-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Hasta</label>
                        <input type="date" className={sel} value={hasta} onChange={(e) => setHasta(e.target.value)} />
                    </div>
                    <div className="space-y-1">
                        <label className="px-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Buscar</label>
                        <div className="relative">
                            <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-300" />
                            <input className={`${sel} pl-8`} placeholder="Código, informe, glosa…" value={q} onChange={(e) => setQ(e.target.value)} />
                        </div>
                    </div>
                </div>
                <div className="flex items-center gap-2">
                    <Link
                        href="/dashboard/gestion-servicios/ordenes-pago/importar"
                        className="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-bold text-white shadow-lg shadow-blue-500/20 hover:bg-blue-700"
                    >
                        <FileUp className="h-4 w-4" />
                        Importar Anexo 02
                    </Link>
                    <button
                        onClick={exportar}
                        className="flex items-center gap-2 rounded-lg bg-emerald-600 px-4 py-2 text-sm font-bold text-white shadow-lg shadow-emerald-500/20 hover:bg-emerald-700"
                    >
                        <Download className="h-4 w-4" />
                        Excel
                    </button>
                </div>
            </div>

            <div className="overflow-x-auto rounded-xl border border-gray-100 bg-white shadow-sm">
                <table className="min-w-full text-xs">
                    <thead className="bg-gray-50 text-[10px] uppercase tracking-wider text-gray-500">
                        <tr>
                            <th className="px-3 py-2 text-left">Código</th>
                            <th className="px-3 py-2 text-left">Fecha</th>
                            <th className="px-3 py-2 text-left">Grupo</th>
                            <th className="px-3 py-2 text-left">Modalidad</th>
                            <th className="px-3 py-2 text-right">Becarios</th>
                            <th className="px-3 py-2 text-right">Importe</th>
                            <th className="px-3 py-2 text-left">Estado</th>
                            <th className="px-3 py-2 text-left">Día de pago</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-50">
                        {filtradas.map((o) => {
                            const descuadre = Math.abs(Number(o.importe) - Number(o.suma_lineas)) >= 0.005 && o.estado !== 'ANULADA';
                            return (
                                <tr key={o.id} className="hover:bg-blue-50/40">
                                    <td className="px-3 py-2 font-bold">
                                        <Link href={`/dashboard/gestion-servicios/ordenes-pago/${o.id}`} className="text-blue-700 hover:underline">
                                            {o.codigo}
                                        </Link>
                                        {o.descripcion && <div className="max-w-xs truncate text-[10px] font-normal text-gray-400" title={o.descripcion}>{o.descripcion}</div>}
                                    </td>
                                    <td className="whitespace-nowrap px-3 py-2">{fechaCorta(o.fecha_emision ?? o.fecha_ejecucion)}</td>
                                    <td className="px-3 py-2">{o.grupo ?? (o.grupos_lineas || '—')}</td>
                                    <td className="whitespace-nowrap px-3 py-2">{o.modalidad ? ETIQUETA_MODALIDAD[o.modalidad] ?? o.modalidad : '—'}</td>
                                    <td className="px-3 py-2 text-right">{o.n_becarios ?? '—'}</td>
                                    <td className={`whitespace-nowrap px-3 py-2 text-right font-bold ${descuadre ? 'text-red-600' : ''}`} title={descuadre ? `Σ líneas ${soles(o.suma_lineas)}` : undefined}>
                                        {soles(o.importe)}
                                    </td>
                                    <td className="px-3 py-2"><EstadoBadge estado={o.estado} /></td>
                                    <td className="whitespace-nowrap px-3 py-2">{fechaCorta(o.dia_pago)}</td>
                                </tr>
                            );
                        })}
                        {filtradas.length === 0 && (
                            <tr>
                                <td colSpan={8} className="px-3 py-8 text-center italic text-gray-400">
                                    {ordenes.length === 0 ? 'Todavía no hay órdenes de pago registradas.' : 'Ninguna orden cumple los filtros.'}
                                </td>
                            </tr>
                        )}
                    </tbody>
                    {filtradas.length > 0 && (
                        <tfoot className="bg-gray-50 text-[11px] font-bold">
                            <tr>
                                <td className="px-3 py-2" colSpan={5}>{filtradas.length} orden(es)</td>
                                <td className="whitespace-nowrap px-3 py-2 text-right">{soles(total)}</td>
                                <td colSpan={2} />
                            </tr>
                        </tfoot>
                    )}
                </table>
            </div>
        </div>
    );
}
