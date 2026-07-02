import { headers } from 'next/headers';
import { auth } from './auth';

/** Sesión actual (o null) leída desde la cookie httpOnly. Solo servidor. */
export async function getSession() {
    return auth.api.getSession({ headers: await headers() });
}

/** Email normalizado del usuario autenticado, o null si no hay sesión. */
export async function getUserEmail(): Promise<string | null> {
    const session = await getSession();
    return session?.user.email?.toLowerCase().trim() ?? null;
}
