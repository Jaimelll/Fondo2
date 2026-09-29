import Link from "next/link";
import { ChevronLeft, Receipt } from "lucide-react";
import { getOrdenesPago, getGrupos } from "../actions";
import OrdenesPagoLista from "@/components/servicios/ordenes-pago/OrdenesPagoLista";

export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default async function OrdenesPagoPage() {
    const [ordenes, grupos] = await Promise.all([getOrdenesPago(), getGrupos()]);

    return (
        <div className="space-y-4">
            <div className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
                <div className="flex items-center gap-4">
                    <div className="rounded-2xl bg-blue-600 p-3 text-white shadow-lg shadow-blue-500/20">
                        <Receipt className="h-6 w-6" />
                    </div>
                    <div>
                        <h2 className="text-2xl font-black uppercase italic leading-none tracking-tight text-slate-900">
                            Órdenes de pago de becas
                        </h2>
                        <p className="mt-1 text-[10px] font-extrabold uppercase tracking-widest text-blue-600">
                            Gestión de Servicios · Anexo 02, estados y pagos ejecutados
                        </p>
                    </div>
                </div>
                <Link
                    href="/dashboard/gestion-servicios"
                    className="flex items-center gap-1 rounded-lg px-3 py-2 text-sm font-bold text-gray-500 hover:bg-gray-100"
                >
                    <ChevronLeft className="h-4 w-4" />
                    Volver a la bandeja
                </Link>
            </div>

            <div className="rounded-2xl border border-gray-100 bg-gray-50/50 p-4">
                <OrdenesPagoLista ordenes={ordenes as any[]} grupos={grupos} />
            </div>
        </div>
    );
}
