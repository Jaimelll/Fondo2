"use client";

import { useMemo, useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { CheckCircle2, CircleAlert, FileUp, TriangleAlert } from "lucide-react";
import {
    confirmarImportacionAnexo,
    previsualizarAnexo,
    type CabeceraImportacion,
    type LineaImportacion,
    type VistaPreviaAnexo,
} from "@/app/dashboard/gestion-servicios/actions";
import { ESTADOS_OP_MANUALES, ETIQUETA_ESTADO, ETIQUETA_MODALIDAD, cciLegible, soles } from "./comun";

/**
 * Importar una OP desde el Anexo 02: subir el .xlsx → vista previa con las filas
 * visibles de la hoja de pago, emparejadas por DNI y validadas → confirmar.
 * Nada se guarda hasta pulsar «Guardar OP».
 */
export default function ImportarAnexo() {
    const router = useRouter();
    const [pendiente, startTransition] = useTransition();
    const [archivo, setArchivo] = useState<File | null>(null);
    const [vista, setVista] = useState<VistaPreviaAnexo | null>(null);
    const [cab, setCab] = useState<CabeceraImportacion | null>(null);
    const [lineas, setLineas] = useState<LineaImportacion[]>([]);
    const [error, setError] = useState<string | null>(null);

    function leer(hoja?: string) {
        if (!archivo) return;
        setError(null);
        const fd = new FormData();
        fd.append('archivo', archivo);
        if (hoja) fd.append('hoja', hoja);
        startTransition(async () => {
            const r = await previsualizarAnexo(fd);
            if (!r.ok) {
                setError(r.error ?? 'No se pudo leer el archivo.');
                setVista(null);
                return;
            }
            setVista(r);
            setCab(r.cabecera!);
            setLineas(r.lineas!);
        });
    }

    function guardar() {
        if (!cab) return;
        setError(null);
        startTransition(async () => {
            const r = await confirmarImportacionAnexo(cab, lineas);
            if (!r.ok) {
                setError(r.error ?? 'No se pudo guardar.');
                return;
            }
            router.push(`/dashboard/gestion-servicios/ordenes-pago/${r.id}`);
        });
    }

    const incluidas = lineas.filter((l) => l.incluir);
    const suma = Math.round(incluidas.reduce((a, l) => a + Number(l.monto), 0) * 100) / 100;
    const cuadra = cab ? Math.abs(Number(cab.importe) - suma) < 0.005 : false;
    const errores = incluidas.reduce((n, l) => n + l.hallazgos.filter((h) => h.severidad === 'error').length, 0);
    const alertas = incluidas.reduce((n, l) => n + l.hallazgos.filter((h) => h.severidad === 'alerta').length, 0);
    const conceptos = vista?.conceptos ?? [];
    const puedeGuardar = Boolean(cab?.codigo && cab?.numero) && incluidas.length > 0 && errores === 0 && cuadra && !pendiente;

    const setLinea = (i: number, cambio: Partial<LineaImportacion>) =>
        setLineas((ls) => ls.map((l, k) => (k === i ? { ...l, ...cambio } : l)));

    const hojasCandidatas = useMemo(() => vista?.lectura?.hojasVisibles.filter((h) => h.esCandidata) ?? [], [vista]);
    const input = 'w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-xs focus:outline-none';
    const etiqueta = 'text-[10px] font-bold uppercase text-gray-400';

    return (
        <div className="space-y-4">
            <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
                <h2 className="text-2xl font-black tracking-tight text-slate-900">Importar OP desde el Anexo 02</h2>
                <p className="mt-1 text-sm text-gray-500">
                    Se leen solo las filas <b>visibles</b> de la hoja de pago (las ocultas son becarios que no cobran) y se ignoran las copias de la muestra.
                    Cada fila se empareja por DNI con su beca. Nada se guarda hasta que confirmes.
                </p>
                <div className="mt-4 flex flex-wrap items-center gap-3">
                    <input
                        type="file"
                        accept=".xlsx"
                        onChange={(e) => { setArchivo(e.target.files?.[0] ?? null); setVista(null); }}
                        className="text-xs file:mr-3 file:rounded-lg file:border-0 file:bg-blue-50 file:px-3 file:py-2 file:text-xs file:font-bold file:text-blue-700"
                    />
                    <button
                        disabled={!archivo || pendiente}
                        onClick={() => leer()}
                        className="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-xs font-bold text-white hover:bg-blue-700 disabled:bg-blue-300"
                    >
                        <FileUp className="h-4 w-4" />
                        {pendiente && !vista ? 'Leyendo…' : 'Vista previa'}
                    </button>
                </div>
                {error && <p className="mt-4 whitespace-pre-line rounded-lg bg-red-50 p-3 text-xs text-red-800">{error}</p>}
            </div>

            {vista?.ok && cab && (
                <>
                    {/* Lectura */}
                    <div className="rounded-2xl border border-gray-100 bg-white p-6 text-xs shadow-sm">
                        <div className="flex flex-wrap items-center gap-3">
                            <span>Hoja leída: <b>«{vista.lectura!.hoja.trim()}»</b> (encabezado en la fila {vista.lectura!.filaEncabezado})</span>
                            {hojasCandidatas.length > 1 && (
                                <select className="rounded border border-gray-200 px-2 py-1" value={vista.lectura!.hoja} onChange={(e) => leer(e.target.value)}>
                                    {hojasCandidatas.map((h) => <option key={h.nombre} value={h.nombre}>{h.nombre.trim()}</option>)}
                                </select>
                            )}
                            <span className="text-gray-400">· {lineas.length} filas visibles · {vista.lectura!.filasOcultasIgnoradas} filas ocultas ignoradas</span>
                        </div>
                        {vista.lectura!.avisos.length > 0 && (
                            <ul className="mt-3 list-disc space-y-1 pl-5 text-amber-800">
                                {vista.lectura!.avisos.map((a, i) => <li key={i}>{a}</li>)}
                            </ul>
                        )}
                    </div>

                    {/* Cabecera editable */}
                    <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
                        <h3 className="mb-3 text-sm font-black uppercase text-slate-700">Datos de la OP</h3>
                        <div className="grid gap-3 md:grid-cols-4">
                            <Campo label="Código OP *" className={etiqueta}>
                                <input className={input} value={cab.codigo} onChange={(e) => setCab({ ...cab, codigo: e.target.value })} placeholder="205-UPS-AS/FE-2026" />
                            </Campo>
                            <Campo label="Número *" className={etiqueta}>
                                <input className={input} value={cab.numero ?? ''} onChange={(e) => setCab({ ...cab, numero: e.target.value ? Number(e.target.value.replace(/\D/g, '')) : null })} />
                            </Campo>
                            <Campo label="Año *" className={etiqueta}>
                                <input className={input} value={cab.anio} onChange={(e) => setCab({ ...cab, anio: Number(e.target.value.replace(/\D/g, '')) })} />
                            </Campo>
                            <Campo label="Fecha de emisión" className={etiqueta}>
                                <input type="date" className={input} value={cab.fecha_emision ?? ''} onChange={(e) => setCab({ ...cab, fecha_emision: e.target.value || null })} />
                            </Campo>
                            <Campo label="Informe" className={etiqueta}>
                                <input className={input} value={cab.informe_codigo ?? ''} onChange={(e) => setCab({ ...cab, informe_codigo: e.target.value || null })} placeholder="209-UPS-AS/FE-2026" />
                            </Campo>
                            <Campo label="Grupo" className={etiqueta}>
                                <select className={input} value={cab.grupo_id ?? ''} onChange={(e) => setCab({ ...cab, grupo_id: e.target.value ? Number(e.target.value) : null })}>
                                    <option value="">— Varios —</option>
                                    {vista.grupos!.map((g) => <option key={g.id} value={g.id}>{g.descripcion}</option>)}
                                </select>
                            </Campo>
                            <Campo label="Línea" className={etiqueta}>
                                <select className={input} value={cab.linea_id ?? ''} onChange={(e) => setCab({ ...cab, linea_id: e.target.value ? Number(e.target.value) : null })}>
                                    <option value="">—</option>
                                    {vista.lineasCat!.map((l) => <option key={l.id} value={l.id}>{l.descripcion}</option>)}
                                </select>
                            </Campo>
                            <Campo label="Modalidad" className={etiqueta}>
                                <select className={input} value={cab.modalidad} onChange={(e) => setCab({ ...cab, modalidad: e.target.value as CabeceraImportacion['modalidad'] })}>
                                    {Object.entries(ETIQUETA_MODALIDAD).map(([k, v]) => <option key={k} value={k}>{v}</option>)}
                                </select>
                            </Campo>
                            <Campo label="Estado inicial" className={etiqueta}>
                                <select className={input} value={cab.estado} onChange={(e) => setCab({ ...cab, estado: e.target.value })}>
                                    {ESTADOS_OP_MANUALES.map((e) => <option key={e} value={e}>{ETIQUETA_ESTADO[e]}</option>)}
                                </select>
                            </Campo>
                            <Campo label="Importe de la OP (S/) *" className={etiqueta}>
                                <input className={input} value={cab.importe} onChange={(e) => setCab({ ...cab, importe: Number(e.target.value.replace(/[^0-9.]/g, '')) || 0 })} />
                            </Campo>
                            <div className="md:col-span-2">
                                <Campo label="Descripción" className={etiqueta}>
                                    <input className={input} value={cab.descripcion ?? ''} onChange={(e) => setCab({ ...cab, descripcion: e.target.value || null })} />
                                </Campo>
                            </div>
                            <div className="md:col-span-4">
                                <Campo label="Observaciones" className={etiqueta}>
                                    <input className={input} value={cab.observaciones ?? ''} onChange={(e) => setCab({ ...cab, observaciones: e.target.value || null })} />
                                </Campo>
                            </div>
                        </div>

                        <div className="mt-4 flex flex-wrap items-center justify-between gap-3 border-t border-gray-100 pt-4">
                            <div className="flex flex-wrap items-center gap-2 text-xs">
                                <span className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 font-bold ${cuadra ? 'bg-emerald-100 text-emerald-800' : 'bg-red-100 text-red-700'}`}>
                                    {cuadra ? <CheckCircle2 className="h-3.5 w-3.5" /> : <CircleAlert className="h-3.5 w-3.5" />}
                                    Importe {soles(cab.importe)} · Σ {incluidas.length} líneas {soles(suma)}
                                </span>
                                {errores > 0 && <span className="rounded-full bg-red-100 px-2 py-0.5 font-bold text-red-700">{errores} error(es)</span>}
                                {alertas > 0 && <span className="rounded-full bg-amber-100 px-2 py-0.5 font-bold text-amber-800">{alertas} alerta(s)</span>}
                            </div>
                            <button
                                disabled={!puedeGuardar}
                                onClick={guardar}
                                title={puedeGuardar ? undefined : 'Corrige los errores, completa el código y haz cuadrar el importe'}
                                className="rounded-lg bg-emerald-600 px-5 py-2 text-xs font-bold text-white hover:bg-emerald-700 disabled:bg-gray-300"
                            >
                                {pendiente ? 'Guardando…' : 'Guardar OP'}
                            </button>
                        </div>
                    </div>

                    {/* Líneas */}
                    <div className="overflow-x-auto rounded-2xl border border-gray-100 bg-white shadow-sm">
                        <table className="min-w-full text-xs">
                            <thead className="bg-gray-50 text-[10px] uppercase tracking-wider text-gray-500">
                                <tr>
                                    <th className="px-2 py-2">Incl.</th>
                                    <th className="px-2 py-2 text-left">Fila</th>
                                    <th className="px-2 py-2 text-left">Becario (DNI)</th>
                                    <th className="px-2 py-2 text-left">Concepto</th>
                                    <th className="px-2 py-2 text-left">Periodo</th>
                                    <th className="px-2 py-2 text-left">Se abona a</th>
                                    <th className="px-2 py-2 text-left">CCI</th>
                                    <th className="px-2 py-2 text-right">Monto</th>
                                    <th className="px-2 py-2 text-left">Validación</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-gray-50 align-top">
                                {lineas.map((l, i) => (
                                    <tr key={l.fila} className={l.incluir ? undefined : 'bg-gray-50 text-gray-400'}>
                                        <td className="px-2 py-2 text-center">
                                            <input type="checkbox" checked={l.incluir} onChange={(e) => setLinea(i, { incluir: e.target.checked })} />
                                        </td>
                                        <td className="px-2 py-2">{l.fila}</td>
                                        <td className="px-2 py-2">
                                            <div className="font-bold text-gray-800">{l.becario ?? '—'}</div>
                                            <div className="text-[10px] text-gray-400">DNI {l.dni ?? '—'}{l.beca_id ? ` · id ${l.beca_id}` : ''}{l.grupo ? ` · ${l.grupo}` : ''}{l.condicion ? ` · ${l.condicion}` : ''}</div>
                                        </td>
                                        <td className="px-2 py-2">
                                            <select
                                                className="w-40 rounded border border-gray-200 px-1 py-1 text-[11px]"
                                                value={l.concepto_id ?? ''}
                                                onChange={(e) => {
                                                    const id = e.target.value ? Number(e.target.value) : null;
                                                    // El error «concepto no reconocido» se resuelve al elegirlo; el servidor revalida al guardar.
                                                    setLinea(i, { concepto_id: id, hallazgos: id ? l.hallazgos.filter((h) => h.campo !== 'concepto') : l.hallazgos });
                                                }}
                                            >
                                                <option value="">— ¿?  —</option>
                                                {conceptos.map((c) => <option key={c.id} value={c.id}>{c.codigo}</option>)}
                                            </select>
                                            <div className="text-[10px] text-gray-400">{l.codigo_concepto}</div>
                                        </td>
                                        <td className="px-2 py-2">
                                            <input className="w-20 rounded border border-gray-200 px-1 py-1 text-[11px]" value={l.periodo_academico ?? ''} onChange={(e) => setLinea(i, { periodo_academico: e.target.value || null })} />
                                        </td>
                                        <td className="px-2 py-2">
                                            <div className="font-semibold">{l.beneficiario_nombre}</div>
                                            <div className="text-[10px] text-gray-400">{l.tipo_abono === 'IE' ? 'IE' : 'Becario'} · {l.beneficiario_doc_tipo} {l.beneficiario_doc}</div>
                                        </td>
                                        <td className="whitespace-nowrap px-2 py-2 font-mono">{cciLegible(l.cci)}</td>
                                        <td className="whitespace-nowrap px-2 py-2 text-right font-bold">{soles(l.monto)}</td>
                                        <td className="px-2 py-2">
                                            {l.hallazgos.length === 0 && !l.observacion ? (
                                                <span className="inline-flex items-center gap-1 text-emerald-700"><CheckCircle2 className="h-3.5 w-3.5" /> OK</span>
                                            ) : (
                                                <ul className="max-w-sm space-y-0.5">
                                                    {l.hallazgos.map((h, k) => (
                                                        <li key={k} className={`flex gap-1 ${h.severidad === 'error' ? 'text-red-700' : 'text-amber-700'}`}>
                                                            {h.severidad === 'error' ? <CircleAlert className="mt-0.5 h-3 w-3 shrink-0" /> : <TriangleAlert className="mt-0.5 h-3 w-3 shrink-0" />}
                                                            <span>{h.mensaje}</span>
                                                        </li>
                                                    ))}
                                                    {l.observacion && <li className="text-sky-700">{l.observacion}</li>}
                                                </ul>
                                            )}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </>
            )}
        </div>
    );
}

function Campo({ label, className, children }: { label: string; className: string; children: React.ReactNode }) {
    return (
        <div className="space-y-1">
            <label className={className}>{label}</label>
            {children}
        </div>
    );
}
