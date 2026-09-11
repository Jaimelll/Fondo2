// ─── Sectores agrupados de aportantes ────────────────────────────────────────
// FONDOEMPLEO agrupa a las empresas aportantes en 6 macro-sectores, más
// gruesos que las ~21 secciones CIIU que trae `sectores_ciiu`. Este módulo es
// la única fuente de verdad de esa equivalencia: lo usan el filtro de
// "Gestión de Aportantes" y el gráfico "Distribución por Sector" del
// Informe Gerencial.
//
// La clasificación se hace por el CÓDIGO CIIU (rev. 4), no por la descripción
// de la sección: el código es el dato confiable y la tabla ha tenido filas con
// la sección mal escrita (p. ej. 7020 "consultoría de gestión" guardado como
// "Industria manufacturera"). La descripción se usa solo como respaldo cuando
// la empresa no tiene código.
//
// Por eso el grupo es tan bueno como el CIIU de cada empresa. Los CIIU
// equivocados que se detectaron contrastando con SUNAT (Minsur y Boroo como
// generadoras eléctricas, Summa Gold como comercio, etc.) se corrigen en
// `scripts/corrige_ciiu_aportantes.sql`, que se reaplica tras cada carga desde
// Supabase.

export const SECTORES_AGRUPADOS = [
    'Minería y petróleo',
    'Energía',
    'Industria',
    'Comercial',
    'Infraestructura y transporte',
    'Otros',
] as const;

export type SectorAgrupado = (typeof SECTORES_AGRUPADOS)[number];

// Equivalencia por división CIIU (los 2 primeros dígitos del código).
function grupoPorDivision(division: number): SectorAgrupado | null {
    // Sección B — Explotación de minas y canteras (incluye petróleo y gas: 06)
    if (division >= 5 && division <= 9) return 'Minería y petróleo';
    // 19 — Fabricación de productos de la refinación del petróleo
    // (La Pampilla, Terpel): es cadena de hidrocarburos, no manufactura común.
    if (division === 19) return 'Minería y petróleo';
    // Sección D — Suministro de electricidad, gas, vapor y aire acondicionado
    if (division === 35) return 'Energía';
    // Sección C — Industrias manufactureras (19 ya quedó arriba)
    if (division >= 10 && division <= 33) return 'Industria';
    // Sección G — Comercio al por mayor y al por menor
    if (division >= 45 && division <= 47) return 'Comercial';
    // Sección F — Construcción (41 edificios, 42 obras de ingeniería civil,
    // 43 actividades especializadas): concesionarias y consorcios viales (IIRSA
    // Norte, Concesión Vial del Sur, Concay) y constructoras (Técnicas Reunidas
    // de Talara, CyM).
    if (division >= 41 && division <= 43) return 'Infraestructura y transporte';
    // Sección H — Transporte y almacenamiento. Incluye el transporte por
    // ductos (4930, TGP): se respeta el CIIU de SUNAT.
    if (division >= 49 && division <= 53) return 'Infraestructura y transporte';
    return null;
}

// Respaldo por descripción de sección, para filas sin código CIIU.
const RESPALDO_POR_DESCRIPCION: [RegExp, SectorAgrupado][] = [
    [/minas|canteras|petr[oó]leo|hidrocarburo/i, 'Minería y petróleo'],
    [/electricidad|gas, vapor/i, 'Energía'],
    [/industria/i, 'Industria'],
    [/comercio/i, 'Comercial'],
    [/transporte|almacenamiento|construcci[oó]n/i, 'Infraestructura y transporte'],
];

/**
 * Devuelve el macro-sector FONDOEMPLEO de una empresa a partir de su código
 * CIIU y —solo como respaldo— de la descripción de su sección. Nunca devuelve
 * vacío: lo no clasificable cae en "Otros".
 */
export function sectorAgrupado(
    ciiuCodigo?: string | number | null,
    seccionDesc?: string | null,
): SectorAgrupado {
    const codigo = String(ciiuCodigo ?? '').trim();
    if (/^\d{3,4}$/.test(codigo)) {
        // Los códigos de 3 dígitos vienen sin el cero inicial (p. ej. "729" = 0729).
        const division = Number(codigo.padStart(4, '0').slice(0, 2));
        const grupo = grupoPorDivision(division);
        if (grupo) return grupo;
        return 'Otros';
    }

    const desc = seccionDesc ?? '';
    const match = RESPALDO_POR_DESCRIPCION.find(([patron]) => patron.test(desc));
    return match ? match[1] : 'Otros';
}
