// ─────────────────────────────────────────────────────────────────────────────
// Permisos por módulo. La matriz usuario→módulos vive en la tabla
// usuarios_modulos (ver scripts/auth_schema.sql y src/lib/permisos.ts); aquí
// quedan solo el mapa módulo→ruta y helpers puros, usables tanto en el proxy
// como en componentes de cliente.
// ─────────────────────────────────────────────────────────────────────────────

export const SUPER_ADMIN = 'jduran@fondoempleo.com.pe';

/** Lista de módulos permitidos de un usuario; 'ALL' = acceso total. */
export type Modulos = string[] | 'ALL';

// Mapa de módulo → ruta principal (para validación en el proxy)
export const RUTA_POR_MODULO: Record<string, string> = {
    'Inf. Gerencial': '/dashboard/inf-gerencial',
    'Proyectos': '/dashboard',
    'Servicios': '/dashboard/servicios',
    'Documentos': '/dashboard/documentos',
    'Gestión de Proyectos': '/dashboard/gestion-proyectos',
    'Gestión de Servicios': '/dashboard/gestion-servicios',
    'Gestión de Aportantes': '/dashboard/gestion-aportantes',
    'Catálogos': '/dashboard/catalogos', // solo super admin (ver Sidebar y guardas de página)
};

// Rutas que siempre están permitidas sin importar el perfil.
// Ojo: '/dashboard' se compara EXACTO (es la landing "Proyectos"); si se
// comparara por prefijo, todo /dashboard/* quedaría abierto a cualquier
// usuario autenticado.
export const RUTAS_PUBLICAS_AUTENTICADO = [
    '/dashboard',
    '/auth/signout',
    '/presentation',
];

/** true si `ruta` cubre `pathname` ('/dashboard' solo se cubre a sí misma) */
function rutaCubre(ruta: string, pathname: string): boolean {
    if (ruta === '/dashboard') return pathname === '/dashboard';
    return pathname === ruta || pathname.startsWith(ruta + '/');
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

export function getNormalizedEmail(email?: string | null): string {
    return email ? email.toLowerCase().trim() : '';
}

/** Devuelve true si la lista de módulos incluye el módulo indicado */
export function tieneAccesoModulo(modulos: Modulos, modulo: string): boolean {
    if (modulos === 'ALL') return true;
    return modulos.some((m) => m.trim().toLowerCase() === modulo.trim().toLowerCase());
}

/** Puede VER el módulo Catálogos (super admin o usuarios con el módulo asignado). */
export function puedeVerCatalogos(email: string | null | undefined, modulos: Modulos): boolean {
    return getNormalizedEmail(email) === SUPER_ADMIN || tieneAccesoModulo(modulos, 'Catálogos');
}

/** Puede EDITAR (crear/actualizar/eliminar) en Catálogos: solo el super admin. */
export function puedeEditarCatalogos(email: string | null | undefined): boolean {
    return getNormalizedEmail(email) === SUPER_ADMIN;
}

/** Devuelve true si la ruta pathname está permitida para esos módulos */
export function isRutaPermitida(modulos: Modulos, pathname: string): boolean {
    if (modulos === 'ALL') return true;

    // Rutas públicas para todos los autenticados
    if (RUTAS_PUBLICAS_AUTENTICADO.some(r => rutaCubre(r, pathname))) {
        return true;
    }

    // Verificar si la ruta corresponde a alguno de los módulos permitidos
    return modulos.some(modulo => {
        const ruta = RUTA_POR_MODULO[modulo];
        return !!ruta && rutaCubre(ruta, pathname);
    });
}
