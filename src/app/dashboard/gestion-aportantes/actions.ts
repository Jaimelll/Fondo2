"use server";

import { unstable_noStore as noStore, revalidatePath } from 'next/cache';
import { query } from '@/lib/db';

// ─────────────────────────────────────────────────────────────────────────────
// Capa de datos: Postgres directo. Los embeds de PostgREST (sectores_ciiu
// to-one, aportes to-many con !inner opcional) se replican con LEFT JOIN +
// json_agg lateral, devolviendo las mismas formas anidadas.
// ─────────────────────────────────────────────────────────────────────────────

export async function getAniosAportes() {
    return [2026, 2025, 2024, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015];
}

export async function getEmpresasData(anioFiltro: string | number = 'Todos') {
    noStore();

    let rows: any[];
    try {
        if (anioFiltro && anioFiltro !== 'Todos') {
            // Equivale a aportes!inner(...) + eq('aportes.anio', N): solo empresas
            // con aportes en ese año, y la lista de aportes filtrada a ese año.
            const result = await query(
                `select e.ruc, e.razon_social, e.ciiu_id,
                        case when s.id is not null then json_build_object('id', s.id, 'seccion_desc', s.seccion_desc, 'ciiu_codigo', s.ciiu_codigo) end as sectores_ciiu,
                        ap.aportes
                   from empresas e
                   left join sectores_ciiu s on s.id = e.ciiu_id
                   join lateral (
                     select json_agg(json_build_object('id', a.id, 'anio', a.anio, 'monto', a.monto)) as aportes
                       from aportes a
                      where a.empresa_ruc = e.ruc and a.anio = $1::int
                   ) ap on ap.aportes is not null`,
                [Number(anioFiltro)],
            );
            rows = result.rows;
        } else {
            const result = await query(
                `select e.ruc, e.razon_social, e.ciiu_id,
                        case when s.id is not null then json_build_object('id', s.id, 'seccion_desc', s.seccion_desc, 'ciiu_codigo', s.ciiu_codigo) end as sectores_ciiu,
                        coalesce(ap.aportes, '[]'::json) as aportes
                   from empresas e
                   left join sectores_ciiu s on s.id = e.ciiu_id
                   left join lateral (
                     select json_agg(json_build_object('id', a.id, 'anio', a.anio, 'monto', a.monto)) as aportes
                       from aportes a
                      where a.empresa_ruc = e.ruc
                   ) ap on true`,
            );
            rows = result.rows;
        }
    } catch (err) {
        console.error('Error fetching empresas:', err);
        return [];
    }

    return rows.map((e: any) => ({
        ruc: e.ruc,
        razon_social: e.razon_social,
        ciiu_id: e.ciiu_id,
        sector: e.sectores_ciiu?.seccion_desc || 'Desconocido',
        total_aportes: e.aportes?.reduce((sum: number, a: any) => sum + Number(a.monto), 0) || 0,
        aportes_count: e.aportes?.length || 0,
        aportes: (e.aportes || []).sort((a: any, b: any) => b.anio - a.anio)
    }));
}

export async function getAllSectores() {
    try {
        const { rows } = await query('select id, ciiu_codigo, seccion_desc from sectores_ciiu order by seccion_desc');
        return rows;
    } catch {
        return [];
    }
}

export async function createEmpresa(payload: { ruc: string; razon_social: string; ciiu_id: number }) {
    try {
        await query(
            'insert into empresas (ruc, razon_social, ciiu_id) values ($1, $2, $3)',
            [payload.ruc, payload.razon_social, payload.ciiu_id],
        );
    } catch (err: any) {
        throw new Error(err.message);
    }
    revalidatePath('/dashboard/gestion-aportantes');
}

export async function updateEmpresa(ruc: string, payload: { razon_social: string; ciiu_id: number }) {
    try {
        await query(
            'update empresas set razon_social = $1, ciiu_id = $2 where ruc = $3',
            [payload.razon_social, payload.ciiu_id, ruc],
        );
    } catch (err: any) {
        throw new Error(err.message);
    }
    revalidatePath('/dashboard/gestion-aportantes');
}

export async function createAporte(payload: { empresa_ruc: string; anio: number; monto: number }) {
    try {
        await query(
            'insert into aportes (empresa_ruc, anio, monto) values ($1, $2, $3)',
            [payload.empresa_ruc, payload.anio, payload.monto],
        );
    } catch (err: any) {
        throw new Error(err.message);
    }
    revalidatePath('/dashboard/gestion-aportantes');
}

export async function updateAporte(id: string, payload: { anio: number; monto: number }) {
    try {
        await query('update aportes set anio = $1, monto = $2 where id = $3', [payload.anio, payload.monto, id]);
    } catch (err: any) {
        throw new Error(err.message);
    }
    revalidatePath('/dashboard/gestion-aportantes');
}

export async function deleteAporte(id: string) {
    try {
        await query('delete from aportes where id = $1', [id]);
    } catch (err: any) {
        throw new Error(err.message);
    }
    revalidatePath('/dashboard/gestion-aportantes');
}

// ─── FINANZAS ANUAL ──────────────────────────────────────────────────────────

export async function getFinancialSummary() {
    noStore();
    const rubros = ['Intereses', 'G. Operativos', 'Proyectos', 'Becas', 'Saldos en Bancos'];

    let rows: any[];
    try {
        const result = await query(
            `select id, rubro, monto from finanzas_anual
              where "año" = 2026 and escenario = 'Real' and rubro = any($1)`,
            [rubros],
        );
        rows = result.rows;
    } catch (err) {
        console.error('[SERVER] Error al obtener resumen financiero:', err);
        return {};
    }

    console.log('[SERVER] Datos financieros cargados:', JSON.stringify(rows));

    return rows.reduce((acc: any, curr: any) => {
        acc[curr.rubro.trim()] = {
            id: curr.id,
            monto: curr.monto
        };
        return acc;
    }, {});
}

export async function updateFinancialSummary(updates: { id: number; monto: number; rubro?: string }[]) {
    console.log('[SERVER] updateFinancialSummary — Payload recibido:', JSON.stringify(updates));

    for (const update of updates) {
        const idLimpio = Number(update.id);
        const montoLimpio = parseFloat(String(update.monto));

        if (isNaN(montoLimpio) || isNaN(idLimpio)) {
            throw new Error(`Valor inválido: id=${update.id}, monto=${update.monto}`);
        }

        console.log(`[SERVER] Actualizando → id=${idLimpio} | rubro=${update.rubro} | monto=${montoLimpio}`);

        let filasAfectadas = 0;
        try {
            const result = await query(
                'update finanzas_anual set monto = $1 where id = $2 returning id',
                [montoLimpio, idLimpio],
            );
            filasAfectadas = result.rowCount ?? 0;
        } catch (err: any) {
            console.error(`[SERVER] Error Postgres en id=${idLimpio}:`, err);
            throw new Error(`Error en rubro "${update.rubro}" (id ${idLimpio}): ${err.message}`);
        }

        console.log(`[SERVER] id=${idLimpio} → filas_afectadas=${filasAfectadas}`);

        if (filasAfectadas === 0) {
            throw new Error(
                `Fallo al guardar "${update.rubro}": 0 filas afectadas. ID inexistente.`
            );
        }
    }

    revalidatePath('/dashboard/gestion-aportantes');
    console.log('[SERVER] Todas las actualizaciones completadas y caché revalidada.');
}
