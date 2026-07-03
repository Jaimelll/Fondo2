"use server";

// ─────────────────────────────────────────────────────────────────────────────
// Server actions del módulo Servicios. La página es un client component; antes
// consultaba Supabase directo desde el navegador — ahora pide todo aquí en una
// sola llamada (catálogos + becas con sus relaciones embebidas).
// ─────────────────────────────────────────────────────────────────────────────

import { query } from "@/lib/db";

export async function getServiciosPageData() {
  try {
    const [
      etapas, ejes, lineas, condiciones, modalidades, instituciones,
      grupos, tiposEstudio, naturalezasIE, formatos, empresas, servicios,
    ] = await Promise.all([
      query('select id, descripcion, fase from etapas order by id'),
      query('select id, descripcion from ejes order by id'),
      query('select id, descripcion from lineas order by id'),
      query('select id, descripcion from condicion order by id'),
      query('select id, descripcion from modalidades order by id'),
      query('select id, descripcion from institucion order by id'),
      query('select id, descripcion, orden from grupo where tipo = 1 order by orden'),
      query('select id, descripcion from tipo_estudio order by id'),
      query('select id, descripcion from naturaleza_ie order by id'),
      query('select id, descripcion from formato order by id'),
      query('select ruc, razon_social from empresas order by razon_social'),
      query(`
        select
          b.*,
          case when r.id  is not null then json_build_object('id', r.id, 'descripcion', r.descripcion) end as region,
          case when i.id  is not null then json_build_object('descripcion', i.descripcion) end as institucion,
          case when ej.id is not null then json_build_object('descripcion', ej.descripcion) end as eje,
          case when li.id is not null then json_build_object('descripcion', li.descripcion) end as linea,
          case when et.id is not null then json_build_object('descripcion', et.descripcion) end as etapa,
          case when c.id  is not null then json_build_object('descripcion', c.descripcion) end as condicion,
          case when g.id  is not null then json_build_object('descripcion', g.descripcion, 'orden', g.orden) end as grupo,
          coalesce(av.avances, '[]'::json) as avances
        from becas_nueva b
        left join regiones r    on r.id  = b.region_id
        left join institucion i on i.id  = b.institucion_id
        left join ejes ej       on ej.id = b.eje_id
        left join lineas li     on li.id = b.linea_id
        left join etapas et     on et.id = b.etapa_id
        left join condicion c   on c.id  = b.condicion_id
        left join grupo g       on g.id  = b.grupo_id
        left join lateral (
          select json_agg(json_build_object(
            'id', a.id, 'fecha', a.fecha::text, 'etapa_id', a.etapa_id,
            'sustento', a.sustento, 'monto', a.monto
          ) order by a.id) as avances
          from avance_beca a
          where a.beca_id = b.id
        ) av on true
        order by b.id asc
      `),
    ]);

    return {
      etapas: etapas.rows,
      ejes: ejes.rows,
      lineas: lineas.rows,
      condiciones: condiciones.rows,
      modalidades: modalidades.rows,
      instituciones: instituciones.rows,
      grupos: grupos.rows,
      tiposEstudio: tiposEstudio.rows,
      naturalezasIE: naturalezasIE.rows,
      formatos: formatos.rows,
      empresas: empresas.rows,
      servicios: servicios.rows,
    };
  } catch (err) {
    console.error("FATAL ERROR getServiciosPageData:", err);
    return {
      etapas: [], ejes: [], lineas: [], condiciones: [], modalidades: [],
      instituciones: [], grupos: [], tiposEstudio: [], naturalezasIE: [],
      formatos: [], empresas: [], servicios: [],
    };
  }
}
