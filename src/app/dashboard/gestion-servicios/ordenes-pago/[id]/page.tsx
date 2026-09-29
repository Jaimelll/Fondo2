import Link from "next/link";
import { notFound } from "next/navigation";
import { ChevronLeft } from "lucide-react";
import { getOrdenPago } from "../../actions";
import OrdenPagoDetalle from "@/components/servicios/ordenes-pago/OrdenPagoDetalle";

export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default async function OrdenPagoPage({ params }: { params: Promise<{ id: string }> }) {
    const { id } = await params;
    const n = Number(id);
    if (!Number.isInteger(n) || n <= 0) notFound();
    const orden = await getOrdenPago(n);
    if (!orden) notFound();

    return (
        <div className="space-y-4">
            <Link
                href="/dashboard/gestion-servicios/ordenes-pago"
                className="inline-flex items-center gap-1 rounded-lg px-3 py-2 text-sm font-bold text-gray-500 hover:bg-gray-100"
            >
                <ChevronLeft className="h-4 w-4" />
                Órdenes de pago
            </Link>
            <OrdenPagoDetalle orden={orden} />
        </div>
    );
}
