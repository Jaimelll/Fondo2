import { 
    getLineas, 
    getEjes, 
    getEtapas, 
    getModalidades, 
    getEtapasList 
} from "../actions";
import { 
    getServiciosGestionData, 
    getCondiciones, 
    getInstitucionesBeca, 
    getGrupos,
    getTiposEstudio,
    getNaturalezasIE,
    getFormatos,
    getEmpresas
} from "./actions";
import Link from "next/link";
import GestionServiciosTable from "@/components/servicios/GestionServiciosTable";
import { FolderHeart, Receipt } from "lucide-react";

export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default async function GestionServiciosPage() {
    const [
        data, 
        lines, 
        ejes, 
        etapas, 
        modalidades, 
        instituciones, 
        condiciones,
        etapasList,
        grupos,
        tiposEstudio,
        naturalezasIE,
        formatos,
        empresas
    ] = await Promise.all([
        getServiciosGestionData(),
        getLineas(),
        getEjes(),
        getEtapas(),
        getModalidades(),
        getInstitucionesBeca(),
        getCondiciones(),
        getEtapasList(),
        getGrupos(),
        getTiposEstudio(),
        getNaturalezasIE(),
        getFormatos(),
        getEmpresas()
    ]);

    return (
        <div className="space-y-4">
            <div className="flex justify-between items-center bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                <div className="flex items-center gap-4">
                    <div className="p-3 bg-blue-600 rounded-2xl shadow-lg shadow-blue-500/20 text-white">
                        <FolderHeart className="w-6 h-6" />
                    </div>
                    <div>
                        <h2 className="text-2xl font-black text-slate-900 tracking-tight leading-none italic uppercase">
                            Gestión de Servicios
                        </h2>
                        <p className="text-[10px] text-blue-600 font-extrabold uppercase tracking-widest mt-1">
                            Administración Maestra y Seguimiento de Avances
                        </p>
                    </div>
                </div>
                <Link
                    href="/dashboard/gestion-servicios/ordenes-pago"
                    className="flex items-center gap-2 px-4 py-2 bg-slate-900 hover:bg-slate-700 text-white rounded-lg transition-colors text-sm font-bold"
                >
                    <Receipt className="w-4 h-4" />
                    Órdenes de pago
                </Link>
            </div>

            <div className="bg-gray-50/50 p-4 rounded-2xl border border-gray-100">
                <GestionServiciosTable 
                    initialData={data} 
                    lines={lines} 
                    ejes={ejes} 
                    etapas={etapasList} 
                    modalidades={modalidades} 
                    instituciones={instituciones}
                    condiciones={condiciones}
                    grupos={grupos}
                    tiposEstudio={tiposEstudio}
                    naturalezasIE={naturalezasIE}
                    formatos={formatos}
                    empresas={empresas}
                />
            </div>
        </div>
    );
}
