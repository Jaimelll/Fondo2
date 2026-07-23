"use server";

import { revalidatePath } from "next/cache";
import { query } from "@/lib/db";

// ─────────────────────────────────────────────────────────────────────────────
// Capa de datos: Postgres directo. Los embeds de PostgREST (eje:eje_id(...),
// avances:avance_beca(...)) se replican con LEFT JOIN + json_build_object /
// json_agg, devolviendo exactamente las mismas formas anidadas.
// ─────────────────────────────────────────────────────────────────────────────

const BECA_BASE_SELECT = `
  select
    b.id, b.nombre, b.documento, b.eje_id, b.linea_id, b.etapa_id, b.modalidad_id,
    b.institucion_id, b.condicion_id, b.grupo_id, b.presupuesto, b.avance, b.beneficiarios,
    b.provincia_procedencia, b.distrito_procedencia, b.celular, b.correo_electronico,
    b.tipo_estudio_id, b.naturaleza_ie_id, b.especialidad, b.formato_id,
    b.fecha_nacimiento::text as fecha_nacimiento, b.sexo, b.empresa_id,
    case when ej.id is not null then json_build_object('descripcion', ej.descripcion) end as eje,
    case when li.id is not null then json_build_object('descripcion', li.descripcion) end as linea,
    case when et.id is not null then json_build_object('descripcion', et.descripcion) end as etapa,
    case when mo.id is not null then json_build_object('descripcion', mo.descripcion) end as modalidad,
    case when i.id  is not null then json_build_object('descripcion', i.descripcion) end as institucion,
    case when c.id  is not null then json_build_object('descripcion', c.descripcion) end as condicion,
    case when g.id  is not null then json_build_object('descripcion', g.descripcion) end as grupo,
    coalesce(av.avances, '[]'::json) as avances
  from becas_nueva b
  left join ejes ej       on ej.id = b.eje_id
  left join lineas li     on li.id = b.linea_id
  left join etapas et     on et.id = b.etapa_id
  left join modalidades mo on mo.id = b.modalidad_id
  left join institucion i on i.id  = b.institucion_id
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
`;

export async function getServiciosGestionData(filters?: { eje?: string; linea?: string; etapa?: string; modalidad?: string; condicion?: string; searchTerm?: string; institucion_id?: string; tipo_estudio_id?: string; grupo_id?: string; id_exacto?: string }) {
  const conditions: string[] = [];
  const params: unknown[] = [];
  const add = (sqlFragment: string, value: unknown) => {
    params.push(value);
    conditions.push(sqlFragment.replace('?', `$${params.length}`));
  };

  if (filters?.searchTerm) add('b.nombre ilike ?', `%${filters.searchTerm}%`);
  if (filters?.eje && filters.eje !== 'all') add('b.eje_id = ?::int', Number(filters.eje));
  if (filters?.linea && filters.linea !== 'all') add('b.linea_id = ?::int', Number(filters.linea));
  if (filters?.etapa && filters.etapa !== 'all') add('b.etapa_id = ?::int', Number(filters.etapa));
  if (filters?.modalidad && filters.modalidad !== 'all') add('b.modalidad_id = ?::int', Number(filters.modalidad));
  if (filters?.condicion && filters.condicion !== 'all') add('b.condicion_id = ?::int', Number(filters.condicion));
  if (filters?.institucion_id && filters.institucion_id !== 'all') add('b.institucion_id = ?::int', Number(filters.institucion_id));
  if (filters?.tipo_estudio_id && filters.tipo_estudio_id !== 'all') add('b.tipo_estudio_id = ?::int', Number(filters.tipo_estudio_id));
  if (filters?.grupo_id && filters.grupo_id !== 'all') add('b.grupo_id = ?::int', Number(filters.grupo_id));
  if (filters?.id_exacto) add('b.id = ?::int', Number(filters.id_exacto));

  const where = conditions.length ? `where ${conditions.join(' and ')}` : '';

  try {
    const { rows } = await query(`${BECA_BASE_SELECT} ${where} order by b.id asc`, params);
    return rows;
  } catch (err: any) {
    console.error("Error fetching servicios gestion data:", err.message);
    return [];
  }
}

