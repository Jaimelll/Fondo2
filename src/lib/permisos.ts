import { query } from './db';
import { getNormalizedEmail, type Modulos } from '@/config/permissions';

/**
 * Módulos permitidos de un usuario, leídos de la tabla usuarios_modulos
 * (reemplaza la matriz hardcodeada de config/permissions.ts). Una fila con
 * modulo = 'ALL' otorga acceso total.
 */
export async function getModulosUsuario(email: string | null | undefined): Promise<Modulos> {
    const norm = getNormalizedEmail(email);
    if (!norm) return [];
    const { rows } = await query<{ modulo: string }>(
        'select modulo from usuarios_modulos where email = $1',
        [norm],
    );
    const modulos = rows.map((r) => r.modulo);
    return modulos.includes('ALL') ? 'ALL' : modulos;
}
