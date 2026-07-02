import { redirect } from 'next/navigation';
import { Sidebar } from '@/components/Sidebar';
import { getSession } from '@/lib/session';
import { getModulosUsuario } from '@/lib/permisos';

export default async function DashboardLayout({
    children,
}: {
    children: React.ReactNode
}) {
    // El proxy ya bloquea a los no autenticados; esto es defensa en profundidad
    // y además provee email + módulos al Sidebar sin fetch en el cliente.
    const session = await getSession();
    if (!session) {
        redirect('/auth/login');
    }

    const email = session.user.email;
    const modulos = await getModulosUsuario(email);

    return (
        <div className="flex min-h-screen bg-slate-50 relative">
            <Sidebar email={email} modulos={modulos} />
            <main className="flex-1 p-4 lg:p-8 overflow-y-auto h-screen bg-slate-50">
                <div className="w-full mx-auto">
                    {children}
                </div>
            </main>
        </div>
    );
}
