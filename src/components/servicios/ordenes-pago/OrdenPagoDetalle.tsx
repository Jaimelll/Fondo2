"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { Ban, CheckCircle2, CircleAlert, Landmark, XCircle } from "lucide-react";
import { anularOP, cambiarEstadoOP, rechazarLineaOP, registrarPagoEjecutado, type ResultadoOP } from "@/app/dashboard/gestion-servicios/actions";
import { ESTADOS_OP_MANUALES, ETIQUETA_ESTADO, ETIQUETA_MODALIDAD, EstadoBadge, cciLegible, fechaCorta, soles } from "./comun";

type Linea = {
    id: number;
    fila_anexo: number | null;
    beca_id: number;
    becario: string;
    becario_dni: string | null;
    grupo: string | null;
    concepto_codigo: string;
    concepto_nombre: string;
    periodo_academico: string | null;
    institucion: string | null;
    cuenta_contable: string | null;
    tipo_abono: 'IE' | 'BECARIO';
    beneficiario_nombre: string;
    beneficiario_doc_tipo: string;
    beneficiario_doc: string;
    banco_sigla: string | null;
    banco_nombre: string | null;
    numero_cuenta: string | null;
    cci: string | null;
    monto: number;
    comprobante_numero: string | null;
    comprobante_fecha: string | null;
    comprobante_monto: number | null;
    estado: string;
    avance_beca_id: number | null;
    avance_fecha: string | null;
    observacion: string | null;
};

