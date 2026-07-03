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