function cleanBecaPayload(formData: any) {
  const allowedKeys = [
    'nombre',
    'documento',
    'periodo',
    'modalidad_id',
    'institucion_id',
    'eje_id',
    'linea_id',
    'etapa_id',
    'condicion_id',
    'grupo_id',
    'presupuesto',
    'avance',
    'beneficiarios',
    'provincia_procedencia',
    'distrito_procedencia',
    'celular',
    'correo_electronico',
    'tipo_estudio_id',
    'naturaleza_ie_id',
    'especialidad',
    'formato_id',
    'fecha_nacimiento',
    'sexo',
    'empresa_id'
  ];

  const cleaned: any = {};
  for (const key of allowedKeys) {
    if (key in formData) {
      const val = formData[key];
      cleaned[key] = (typeof val === 'string' && val.trim() === '') ? null : val;
    }
  }
  return cleaned;
}

export async function createServicio(formData: any) {
  try {
    const payloadLimpio = cleanBecaPayload(formData);

    console.log("Payload limpio a enviar:", payloadLimpio);

    const cols = Object.keys(payloadLimpio);
    const values = cols.map((c) => payloadLimpio[c]);
    const placeholders = cols.map((_, i) => `$${i + 1}`);

    const { rows } = await query(
      `insert into becas_nueva (${cols.map((c) => `"${c}"`).join(', ')}) values (${placeholders.join(', ')}) returning *`,
      values,
    );

    revalidatePath('/dashboard/gestion-servicios');
    return { success: true, data: rows };
  } catch (err: any) {
    console.error("Uncaught error in createServicio:", err);
    return { success: false, error: err.message };
  }
}

export async function updateServicio(id: any, formData: any) {
  try {
    const payloadLimpio = cleanBecaPayload(formData);

    console.log("Payload limpio a enviar:", payloadLimpio);

    const cols = Object.keys(payloadLimpio);
    const values = cols.map((c) => payloadLimpio[c]);
    const assignments = cols.map((c, i) => `"${c}" = $${i + 1}`);

    const { rows } = await query(
      `update becas_nueva set ${assignments.join(', ')} where id = $${cols.length + 1}::int returning *`,
      [...values, id],
    );

    revalidatePath('/dashboard/gestion-servicios');
    return { success: true, data: rows };
  } catch (err: any) {
    console.error("Uncaught error in updateServicio:", err);
    return { success: false, error: err.message };
  }
}

export async function deleteServicio(id: any) {
  try {
    await query('delete from becas_nueva where id = $1::int', [id]);
  } catch (err: any) {
    console.error("Error deleting servicio:", err);
    throw new Error(err.message);
  }

  revalidatePath('/dashboard/gestion-servicios');
  return { success: true };
}

async function recalculateBecaAvance(becaId: any) {
  // Los avances se guardan con new Date().toISOString() (UTC) desde el modal, así que el
  // filtro "hasta hoy" debe usar la MISMA referencia UTC. Antes se calculaba en hora Perú
  // (UTC-5), lo que de noche dejaba "hoy" un día atrás y excluía el avance recién creado.
  const today = new Date().toISOString().split('T')[0];

  console.log(`[DEBUG] Recalculating stage for Beca ${becaId} as of ${today}`);

  // 1. Obtener el historial de avances reales (fecha <= hoy, sin proyecciones)
  const { rows: allAvances } = await query(
    `select etapa_id, sustento, fecha::text as fecha, monto
       from avance_beca
      where beca_id = $1::int and fecha <= $2::date
      order by fecha desc, id desc`,
    [becaId, today],
  );

  if (allAvances && allAvances.length > 0) {
    // 2. El avance más reciente (índice 0) define la etapa actual
    const latestAvance: any = allAvances[0];
    const newEtapaId = latestAvance.etapa_id;

    // 3. Calculamos el avance financiero total (solo de avances reales <= hoy)
    const totalAvanceFinanciero = allAvances.reduce((sum: number, item: any) => sum + (Number(item.monto) || 0), 0);

    console.log(`[DEBUG] Updating Beca ${becaId} to Stage ${newEtapaId} | avance=${totalAvanceFinanciero}`);

    // OJO: becas_nueva NO tiene columna 'sustento' (a diferencia de proyectos). El sustento
    // ya queda guardado por avance en avance_beca.
    await query(
      'update becas_nueva set etapa_id = $1, avance = $2 where id = $3::int',
      [newEtapaId, totalAvanceFinanciero, becaId],
    );
  } else {
    console.log(`[DEBUG] No valid advance found for Beca ${becaId}. Stage remains unchanged.`);
  }
}

