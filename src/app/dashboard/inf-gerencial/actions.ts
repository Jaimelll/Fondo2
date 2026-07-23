"use server";

import { query } from '@/lib/db';

export async function getAportantesData() {
    let rows: any[];
    try {
        // Equivale a empresas!inner + sectores_ciiu!inner: solo aportes cuya
        // empresa y sector existen (INNER JOIN).
        const result = await query(
            `select a.id, a.empresa_ruc, a.anio, a.monto,
                    e.razon_social, s.seccion_desc
               from aportes a
               join empresas e on e.ruc = a.empresa_ruc
               join sectores_ciiu s on s.id = e.ciiu_id`,
        );
        rows = result.rows;
    } catch (err) {
        console.error('Error fetching aportes:', err);
        return { data: [], annualTotals: {} };
    }

    const annualTotals: Record<number, number> = {};
    const mappedData = rows.map((row: any) => {
        const monto = Number(row.monto) || 0;
        const anio = Number(row.anio);
        annualTotals[anio] = (annualTotals[anio] || 0) + monto;

        return {
            id: row.id,
            ruc: row.empresa_ruc,
            anio,
            monto,
            razon_social: row.razon_social || 'Desconocido',
            seccion_desc: row.seccion_desc || 'Desconocido'
        };
    });

    return {
        data: mappedData,
        annualTotals
    };
}

export async function getSectoresDistintos() {
    try {
        const { rows } = await query('select distinct seccion_desc from sectores_ciiu where seccion_desc is not null order by seccion_desc');
        return rows.map((s: any) => s.seccion_desc) as string[];
    } catch {
        return [];
    }
}

export async function getUnidadesOperativas() {
    try {
        const { rows } = await query('select id, siglas, nombre_completo, orden from unidades_operativas order by orden asc');
        return rows as any[];
    } catch (err) {
        console.error('Error fetching unidades operativas:', err);
        return [];
    }
}

export async function getPresupuestoMensual() {
    let rows: any[];
    try {
        const result = await query(
            `select p.mes, p.presupuesto, p.ejecutado, u.siglas
               from presupuesto_mensual p
               left join unidades_operativas u on u.id = p.unidad_operativa_id`,
        );
        rows = result.rows;
    } catch (err) {
        console.error('Error fetching presupuesto mensual consolidado:', err);
        return [];
    }

    // Initialize 12 months
    const result = Array.from({ length: 12 }, (_, i) => ({
        mes: i + 1,
        presupuesto: 0,
        ejecutado: 0,
        presupuestoBreakdown: {},
        ejecutadoBreakdown: {}
    } as any));

    rows.forEach((row: any) => {
        const idx = (row.mes || 1) - 1;
        if (idx < 0 || idx > 11) return;

        const siglas = row.siglas || 'OTR';
        const presuMonto = Number(row.presupuesto) || 0;
        const ejecMonto = Number(row.ejecutado) || 0;

        result[idx].presupuesto += presuMonto;
        result[idx].ejecutado += ejecMonto;

        if (siglas) {
            result[idx].presupuestoBreakdown[siglas] = (result[idx].presupuestoBreakdown[siglas] || 0) + presuMonto;
            result[idx].ejecutadoBreakdown[siglas] = (result[idx].ejecutadoBreakdown[siglas] || 0) + ejecMonto;
        }
    });

    return result;
}


// Fases de "proyectos"/"grupo" que cuentan como financiamiento en curso
// (excluye Resuelto/Pre-Impacto/Impacto/Cierre Administrativo, que son
// grupos ya cerrados históricamente y no aportan a "en ejecución").
const FASES_EN_EJECUCION = ['Etapa Concursal', 'Acciones Preparatorias', 'En Ejecución'];

function grupoBaseProyecto(descripcion: string): string {
    const base = descripcion.replace(/ - Eje.*/i, '').replace(/^Actíva-T/, 'Activa-T').trim();
    // Unir "Sectorial 2026" + "Propuestas Sectorial" en una sola barra "Eje Sectorial 2026"
    // (conserva el "2026" para mantener el asterisco de "en curso" y el orden por año).
    if (/^(Sectorial 2026|Propuestas Sectorial)$/i.test(base)) return 'Eje Sectorial 2026';
    return base;
}

function grupoBaseBeca(descripcion: string): string {
    return descripcion
        .replace(/^\d+\s*-\s*/, '')
        .replace(/\s*-\s*(Hijos de trabajadores|Trabajadores)$/i, '')
        .replace(/\s+(I{1,2})$/, '')
        .replace(/^Beca\s+/i, '')
        .trim();
}

// Beca Trabajadores (grupos 1, 2 y 3 - variantes 2024/2025/2026) se junta
// en una sola barra 2024; MiBeca (grupo 6, con becas de varios períodos)
// se junta en una sola barra 2021. Mismo criterio que ServiciosTimeline.
function labelBeca(grupoId: number, descripcion: string): string {
    if ([1, 2, 3].includes(grupoId)) return 'Beca Trabajadores 2024';
    if (grupoId === 6) return 'MiBeca 2021';
    return grupoBaseBeca(descripcion);
}

function sortYearFromLabel(label: string): number {
    const match = label.match(/\d{4}/);
    return match ? Number(match[0]) : 9999; // sin año detectable: al final
}