export default function OrdenPagoDetalle({ orden }: { orden: any }) {
    const router = useRouter();
    const [pendiente, startTransition] = useTransition();
    const [msg, setMsg] = useState<{ ok: boolean; texto: string } | null>(null);
    const [panel, setPanel] = useState<'estado' | 'pago' | 'anular' | null>(null);

    const [nuevoEstado, setNuevoEstado] = useState<string>(orden.estado);
    const [diaPago, setDiaPago] = useState<string>(orden.dia_pago ?? '');
    const [txt, setTxt] = useState<string>(orden.txt_archivo ?? '');
    const [carpeta, setCarpeta] = useState<string>(orden.carpeta_sharepoint ?? '');
    const [fechaEjec, setFechaEjec] = useState<string>(orden.fecha_ejecucion ?? '');
    const [nroOrden, setNroOrden] = useState<string>(orden.nro_orden_banco ?? '');
    const [importeCargado, setImporteCargado] = useState<string>(orden.importe_cargado != null ? String(orden.importe_cargado) : '');
    const [motivo, setMotivo] = useState('');

    const lineas: Linea[] = orden.lineas ?? [];
    const vigentes = lineas.filter((l) => l.estado !== 'ANULADA' && l.estado !== 'RECHAZADA');
    const suma = Math.round(vigentes.reduce((a, l) => a + Number(l.monto), 0) * 100) / 100;
    const cuadra = Math.abs(Number(orden.importe) - suma) < 0.005;
    const cerrada = orden.estado === 'PAGADA' || orden.estado === 'ANULADA';
    const hayPagadas = lineas.some((l) => l.estado === 'PAGADA');

    function correr(fn: () => Promise<ResultadoOP>) {
        setMsg(null);
        startTransition(async () => {
            const r = await fn();
            setMsg({ ok: r.ok, texto: r.ok ? r.mensaje ?? 'Listo.' : r.error ?? 'No se pudo completar.' });
            if (r.ok) {
                setPanel(null);
                setMotivo('');
                router.refresh();
            }
        });
    }

    const input = 'w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-xs focus:outline-none';
    const etiqueta = 'text-[10px] font-bold uppercase text-gray-400';

    return (
        <div className="space-y-4">
            {/* Cabecera */}
            <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
                <div className="flex flex-wrap items-start justify-between gap-4">
                    <div>
                        <div className="flex items-center gap-3">
                            <h2 className="text-2xl font-black tracking-tight text-slate-900">OP {orden.codigo}</h2>
                            <EstadoBadge estado={orden.estado} />
                        </div>
                        <p className="mt-1 text-sm text-gray-500">{orden.descripcion ?? '—'}</p>
                    </div>
                    <div className="text-right">
                        <div className="text-[10px] font-bold uppercase text-gray-400">Importe de la OP</div>
                        <div className="text-2xl font-black text-slate-900">{soles(orden.importe)}</div>
                        <div className={`mt-1 inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[11px] font-bold ${cuadra ? 'bg-emerald-100 text-emerald-800' : 'bg-red-100 text-red-700'}`}>
                            {cuadra ? <CheckCircle2 className="h-3.5 w-3.5" /> : <CircleAlert className="h-3.5 w-3.5" />}
                            Σ líneas {soles(suma)} {cuadra ? '· cuadra' : `· diferencia ${soles(Number(orden.importe) - suma)}`}
                        </div>
                    </div>
                </div>

                <dl className="mt-5 grid grid-cols-2 gap-x-6 gap-y-3 text-xs md:grid-cols-4">
                    <Dato k="Fecha de emisión" v={fechaCorta(orden.fecha_emision)} />
                    <Dato k="Informe" v={orden.informe_codigo ?? '—'} />
                    <Dato k="Grupo" v={orden.grupo ?? 'Varios'} />
                    <Dato k="Modalidad" v={orden.modalidad ? ETIQUETA_MODALIDAD[orden.modalidad] ?? orden.modalidad : '—'} />
                    <Dato k="N° becarios" v={orden.n_becarios ?? '—'} />
                    <Dato k="Día de pago" v={fechaCorta(orden.dia_pago)} />
                    <Dato k="Archivo TXT" v={orden.txt_archivo ?? '—'} />
                    <Dato k="Fecha de ejecución" v={fechaCorta(orden.fecha_ejecucion)} />
                    <Dato k="N° orden banco" v={orden.nro_orden_banco ?? '—'} />
                    <Dato k="Importe cargado" v={orden.importe_cargado != null ? soles(orden.importe_cargado) : '—'} />
                    <Dato k="Registrada por" v={orden.created_by ?? '—'} />
                    <Dato k="Carpeta" v={orden.carpeta_sharepoint ?? '—'} />
                </dl>
                {orden.observaciones && (
                    <p className="mt-4 rounded-lg bg-amber-50 p-3 text-xs text-amber-900"><b>Observaciones:</b> {orden.observaciones}</p>
                )}

                {/* Acciones */}
                {!cerrada && (
                    <div className="mt-5 flex flex-wrap gap-2 border-t border-gray-100 pt-4">
                        <button onClick={() => setPanel(panel === 'estado' ? null : 'estado')} className="rounded-lg bg-slate-100 px-4 py-2 text-xs font-bold text-slate-700 hover:bg-slate-200">
                            Cambiar estado
                        </button>
                        <button onClick={() => setPanel(panel === 'pago' ? null : 'pago')} className="flex items-center gap-1.5 rounded-lg bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-700">
                            <Landmark className="h-4 w-4" />
                            Registrar pago ejecutado
                        </button>
                        {!hayPagadas && (
                            <button onClick={() => setPanel(panel === 'anular' ? null : 'anular')} className="flex items-center gap-1.5 rounded-lg bg-red-50 px-4 py-2 text-xs font-bold text-red-700 hover:bg-red-100">
                                <Ban className="h-4 w-4" />
                                Anular OP
                            </button>
                        )}
                    </div>
                )}

                {panel === 'estado' && (
                    <div className="mt-4 grid gap-3 rounded-xl border border-gray-100 bg-gray-50 p-4 md:grid-cols-4">
                        <div className="space-y-1">
                            <label className={etiqueta}>Estado</label>
                            <select className={input} value={nuevoEstado} onChange={(e) => setNuevoEstado(e.target.value)}>
                                {ESTADOS_OP_MANUALES.map((e) => <option key={e} value={e}>{ETIQUETA_ESTADO[e]}</option>)}
                            </select>
                        </div>
                        <div className="space-y-1">
                            <label className={etiqueta}>Día de pago (carpeta pago-Eli)</label>
                            <input type="date" className={input} value={diaPago} onChange={(e) => setDiaPago(e.target.value)} />
                        </div>
                        <div className="space-y-1">
                            <label className={etiqueta}>Archivo TXT</label>
                            <input className={input} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder="BBVAPROVBECA SUP.OP205.txt" />
                        </div>
                        <div className="space-y-1">
                            <label className={etiqueta}>Carpeta SharePoint</label>
                            <input className={input} value={carpeta} onChange={(e) => setCarpeta(e.target.value)} />
                        </div>
                        <div className="md:col-span-4 flex justify-end">
                            <button
                                disabled={pendiente}
                                onClick={() => correr(() => cambiarEstadoOP(orden.id, nuevoEstado, { dia_pago: diaPago || null, txt_archivo: txt || null, carpeta_sharepoint: carpeta || null }))}
                                className="rounded-lg bg-blue-600 px-4 py-2 text-xs font-bold text-white hover:bg-blue-700 disabled:bg-blue-300"
                            >
                                {pendiente ? 'Guardando…' : 'Guardar'}
                            </button>
                        </div>
                    </div>
                )}

                {panel === 'pago' && (
                    <div className="mt-4 space-y-3 rounded-xl border border-emerald-100 bg-emerald-50/50 p-4">
                        <p className="text-xs text-emerald-900">
                            Marca como <b>pagadas</b> las líneas pendientes y crea su evento en la bitácora del becario
                            (sustento <code>OP {orden.numero}-UPS-AS - S/ monto</code>). Si el evento ya existe, lo enlaza y no lo duplica.
                            Antes, marca como rechazadas las líneas que el banco no abonó.
                        </p>
                        <div className="grid gap-3 md:grid-cols-4">
                            <div className="space-y-1">
                                <label className={etiqueta}>Fecha de ejecución *</label>
                                <input type="date" className={input} value={fechaEjec} onChange={(e) => setFechaEjec(e.target.value)} />
                            </div>
                            <div className="space-y-1">
                                <label className={etiqueta}>N° de orden del banco *</label>
                                <input className={input} value={nroOrden} onChange={(e) => setNroOrden(e.target.value)} />
                            </div>
                            <div className="space-y-1">
                                <label className={etiqueta}>Importe cargado</label>
                                <input className={input} value={importeCargado} onChange={(e) => setImporteCargado(e.target.value.replace(/[^0-9.]/g, ''))} placeholder={String(suma)} />
                            </div>
                            <div className="space-y-1">
                                <label className={etiqueta}>Día de pago</label>
                                <input type="date" className={input} value={diaPago} onChange={(e) => setDiaPago(e.target.value)} />
                            </div>
                        </div>
                        <div className="flex justify-end">
                            <button
                                disabled={pendiente}
                                onClick={() => correr(() => registrarPagoEjecutado(orden.id, {
                                    fecha_ejecucion: fechaEjec,
                                    nro_orden_banco: nroOrden,
                                    importe_cargado: importeCargado ? Number(importeCargado) : null,
                                    dia_pago: diaPago || null,
                                }))}
                                className="rounded-lg bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-700 disabled:bg-emerald-300"
                            >
                                {pendiente ? 'Registrando…' : 'Confirmar pago ejecutado'}
                            </button>
                        </div>
                    </div>
                )}

                {panel === 'anular' && (
                    <div className="mt-4 flex flex-wrap items-end gap-3 rounded-xl border border-red-100 bg-red-50/50 p-4">
                        <div className="flex-1 space-y-1">
                            <label className={etiqueta}>Motivo de la anulación *</label>
                            <input className={input} value={motivo} onChange={(e) => setMotivo(e.target.value)} />
                        </div>
                        <button
                            disabled={pendiente}
                            onClick={() => correr(() => anularOP(orden.id, motivo))}
                            className="rounded-lg bg-red-600 px-4 py-2 text-xs font-bold text-white hover:bg-red-700 disabled:bg-red-300"
                        >
                            {pendiente ? 'Anulando…' : 'Anular OP'}
                        </button>
                    </div>
                )}

                {msg && (
                    <p className={`mt-4 whitespace-pre-line rounded-lg p-3 text-xs ${msg.ok ? 'bg-emerald-50 text-emerald-800' : 'bg-red-50 text-red-800'}`}>{msg.texto}</p>
                )}
            </div>

            {/* Líneas */}
            <div className="overflow-x-auto rounded-2xl border border-gray-100 bg-white shadow-sm">
                <table className="min-w-full text-xs">
                    <thead className="bg-gray-50 text-[10px] uppercase tracking-wider text-gray-500">
                        <tr>
                            <th className="px-3 py-2 text-left">Fila</th>
                            <th className="px-3 py-2 text-left">Becario</th>
                            <th className="px-3 py-2 text-left">Concepto</th>
                            <th className="px-3 py-2 text-left">IE</th>
                            <th className="px-3 py-2 text-left">Se abona a</th>
                            <th className="px-3 py-2 text-left">Cuenta</th>
                            <th className="px-3 py-2 text-right">Monto</th>
                            <th className="px-3 py-2 text-left">Comprobante</th>
                            <th className="px-3 py-2 text-left">Estado</th>
                            <th className="px-3 py-2" />
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-50 align-top">
                        {lineas.map((l) => (
                            <FilaLinea key={l.id} l={l} cerrada={cerrada} pendiente={pendiente} onRechazar={(m) => correr(() => rechazarLineaOP(l.id, m))} />
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

function Dato({ k, v }: { k: string; v: any }) {
    return (
        <div>
            <dt className="text-[10px] font-bold uppercase text-gray-400">{k}</dt>
            <dd className="font-semibold text-gray-800 break-words">{v}</dd>
        </div>
    );
}

function FilaLinea({ l, cerrada, pendiente, onRechazar }: { l: Linea; cerrada: boolean; pendiente: boolean; onRechazar: (motivo: string) => void }) {
    const [rechazando, setRechazando] = useState(false);
    const [motivo, setMotivo] = useState('');
    return (
        <tr className={l.estado === 'ANULADA' || l.estado === 'RECHAZADA' ? 'bg-gray-50/60 text-gray-400' : undefined}>
            <td className="px-3 py-2">{l.fila_anexo ?? '—'}</td>
            <td className="px-3 py-2">
                <div className="font-bold text-gray-800">{l.becario}</div>
                <div className="text-[10px] text-gray-400">DNI {l.becario_dni ?? '—'} · id {l.beca_id}{l.grupo ? ` · ${l.grupo}` : ''}</div>
            </td>
            <td className="px-3 py-2">
                <div className="font-semibold">{l.concepto_codigo}</div>
                <div className="text-[10px] text-gray-400">{l.periodo_academico ?? ''}</div>
            </td>
            <td className="px-3 py-2">
                <div>{l.institucion ?? '—'}</div>
                {l.cuenta_contable && <div className="text-[10px] text-gray-400">Cta. {l.cuenta_contable}</div>}
            </td>
            <td className="px-3 py-2">
                <div className="font-semibold">{l.beneficiario_nombre}</div>
                <div className="text-[10px] text-gray-400">{l.tipo_abono === 'IE' ? 'IE' : 'Becario'} · {l.beneficiario_doc_tipo} {l.beneficiario_doc}</div>
            </td>
            <td className="whitespace-nowrap px-3 py-2">
                <div className="font-mono">{cciLegible(l.cci)}</div>
                <div className="text-[10px] text-gray-400">{l.banco_sigla ?? l.banco_nombre ?? '—'}{l.numero_cuenta ? ` · ${l.numero_cuenta}` : ''}</div>
            </td>
            <td className="whitespace-nowrap px-3 py-2 text-right font-bold">{soles(l.monto)}</td>
            <td className="px-3 py-2">
                {l.comprobante_numero ? (
                    <>
                        <div>{l.comprobante_numero}</div>
                        <div className="text-[10px] text-gray-400">{fechaCorta(l.comprobante_fecha)}{l.comprobante_monto != null ? ` · ${soles(l.comprobante_monto)}` : ''}</div>
                    </>
                ) : '—'}
            </td>
            <td className="px-3 py-2">
                <EstadoBadge estado={l.estado} />
                {l.avance_beca_id && <div className="mt-1 text-[10px] text-emerald-700">Evento #{l.avance_beca_id} · {fechaCorta(l.avance_fecha)}</div>}
                {l.observacion && <div className="mt-1 max-w-xs text-[10px] text-amber-700">{l.observacion}</div>}
            </td>
            <td className="px-3 py-2">
                {!cerrada && l.estado === 'PENDIENTE' && (
                    rechazando ? (
                        <div className="flex w-56 flex-col gap-1">
                            <input className="rounded border border-gray-200 px-2 py-1 text-[11px]" placeholder="Motivo del rechazo" value={motivo} onChange={(e) => setMotivo(e.target.value)} />
                            <div className="flex gap-1">
                                <button disabled={pendiente} onClick={() => onRechazar(motivo)} className="rounded bg-red-600 px-2 py-1 text-[10px] font-bold text-white">Rechazar</button>
                                <button onClick={() => setRechazando(false)} className="rounded px-2 py-1 text-[10px] font-bold text-gray-500">Cancelar</button>
                            </div>
                        </div>
                    ) : (
                        <button onClick={() => setRechazando(true)} title="El banco rechazó este abono" className="rounded p-1 text-red-500 hover:bg-red-50">
                            <XCircle className="h-4 w-4" />
                        </button>
                    )
                )}
            </td>
        </tr>
    );
}
