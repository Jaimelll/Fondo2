import { NextResponse, type NextRequest } from 'next/server';
import { query } from '@/lib/db';
import { getNormalizedEmail, isRutaPermitida, SUPER_ADMIN, type Modulos } from '@/config/permissions';

// ─────────────────────────────────────────────────────────────────────────────
// Gate de autenticación y permisos por módulo. Corre en runtime Node (Next 16),
// así que consulta Postgres directamente: valida el token de sesión de
// Better-Auth contra la tabla "session" y los permisos contra usuarios_modulos.
// No usa auth.api.getSession para no arrastrar toda la instancia de Better-Auth
// (y su manejo de cookies vía next/headers, no disponible aquí) al proxy.
// ─────────────────────────────────────────────────────────────────────────────

const SESSION_COOKIES = ['better-auth.session_token', '__Secure-better-auth.session_token'];

async function getSessionEmail(request: NextRequest): Promise<string | null> {
    const raw = SESSION_COOKIES
        .map((name) => request.cookies.get(name)?.value)
        .find(Boolean);
    if (!raw) return null;

    // La cookie es "<token>.<firma>"; el token opaco de la tabla session basta
    // como autenticador (la firma solo ahorra hits a la base).
    const token = decodeURIComponent(raw).split('.')[0];
    if (!token) return null;

    const { rows } = await query<{ email: string }>(
        `select u.email
           from "session" s
           join "user" u on u.id = s."userId"
          where s.token = $1 and s."expiresAt" > now()`,
        [token],
    );
    return rows[0]?.email ?? null;
}

async function getModulos(email: string): Promise<Modulos> {
    const { rows } = await query<{ modulo: string }>(
        'select modulo from usuarios_modulos where email = $1',
        [email],
    );
    const modulos = rows.map((r) => r.modulo);
    return modulos.includes('ALL') ? 'ALL' : modulos;
}

export async function proxy(request: NextRequest) {
    const { pathname } = request.nextUrl;

    // Rutas de auth siempre accesibles (login, signout y la API de Better-Auth)
    if (pathname.startsWith('/auth/') || pathname.startsWith('/api/auth/')) {
        return NextResponse.next();
    }

    // ── 1. Usuario NO autenticado ─────────────────────────────────────────────
    const email = getNormalizedEmail(await getSessionEmail(request));
    if (!email) {
        return NextResponse.redirect(new URL('/auth/login', request.url));
    }

    // ── 2. Usuario autenticado ────────────────────────────────────────────────
    // Super Admin: acceso incondicional a todo
    if (email === SUPER_ADMIN) return NextResponse.next();

    // ── 3. Verificar permisos por módulo para rutas /dashboard/* ─────────────
    if (pathname.startsWith('/dashboard')) {
        const modulos = await getModulos(email);
        if (!isRutaPermitida(modulos, pathname)) {
            // Evitar bucle: /dashboard siempre es permitido
            return NextResponse.redirect(new URL('/dashboard', request.url));
        }
    }

    return NextResponse.next();
}

export const config = {
    matcher: [
        '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
    ],
}
