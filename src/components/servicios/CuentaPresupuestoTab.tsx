"use client";

import Link from "next/link";
import { CheckCircle2, CircleAlert, CircleHelp } from "lucide-react";
import { EstadoBadge, cciLegible, fechaCorta, soles } from "./ordenes-pago/comun";

export type CuentaPresupuesto = {
    cuentas: any[];
    presupuesto: any[];
    lineas: any[];
};

/**
 * Pestaña «Cuenta y Presupuesto» del modal del becario (Gestión de Servicios):
 * cuenta vigente + historial, programado/ejecutado/saldo por concepto
 * (v_beca_saldo) y las líneas de OP en que aparece la beca.
 */
export default function CuentaPresupuestoTab({ datos, cargando, error }: { datos: CuentaPresupuesto | null; cargando: boolean; error: string | null }) {
    if (cargando) return <p className="py-8 text-center text-xs italic text-gray-400">Cargando cuenta y presupuesto…</p>;
    if (error) return <p className="rounded-xl bg-red-50 p-4 text-xs text-red-800">{error}</p>;
    if (!datos) return null;

    const vigente = datos.cuentas.find((c) => c.vigente);
    const historial = datos.cuentas.filter((c) => !c.vigente);
    const tot = datos.presupuesto.reduce(
        (a, p) => ({ prog: a.prog + Number(p.programado ?? 0), eje: a.eje + Number(p.ejecutado ?? 0), pend: a.pend + Number(p.pendiente ?? 0) }),
        { prog: 0, eje: 0, pend: 0 },
    );
    const titulo = 'text-[10px] font-bold uppercase tracking-wider text-gray-400';

    return (
        <div className="space-y-6">
            {/* Cuenta vigente */}
            <section className="space-y-2">
                <h4 className={titulo}>Cuenta vigente</h4>
                {vigente ? (
                    <div className="rounded-xl border border-gray-100 bg-gray-50/60 p-4 text-xs">
                        <div className="flex flex-wrap items-center justify-between gap-2">
                            <div>
                                <div className="font-bold text-gray-900">{vigente.titular_nombre}</div>
                                <div className="text-gray-500">{vigente.titular_tipo === 'AVAL' ? 'Aval' : 'Becario'} · DNI {vigente.titular_dni}</div>
                            </div>
                            <IndicadorCCI valido={vigente.cci_valido} />
                        </div>
                        <div className="mt-3 grid grid-cols-2 gap-3 md:grid-cols-3">
                            <div><div className={titulo}>Banco</div><div className="font-semibold">{vigente.banco_nombre ?? '—'}{vigente.banco_sigla ? ` (${vigente.banco_sigla})` : ''}</div></div>
                            <div><div className={titulo}>N° de cuenta</div><div className="font-mono">{vigente.numero_cuenta ?? '—'}</div></div>
                            <div><div className={titulo}>CCI</div><div className="font-mono">{cciLegible(vigente.cci)}</div></div>
                        </div>
                        <div className="mt-2 text-[10px] text-gray-400">
                            Desde {fechaCorta(vigente.desde)}{vigente.fuente ? ` · ${vigente.fuente}` : ''}
                            {vigente.observacion ? <span className="text-amber-700"> · {vigente.observacion}</span> : null}
                        </div>
                    </div>
                ) : (
                    <p className="rounded-xl bg-gray-50 py-4 text-center text-xs italic text-gray-400">Sin cuenta registrada.</p>
                )}
                {historial.length > 0 && (
                    <details className="text-xs">
                        <summary className="cursor-pointer text-[11px] font-bold text-blue-700">Historial de cuentas ({historial.length})</summary>
                        <table className="mt-2 w-full">
                            <tbody className="divide-y divide-gray-100">
                                {historial.map((c) => (
                                    <tr key={c.id} className="text-gray-500">
                                        <td className="py-1.5 pr-2">{fechaCorta(c.desde)}</td>
                                        <td className="py-1.5 pr-2">{c.titular_nombre}</td>
                                        <td className="py-1.5 pr-2">{c.banco_sigla ?? c.banco_nombre ?? '—'}</td>
                                        <td className="py-1.5 pr-2 font-mono">{cciLegible(c.cci)}</td>
                                        <td className="py-1.5"><IndicadorCCI valido={c.cci_valido} compacto /></td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </details>
                )}
            </section>

            {/* Presupuesto por concepto */}
            <section className="space-y-2">
                <h4 className={titulo}>Presupuesto por concepto</h4>
                {datos.presupuesto.length === 0 ? (
                    <p className="rounded-xl bg-gray-50 py-4 text-center text-xs italic text-gray-400">Sin presupuesto cargado.</p>
                ) : (
                    <div className="overflow-x-auto rounded-xl border border-gray-100">
                        <table className="min-w-full text-xs">
                            <thead className="bg-gray-50 text-[10px] uppercase text-gray-500">
                                <tr>
                                    <th className="px-3 py-2 text-left">Concepto</th>
                                    <th className="px-3 py-2 text-right">Programado</th>
                                    <th className="px-3 py-2 text-right">Ejecutado</th>
                                    <th className="px-3 py-2 text-right">Saldo</th>
                                    <th className="px-3 py-2 text-right">%</th>
                                    <th className="px-3 py-2 text-right">En trámite</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-gray-50">
                                {datos.presupuesto.map((p) => {
                                    const prog = Number(p.programado ?? 0);
                                    const eje = Number(p.ejecutado ?? 0);
                                    const pct = prog > 0 ? (eje / prog) * 100 : null;
                                    const saldo = p.tiene_presupuesto ? Number(p.saldo) : null;
                                    return (
                                        <tr key={p.concepto_id}>
                                            <td className="px-3 py-2">
                                                <div className="font-bold text-gray-800">{p.codigo}</div>
                                                <div className="text-[10px] text-gray-400">{p.nombre}</div>
                                            </td>
                                            <td className="px-3 py-2 text-right">{p.tiene_presupuesto ? soles(prog) : <span className="text-amber-700">sin programar</span>}</td>
                                            <td className="px-3 py-2 text-right">{soles(eje)}</td>
                                            <td className={`px-3 py-2 text-right font-bold ${saldo !== null && saldo < 0 ? 'text-red-600' : ''}`}>{saldo === null ? '—' : soles(saldo)}</td>
                                            <td className="px-3 py-2 text-right">
                                                {pct === null ? '—' : (
                                                    <div className="flex items-center justify-end gap-2">
                                                        <div className="h-1.5 w-14 overflow-hidden rounded bg-gray-100">
                                                            <div className={`h-full ${pct > 100 ? 'bg-red-500' : 'bg-blue-500'}`} style={{ width: `${Math.min(100, pct)}%` }} />
                                                        </div>
                                                        <span>{pct.toFixed(0)}%</span>
                                                    </div>
                                                )}
                                            </td>
                                            <td className="px-3 py-2 text-right text-amber-700">{Number(p.pendiente) > 0 ? soles(p.pendiente) : ''}</td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                            <tfoot className="bg-gray-50 font-bold">
                                <tr>
                                    <td className="px-3 py-2">Total</td>
                                    <td className="px-3 py-2 text-right">{soles(tot.prog)}</td>
                                    <td className="px-3 py-2 text-right">{soles(tot.eje)}</td>
                                    <td className="px-3 py-2 text-right">{soles(tot.prog - tot.eje)}</td>
                                    <td className="px-3 py-2 text-right">{tot.prog > 0 ? `${((tot.eje / tot.prog) * 100).toFixed(0)}%` : '—'}</td>
                                    <td className="px-3 py-2 text-right text-amber-700">{tot.pend > 0 ? soles(tot.pend) : ''}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                )}
                <p className="text-[10px] text-gray-400">Ejecutado = líneas de OP pagadas. «En trámite» = líneas de OP aún pendientes de pago.</p>
            </section>

            {/* Órdenes de pago */}
            <section className="space-y-2">
                <h4 className={titulo}>Órdenes de pago</h4>
                {datos.lineas.length === 0 ? (
                    <p className="rounded-xl bg-gray-50 py-4 text-center text-xs italic text-gray-400">No figura en ninguna OP registrada.</p>
                ) : (
                    <ul className="divide-y divide-gray-100 rounded-xl border border-gray-100 text-xs">
                        {datos.lineas.map((l) => (
                            <li key={l.id} className="flex flex-wrap items-center justify-between gap-2 px-3 py-2">
                                <Link href={`/dashboard/gestion-servicios/ordenes-pago/${l.orden_pago_id}`} className="font-bold text-blue-700 hover:underline">
                                    OP {l.codigo}
                                </Link>
                                <span className="text-gray-500">{l.concepto}{l.periodo_academico ? ` · ${l.periodo_academico}` : ''}</span>
                                <span className="font-bold">{soles(l.monto)}</span>
                                <EstadoBadge estado={l.estado} />
                            </li>
                        ))}
                    </ul>
                )}
            </section>
        </div>
    );
}

function IndicadorCCI({ valido, compacto = false }: { valido: boolean | null; compacto?: boolean }) {
    if (valido === true) return <span className="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-0.5 text-[10px] font-bold text-emerald-800"><CheckCircle2 className="h-3 w-3" />{compacto ? '' : 'CCI válido'}</span>;
    if (valido === false) return <span className="inline-flex items-center gap-1 rounded-full bg-red-100 px-2 py-0.5 text-[10px] font-bold text-red-700"><CircleAlert className="h-3 w-3" />{compacto ? '' : 'CCI no válido'}</span>;
    return <span className="inline-flex items-center gap-1 rounded-full bg-gray-100 px-2 py-0.5 text-[10px] font-bold text-gray-500"><CircleHelp className="h-3 w-3" />{compacto ? '' : 'CCI sin verificar'}</span>;
}