export async function getFinanciamientoEjecucion() {
    let proyectosRaw: any[] = [];
    let becasRaw: any[] = [];
    try {
        const [pResult, bResult] = await Promise.all([
            query(
                `select p.monto_fondoempleo, g.descripcion as grupo_descripcion, e.fase,
                        i.nombre as institucion_nombre
                   from proyectos p
                   left join grupo g on g.id = p.grupo_id
                   left join etapas e on e.id = p.etapa_id
                   left join instituciones_ejecutoras i on i.id = p.institucion_ejecutora_id
                  where p.grupo_id is not null`,
            ),
            query(
                `select b.presupuesto, b.grupo_id, g.descripcion as grupo_descripcion
                   from becas_nueva b
                   left join grupo g on g.id = b.grupo_id
                  where b.grupo_id is not null`,
            ),
        ]);
        proyectosRaw = pResult.rows;
        becasRaw = bResult.rows;
    } catch (err) {
        console.error('Error fetching financiamiento en ejecución:', err);
    }

    const proyectosMap = new Map<string, { monto: number; count: number; breakdown: Record<string, number> }>();
    proyectosRaw.forEach((row: any) => {
        const fase = row.fase;
        const descripcion = row.grupo_descripcion;
        if (!descripcion || !FASES_EN_EJECUCION.includes(fase)) return;

        const label = grupoBaseProyecto(descripcion);
        const monto = Number(row.monto_fondoempleo) || 0;
        const entry = proyectosMap.get(label) || { monto: 0, count: 0, breakdown: {} };
        entry.monto += monto;
        entry.count += 1;
        const sigla = row.institucion_nombre || 'S/D';
        entry.breakdown[sigla] = (entry.breakdown[sigla] || 0) + monto;
        proyectosMap.set(label, entry);
    });

    const becasMap = new Map<string, { monto: number; count: number }>();
    becasRaw.forEach((row: any) => {
        const descripcion = row.grupo_descripcion;
        if (!descripcion) return;

        const label = labelBeca(row.grupo_id, descripcion);
        const entry = becasMap.get(label) || { monto: 0, count: 0 };
        entry.monto += Number(row.presupuesto) || 0;
        entry.count += 1;
        becasMap.set(label, entry);
    });

    const toSortedArray = (map: Map<string, { monto: number; count: number; breakdown?: Record<string, number> }>) =>
        Array.from(map.entries())
            .map(([label, v]) => ({ label, monto: v.monto, count: v.count, proyectado: /2026/.test(label), breakdown: v.breakdown }))
            .sort((a, b) => sortYearFromLabel(a.label) - sortYearFromLabel(b.label));

    return {
        proyectos: toSortedArray(proyectosMap),
        becas: toSortedArray(becasMap),
    };
}

// --- SECCIÓN IV: ANÁLISIS - DIAGNÓSTICO (Sustento Retorno Monitoreo Financiero) ---
// Serie histórica de gasto de proyectos/servicios (EEFF) vs. cantidad de
// colaboradores, 1999-2025 + 2026 proyectado. Datos cargados vía SQL en la
// tabla `auditoria_eeff_historico` (ver scripts/create_auditoria_eeff.sql).
export async function getAuditoriaEeff() {
    try {
        const { rows } = await query(
            `select anio, gasto_proyectos_servicios, colaboradores, categoria, proyectado
               from auditoria_eeff_historico
              order by anio asc`,
        );
        return rows.map((r: any) => ({
            anio: Number(r.anio),
            gasto: Number(r.gasto_proyectos_servicios) || 0,
            colaboradores: Number(r.colaboradores) || 0,
            categoria: r.categoria || '',
            proyectado: !!r.proyectado,
        }));
    } catch (err: any) {
        // La tabla puede no existir aún (ver scripts/migration_impacto_saldos_auditoria.sql):
        // degradar sin romper la página.
        console.error('Error fetching auditoria_eeff_historico:', err.message);
        return [];
    }
}

export async function getPresupuestoComparativo() {
    let rows: any[];
    try {
        const result = await query(
            `select p."año", p.poi, p.ejecutado, u.siglas
               from presupuesto_anual_comparativo p
               left join unidades_operativas u on u.id = p.unidad_operativa_id`,
        );
        rows = result.rows;
    } catch (err) {
        console.error('Error fetching presupuesto comparativo consolidado:', err);
        return [];
    }

    const consolidated = rows.reduce((acc: any, curr: any) => {
        const year = curr.año;
        if (!acc[year]) acc[year] = {
            año: year,
            poi: 0,
            ejecutado: 0,
            poiBreakdown: {},
            ejecutadoBreakdown: {}
        };

        const siglas = curr.siglas || 'OTR';
        const poiMonto = Number(curr.poi) || 0;
        const ejecMonto = Number(curr.ejecutado) || 0;

        acc[year].poi += poiMonto;
        acc[year].ejecutado += ejecMonto;

        if (siglas) {
            acc[year].poiBreakdown[siglas] = (acc[year].poiBreakdown[siglas] || 0) + poiMonto;
            acc[year].ejecutadoBreakdown[siglas] = (acc[year].ejecutadoBreakdown[siglas] || 0) + ejecMonto;
        }

        return acc;
    }, {});

    return Object.values(consolidated).sort((a: any, b: any) => (a as any).año - (b as any).año);
}
