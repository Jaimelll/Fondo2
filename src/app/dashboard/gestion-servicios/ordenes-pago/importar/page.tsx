import Link from "next/link";
import { ChevronLeft } from "lucide-react";
import ImportarAnexo from "@/components/servicios/ordenes-pago/ImportarAnexo";

export const dynamic = 'force-dynamic';

export default function ImportarAnexoPage() {
    return (
        <div className="space-y-4">
            <Link
                href="/dashboard/gestion-servicios/ordenes-pago"
                className="inline-flex items-center gap-1 rounded-lg px-3 py-2 text-sm font-bold text-gray-500 hover:bg-gray-100"
            >
                <ChevronLeft className="h-4 w-4" />
                Órdenes de pago
            </Link>
            <ImportarAnexo />
        </div>
    );
}