export async function addAvanceServicio(becaId: any, avanceData: any) {
  let data: any;
  try {
    const { rows } = await query(
      `insert into avance_beca (beca_id, etapa_id, fecha, sustento, monto)
       values ($1::int, $2, $3, $4, $5) returning *`,
      [becaId, avanceData.etapa_id, avanceData.fecha, avanceData.sustento, Number(avanceData.monto) || 0],
    );
    data = rows[0];
  } catch (err: any) {
    console.error("Error inserting avance:", err);
    throw new Error(err.message);
  }

  // El avance económico de becas_nueva se recalcula como la suma de todos los montos del historial.
  await recalculateBecaAvance(becaId);

  revalidatePath('/dashboard/gestion-servicios');
  return data;
}

export async function updateAvanceServicio(id: any, avanceData: any) {
  let data: any;
  try {
    const { rows } = await query(
      `update avance_beca set etapa_id = $1, fecha = $2, sustento = $3, monto = $4
       where id = $5 returning *`,
      [avanceData.etapa_id, avanceData.fecha, avanceData.sustento, Number(avanceData.monto) || 0, id],
    );
    data = rows[0];
  } catch (err: any) {
    console.error("Error updating avance:", err);
    throw new Error(err.message);
  }

  if (data?.beca_id) {
    // El avance económico se recalcula sumando todo el historial (evita el doble conteo del enfoque incremental anterior).
    await recalculateBecaAvance(data.beca_id);
  }

  revalidatePath('/dashboard/gestion-servicios');
  return data;
}

export async function deleteAvanceServicio(id: any, becaId: any) {
  try {
    await query('delete from avance_beca where id = $1', [id]);
  } catch (err: any) {
    console.error("Error deleting avance:", err);
    throw new Error(err.message);
  }

  await recalculateBecaAvance(becaId);

  revalidatePath('/dashboard/gestion-servicios');
  return { success: true };
}

// Nota: estos catálogos se leen COMPLETOS (sin join con becas_nueva). Antes
// usaban `becas_nueva!inner`, que solo listaba valores ya asignados a alguna
// beca — un elemento recién creado en Catálogos nunca aparecía en el modal.

export async function getCondiciones() {
  try {
    const { rows } = await query('select id, descripcion from condicion order by id asc');
    return rows.map((item: any) => ({ value: item.id, label: item.descripcion }));
  } catch {
    return [];
  }
}

export async function getInstitucionesBeca() {
  try {
    const { rows } = await query('select id, descripcion from institucion order by descripcion asc');
    return rows.map((item: any) => ({ value: item.id, label: item.descripcion }));
  } catch {
    return [];
  }
}

export async function getGrupos() {
  try {
    const { rows } = await query('select id, descripcion, orden from grupo where tipo = 1 order by orden asc');
    return rows.map((item: any) => ({
      value: item.id,
      label: `${item.orden} - ${item.descripcion}`
    }));
  } catch (err) {
    console.error("Error fetching grupos:", err);
    return [];
  }
}

export async function getServicioCompletoById(id: number) {
  try {
    const { rows } = await query(`${BECA_BASE_SELECT} where b.id = $1::int`, [id]);
    if (!rows[0]) {
      console.error(`Error fetching servicio ${id}: not found`);
      return null;
    }
    return rows[0];
  } catch (err) {
    console.error(`Error fetching servicio ${id}:`, err);
    return null;
  }
}

export async function getTiposEstudio() {
  try {
    const { rows } = await query('select id, descripcion from tipo_estudio order by id asc');
    return rows.map((item: any) => ({ value: item.id, label: item.descripcion }));
  } catch {
    return [];
  }
}

export async function getNaturalezasIE() {
  try {
    const { rows } = await query('select id, descripcion from naturaleza_ie order by id asc');
    return rows.map((item: any) => ({ value: item.id, label: item.descripcion }));
  } catch {
    return [];
  }
}

export async function getFormatos() {
  try {
    const { rows } = await query('select id, descripcion from formato order by id asc');
    return rows.map((item: any) => ({ value: item.id, label: item.descripcion }));
  } catch {
    return [];
  }
}

export async function getEmpresas() {
  try {
    const { rows } = await query('select ruc, razon_social from empresas order by razon_social asc');
    return rows.map((item: any) => ({ value: item.ruc, label: `${item.ruc} - ${item.razon_social}` }));
  } catch {
    return [];
  }
}
