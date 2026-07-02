import { headers } from 'next/headers';
import { NextResponse } from 'next/server';
import { auth } from '@/lib/auth';

async function signOutAndRedirect(request: Request) {
    const host = request.headers.get('host');
    const protocol = request.headers.get('x-forwarded-proto') || 'http';
    const base = `${protocol}://${host}`;

    // Revoca la sesión en la base y limpia la cookie httpOnly (nextCookies).
    try {
        await auth.api.signOut({ headers: await headers() });
    } catch {
        // Sin sesión activa: igual redirigimos al login.
    }

    return NextResponse.redirect(new URL('/', base), {
        status: 302,
    });
}

export async function POST(request: Request) {
    return signOutAndRedirect(request);
}

export async function GET(request: Request) {
    return signOutAndRedirect(request);
}
