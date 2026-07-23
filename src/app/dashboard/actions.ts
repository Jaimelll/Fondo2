"use server";

import { revalidatePath, revalidateTag, unstable_cache } from "next/cache";
import { query, withAuditUser } from "@/lib/db";
import { getSession } from "@/lib/session";

// ──────────────────────────────────────────────────────────────────────────────
// Helpers de caché para catálogos (líneas, ejes, etc.) — datos que rara vez
// cambian. Revalidación: 1 hora + invalidación por tag.
// Si modificas un catálogo desde un server action, llama:
//     revalidateTag('catalogos');
// y la próxima lectura traerá datos frescos.
// ──────────────────────────────────────────────────────────────────────────────
const CATALOG_REVALIDATE_SECONDS = 3600; // 1 hora
const CATALOG_TAG = "catalogos";

// ──────────────────────────────────────────────────────────────────────────────
// Capa de datos: Postgres directo (src/lib/db.ts). El SELECT base replica los
// "embedded selects" que antes resolvía PostgREST: lookups por LEFT JOIN y el
// historial de avances como json_agg lateral (mismas formas anidadas).
// ──────────────────────────────────────────────────────────────────────────────

const PROYECTO_BASE_SELECT = `
  select
    p.*,
    l.descripcion  as linea_descripcion,
    ej.descripcion as eje_descripcion,
    r.descripcion  as region_descripcion,
    ie.nombre      as institucion_nombre,
    mo.descripcion as modalidad_descripcion,
    et.descripcion as etapa_descripcion,
    et.fase        as etapa_fase,
    esp.nombre     as especialista_nombre,
    g.descripcion  as grupo_descripcion,
    g.orden        as grupo_orden,
    coalesce(av.avances, '[]'::json) as avances
  from proyectos p
  left join lineas l   on l.id  = p.linea_id
  left join ejes ej    on ej.id = p.eje_id
  left join regiones r on r.id  = p.region_id
  left join instituciones_ejecutoras ie on ie.id = p.institucion_ejecutora_id
  left join modalidades mo on mo.id = p.modalidad_id
  left join etapas et  on et.id = p.etapa_id
  left join especialistas esp on esp.id = p.especialista_id
  left join grupo g    on g.id  = p.grupo_id
  left join lateral (
    select json_agg(json_build_object(
      'id', a.id,
      'fecha', a.fecha::text,
      'etapa_id', a.etapa_id,
      'sustento', a.sustento,
      'monto', a.monto,
      'etapa', json_build_object('descripcion', ae.descripcion)
    ) order by a.id) as avances
    from avance_proyecto a
    left join etapas ae on ae.id = a.etapa_id
    where a.proyecto_id = p.id
  ) av on true
`;

/** Filtro genérico: ignora 'all', 'todos', '', 'undefined', '0'. */
function esFiltroActivo(value?: string | number | null): boolean {
  if (value === undefined || value === null) return false;
  const valString = String(value).trim();
  const valLower = valString.toLowerCase();
  if (valLower === 'all' || valLower === 'undefined' || valLower === '' || valLower.startsWith('tod') || valString === '0') {
    return false;
  }
  return true;
}

function mapProyectoRow(p: any) {
  let year = p.año ? String(p.año) : 'Unknown';
  if (year === 'Unknown' && p.fecha_inicio) {
    year = new Date(p.fecha_inicio).getFullYear().toString();
  } else if (year === 'Unknown' && p.created_at) {
    year = new Date(p.created_at).getFullYear().toString();
  }

  const avances = p.avances || [];

  return {
    id: p.id,
    nombre: p.nombre || 'Sin Nombre',
    codigo: p.codigo_proyecto,
    codigo_proyecto: p.codigo_proyecto,
    region: p.region_descripcion || p.region || 'Desconocido',
    linea: p.linea_descripcion || 'Sin Linea',
    lineaId: p.linea_id,
    eje: p.eje_descripcion || 'Sin Eje',
    ejeId: p.eje_id,
    etapa: p.etapa_descripcion || 'Sin Etapa',
    etapaId: p.etapa_id,
    institucion: p.institucion_nombre || 'Sin Institucion',
    institucionId: p.institucion_ejecutora_id,
    gestora: p.gestora || '',
    regionId: p.region_id,
    modalidad: p.modalidad_descripcion || 'Desconocido',
    modalidadId: p.modalidad_id,
    estado: p.etapa_descripcion || 'Activo',
    sustento: p.sustento || '',
    year: year,
    año: Number(p.año) || 0,
    fase: p.etapa_fase || '',
    monto_fondoempleo: Number(p.monto_fondoempleo) || 0,
    avance: Number(p.avance) || 0,
    contrapartida: Number(p.contrapartida) || 0,
    monto_total: (Number(p.monto_fondoempleo) || 0) + (Number(p.contrapartida) || 0),
    beneficiarios: Number(p.beneficiarios) || 0,
    avance_tecnico: Number(p.avance_tecnico) || 0,
    fecha_inicio: avances.find((a: any) => a.etapa_id === 1)?.fecha || null,
    fecha_fin: avances.find((a: any) => a.etapa_id === 6)?.fecha || null,
    avances: avances,
    grupo_id: p.grupo_id,
    nombre_grupo: p.grupo_descripcion || '',
    provincia: p.provincia || '',
    especialista_id: p.especialista_id,
    especialista: p.especialista_nombre || '',
    contacto: p.contacto || ''
  };
}

type ProyectoFilters = {
  periodo?: string; eje?: string; linea?: string; etapa?: string;
  modalidad?: string; especialistaId?: string; grupo_id?: string; id_exacto?: string;
};

function buildProyectoConditions(filters?: ProyectoFilters) {
  const conditions: string[] = [];
  const params: unknown[] = [];
  const add = (sqlFragment: string, value: unknown) => {
    params.push(value);
    conditions.push(sqlFragment.replace('?', `$${params.length}`));
  };

  if (filters?.periodo && filters.periodo !== 'all' && filters.periodo !== 'undefined') {
    const yearVal = Number(filters.periodo);
    if (!isNaN(yearVal)) add('p."año" = ?::int', yearVal);
  }
  if (esFiltroActivo(filters?.eje)) add('p.eje_id = ?::int', Number(filters!.eje));
  if (esFiltroActivo(filters?.linea)) add('p.linea_id = ?::int', Number(filters!.linea));
  if (esFiltroActivo(filters?.modalidad)) add('p.modalidad_id = ?::int', Number(filters!.modalidad));
  if (esFiltroActivo(filters?.especialistaId)) add('p.especialista_id = ?::int', Number(filters!.especialistaId));
  if (esFiltroActivo(filters?.etapa)) add('p.etapa_id = ?::int', Number(filters!.etapa));
  if (filters?.grupo_id && filters.grupo_id !== 'all' && filters.grupo_id !== '' && filters.grupo_id !== 'undefined') {
    add('p.grupo_id = ?::int', Number(filters.grupo_id));
  }
  if (filters?.id_exacto && filters.id_exacto !== '' && filters.id_exacto !== 'undefined') {
    add('p.id = ?::int', Number(filters.id_exacto));
  }

  const where = conditions.length ? `where ${conditions.join(' and ')}` : '';
  return { where, params };
}

export async function getDashboardData(filters?: { periodo?: string; eje?: string; linea?: string; etapa?: string; modalidad?: string; especialistaId?: string }) {
  try {
    const { where, params } = buildProyectoConditions(filters);
    const { rows } = await query(`${PROYECTO_BASE_SELECT} ${where} order by p.id asc`, params);

    if (!rows || rows.length === 0) return [];

    // Filtro seguro en el servidor para evitar el colapso del inner join
    const proyectosValidos = rows.filter((p: any) => {
      const desc = p.etapa_descripcion?.toLowerCase() || '';
      return !desc.includes('no habilitada');
    });

    return proyectosValidos.map(mapProyectoRow);
  } catch (err) {
    console.error("FATAL ERROR getDashboardData:", err);
    return [];
  }
}

export async function getGestionProyectosData(filters?: { periodo?: string; eje?: string; linea?: string; etapa?: string; modalidad?: string; especialistaId?: string; grupo_id?: string; id_exacto?: string }) {
  try {
    const { where, params } = buildProyectoConditions(filters);
    const { rows } = await query(`${PROYECTO_BASE_SELECT} ${where} order by p.id asc`, params);

    if (!rows || rows.length === 0) return [];

    // Replica el .not('etapas.descripcion','ilike','no habilitada') de PostgREST
    // sobre un embed to-one: el proyecto se mantiene, pero su etapa queda nula
    // (la vista lo muestra como 'Sin Etapa').
    return rows.map((p: any) => {
      if ((p.etapa_descripcion || '').toLowerCase() === 'no habilitada') {
        return mapProyectoRow({ ...p, etapa_descripcion: null, etapa_fase: null });
      }
      return mapProyectoRow(p);
    });
  } catch (err) {
    console.error("FATAL ERROR getGestionProyectosData:", err);
    return [];
  }
}

// --- GLOBAL DASHBOARD FILTERS (REACTIVE) ---

export async function getDashboardStats(especialistaId?: number) {
    return await getDashboardData({ especialistaId: especialistaId?.toString() });
}

export async function getRegionData(especialistaId?: number) {
    // Current implementation uses getDashboardData and aggregates client-side,
    // but we satisfy the named function requirement.
    return await getDashboardData({ especialistaId: especialistaId?.toString() });
}

export async function getInstitucionData(especialistaId?: number) {
    // Current implementation uses getDashboardData and aggregates client-side
    return await getDashboardData({ especialistaId: especialistaId?.toString() });
}

export async function getProyectoCompletoById(id: string) {
  try {
    const { rows } = await query(`${PROYECTO_BASE_SELECT} where p.id = $1::int`, [id]);
    const p: any = rows[0];

    if (!p) {
      console.error("Error fetching project by id: not found", id);
      return null;
    }

    const yearMatch = p.codigo_proyecto?.match(/^(\d{4})/);
    const year = yearMatch ? parseInt(yearMatch[1], 10) : (Number(p.año) || new Date().getFullYear());

    return {
      id: p.id,
      codigo: p.codigo_proyecto,
      codigo_proyecto: p.codigo_proyecto,
      nombre: p.nombre,
      institucion: p.institucion_nombre || 'Desconocido',
      institucionId: p.institucion_ejecutora_id,
      gestora: p.gestora,
      linea: p.linea_descripcion || 'Desconocido',
      lineaId: p.linea_id,
      eje: p.eje_descripcion || 'Desconocido',
      ejeId: p.eje_id,
      etapa: p.etapa_descripcion || 'Desconocido',
      etapaId: p.etapa_id,
      region: p.region_descripcion || 'Multirregional',
      regionId: p.region_id,
      modalidad: p.modalidad_descripcion || 'Desconocido',
      modalidadId: p.modalidad_id,
      estado: p.etapa_descripcion || 'Activo',
      sustento: p.sustento || '',
      year: year,
      año: Number(p.año) || 0,
      monto_fondoempleo: Number(p.monto_fondoempleo) || 0,
      avance: Number(p.avance) || 0,
      contrapartida: Number(p.contrapartida) || 0,
      monto_total: Number(p.monto_total) || 0,
      beneficiarios: Number(p.beneficiarios) || 0,
      avance_tecnico: Number(p.avance_tecnico) || 0,
      fecha_inicio: p.avances?.find((a: any) => Number(a.etapa_id) === 1)?.fecha || null,
      fecha_fin: p.avances?.find((a: any) => Number(a.etapa_id) === 6)?.fecha || null,
      avances: p.avances?.map((av: any) => ({
        ...av,
        etapa_nombre: av.etapa?.descripcion || `Etapa ${av.etapa_id}`
      })) || [],
      grupo_id: p.grupo_id,
      provincia: p.provincia || '',
      especialista_id: p.especialista_id,
      especialista: p.especialista_nombre || '',
      contacto: p.contacto || ''
    };
  } catch (err) {
    console.error("FATAL ERROR getProyectoCompletoById:", err);
    return null;
  }
}

const _getLineas = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion from lineas order by id asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: `L${item.id} - ${item.descripcion}`
      }));
    } catch (err) {
      console.error("FATAL ERROR getLineas:", err);
      return [];
    }
  },
  ['catalog:lineas'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getLineas() { return _getLineas(); }

const _getEjes = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion from ejes order by id asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: `${item.id} - ${item.descripcion}`
      }));
    } catch (err) {
      console.error("FATAL ERROR getEjes:", err);
      return [];
    }
  },
  ['catalog:ejes'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getEjes() { return _getEjes(); }

const _getModalidades = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion from modalidades order by id asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: `${item.id} - ${item.descripcion}`
      }));
    } catch (err) {
      console.error("FATAL ERROR getModalidades:", err);
      return [];
    }
  },
  ['catalog:modalidades'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getModalidades() { return _getModalidades(); }

const _getEspecialistas = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, nombre from especialistas order by nombre asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: item.nombre
      }));
    } catch (err) {
      console.error("FATAL ERROR getEspecialistas:", err);
      return [];
    }
  },
  ['catalog:especialistas'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getEspecialistas() { return _getEspecialistas(); }

const _fetchDynamicYears = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select distinct "año" from proyectos where "año" is not null and "año" > 0 order by "año" desc');
      return rows.map((d: any) => Number(d.año)).filter((y: number) => !isNaN(y) && y > 0);
    } catch (err) {
      console.error("FATAL ERROR fetchDynamicYears:", err);
      return [];
    }
  },
  ['catalog:years'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function fetchDynamicYears() { return _fetchDynamicYears(); }

const _getEtapas = unstable_cache(
  async () => {
    try {
      const { rows } = await query(
        "select id, descripcion from etapas where not (descripcion ilike 'no habilitada') order by id asc"
      );
      // Mantener el orden del order by id eliminando duplicados si los hubiera
      const uniqueDescriptions: string[] = [];
      const seen = new Set();
      rows.forEach((d: any) => {
        if (d.descripcion && !seen.has(d.descripcion)) {
          seen.add(d.descripcion);
          uniqueDescriptions.push(d.descripcion);
        }
      });
      return uniqueDescriptions;
    } catch (err) {
      console.error("FATAL ERROR getEtapas:", err);
      return [];
    }
  },
  ['catalog:etapas'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getEtapas() { return _getEtapas(); }

const _getEtapasList = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion from etapas order by id asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: item.descripcion
      }));
    } catch (err) {
      console.error("FATAL ERROR getEtapasList:", err);
      return [];
    }
  },
  ['catalog:etapas-list'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getEtapasList() { return _getEtapasList(); }

const _getFasesOptions = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, fase from etapas order by id asc');
      return [...new Set(rows.map((item: any) => item.fase))].filter(Boolean) as string[];
    } catch (err) {
      console.error("FATAL ERROR getFasesOptions:", err);
      return [];
    }
  },
  ['catalog:fases'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getFasesOptions() { return _getFasesOptions(); }


// --- TIMELINE ACTIONS ---

export async function getTimelineData(especialistaId?: number) {
  try {
    const conditions: string[] = [];
    const params: unknown[] = [];
    if (especialistaId && Number(especialistaId) !== 0 && String(especialistaId) !== 'all' && String(especialistaId) !== 'undefined') {
      params.push(Number(especialistaId));
      conditions.push(`p.especialista_id = $${params.length}::int`);
    }
    const where = conditions.length ? `where ${conditions.join(' and ')}` : '';

    const { rows } = await query(`${PROYECTO_BASE_SELECT} ${where} order by p.id asc`, params);

    if (!rows || rows.length === 0) return [];

    // Filtro seguro en memoria para evitar colapso del inner join
    const proyectosValidos = rows.filter((p: any) => {
      const desc = p.etapa_descripcion?.toLowerCase() || '';
      return !desc.includes('no habilitada');
    });

    return proyectosValidos.map((p: any) => ({
      id: p.id,
      nombre: p.nombre,
      estado: p.etapa_descripcion || 'Activo',
      grupo_id: p.grupo_id,
      grupo_descripcion: p.grupo_descripcion || 'Sin Grupo',
      grupo_orden: p.grupo_orden || 999,
      eje_id: p.eje_id,
      linea_id: p.linea_id,
      eje: p.eje_descripcion || `Eje ${p.eje_id}`,
      linea: p.linea_descripcion || `Línea ${p.linea_id}`,
      codigo: p.codigo_proyecto || '-',
      codigo_proyecto: p.codigo_proyecto || '-',
      gestora: p.gestora || '-',
      monto_fondoempleo: Number(p.monto_fondoempleo) || 0,
      avance: Number(p.avance) || 0,
      institucion: p.institucion_nombre || '-',
      region: p.region_descripcion || '-',
      etapa: p.etapa_descripcion || 'Sin Etapa',
      fase: p.etapa_fase || '',
      avance_tecnico: Number(p.avance_tecnico) || 0,
      fecha_inicio: p.avances?.find((a: any) => a.etapa_id === 1)?.fecha || null,
      fecha_fin: p.avances?.find((a: any) => a.etapa_id === 6)?.fecha || null,
      avances: (p.avances || []).map((a: any) => ({
        id: a.id,
        fecha: a.fecha,
        etapa_id: a.etapa_id,
        sustento: a.sustento || ''
      })),
      provincia: p.provincia || '',
      especialista_id: p.especialista_id,
      especialista: p.especialista_nombre || '',
      contacto: p.contacto || ''
    }));
  } catch (err) {
    console.error("FATAL ERROR getTimelineData:", err);
    return [];
  }
}

// --- SALDOS BANCARIOS POR BANCO (editados desde Catálogos) ---

const _getSaldosBancarios = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select * from saldo_bancario order by "año" asc, monto desc');
      return rows as any[];
    } catch (err) {
      // La tabla puede no existir aún (ver scripts/migration_impacto_saldos_auditoria.sql):
      // degradar sin romper la página.
      console.error("FATAL ERROR getSaldosBancarios:", err);
      return [];
    }
  },
  ['catalog:saldos-bancarios'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] } // ediciones desde Catálogos lo invalidan
);
export async function getSaldosBancarios() { return _getSaldosBancarios(); }

// --- INFORMES DE IMPACTO (por grupo, editados desde Catálogos) ---

const _getInformesImpacto = unstable_cache(
  async () => {
    try {
      // Las fechas van como string (paridad con PostgREST) — ver convención en db.ts.
      const { rows } = await query(
        `select id, grupo_id, linea_id, titulo,
                fecha_inicio::text as fecha_inicio, fecha_fin::text as fecha_fin, archivo_url
           from informe_impacto
          order by fecha_inicio asc`,
      );
      return rows as any[];
    } catch (err) {
      // La tabla puede no existir aún: degradar sin romper el dashboard.
      console.error("FATAL ERROR getInformesImpacto:", err);
      return [];
    }
  },
  ['catalog:informes-impacto'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] } // ediciones desde Catálogos lo invalidan
);
export async function getInformesImpacto() { return _getInformesImpacto(); }

// --- PAGOS GESTORAS (para GestoraChart) ---

export async function getPagosGestoras() {
  try {
    const { rows } = await query('select gestora, monto, mes_pago::text as mes_pago from pagos_gestoras');
    return rows;
  } catch (err) {
    console.error("FATAL ERROR getPagosGestoras:", err);
    return [];
  }
}

// --- CORPORATIVO ACTIONS ---

export async function getFinanzasAnual() {
  try {
    const { rows } = await query('select * from finanzas_anual order by "año" asc');
    return rows as any[];
  } catch (err) {
    console.error("FATAL ERROR getFinanzasAnual:", err);
    return [];
  }
}

// --- PROYECTOS CRUD ACTIONS ---

/** Valida un nombre de columna dinámico (permite ñ/acentos, rechaza comillas). */
function colName(col: string): string {
  if (!/^[\p{L}_][\p{L}\p{N}_]*$/u.test(col)) {
    throw new Error(`Columna no válida: "${col}"`);
  }
  return `"${col}"`;
}

async function getAuditUserId(): Promise<string | null> {
  try {
    const session = await getSession();
    return session?.user.id ?? null;
  } catch {
    return null;
  }
}

export async function createProyecto(formData: any) {
  const userId = await getAuditUserId();
  // proyectos.id no tiene default/secuencia en la BD: se asigna max(id)+1
  // (se ignora cualquier id que venga en el formulario).
  const { id: _idFormulario, ...datos } = formData ?? {};
  const cols = Object.keys(datos);
  const values = cols.map((c) => datos[c]);
  const placeholders = cols.map((_, i) => `$${i + 1}`);

  // Si dos altas simultáneas chocan (23505), se reintenta con el nuevo máximo.
  let rows: any[] = [];
  let lastError: any = null;
  for (let intento = 0; intento < 3; intento++) {
    try {
      rows = await withAuditUser(userId, async (client) => {
        const maxResult = await client.query('select coalesce(max(id), 0) + 1 as next_id from proyectos');
        const nextId = Number(maxResult.rows[0].next_id);
        const result = await client.query(
          `insert into proyectos (id${cols.length ? ', ' + cols.map(colName).join(', ') : ''})
           values ($${cols.length + 1}${cols.length ? ', ' + placeholders.join(', ') : ''}) returning *`,
          [...values, nextId],
        );
        return result.rows;
      });
      lastError = null;
      break;
    } catch (error: any) {
      lastError = error;
      if (error?.code !== '23505') break; // solo reintentar por id duplicado
    }
  }

  if (lastError) {
    console.error("Error creating proyecto:", lastError);
    throw new Error(lastError.message);
  }

  revalidatePath('/dashboard/gestion-proyectos');
  revalidateTag(CATALOG_TAG, 'max'); // años, grupos podrían haber cambiado (Next 16 exige el 2º arg; 'max' preserva el comportamiento previo)
  return rows;
}

export async function updateProyecto(id: any, formData: any) {
  const userId = await getAuditUserId();
  const cols = Object.keys(formData);
  const values = cols.map((c) => formData[c]);
  const assignments = cols.map((c, i) => `${colName(c)} = $${i + 1}`);

  try {
    const rows = await withAuditUser(userId, async (client) => {
      const result = await client.query(
        `update proyectos set ${assignments.join(', ')} where id = $${cols.length + 1}::int returning *`,
        [...values, id],
      );
      return result.rows;
    });

    revalidatePath('/dashboard/gestion-proyectos');
    revalidateTag(CATALOG_TAG, 'max'); // años, grupos podrían haber cambiado (Next 16 exige el 2º arg; 'max' preserva el comportamiento previo)
    return rows;
  } catch (error: any) {
    console.error("Error updating proyecto:", error);
    throw new Error(error.message);
  }
}

export async function deleteProyecto(id: any) {
  const userId = await getAuditUserId();
  try {
    await withAuditUser(userId, async (client) => {
      await client.query('delete from proyectos where id = $1::int', [id]);
    });

    revalidatePath('/dashboard/gestion-proyectos');
    revalidateTag(CATALOG_TAG, 'max'); // años, grupos podrían haber cambiado (Next 16 exige el 2º arg; 'max' preserva el comportamiento previo)
    return { success: true };
  } catch (error: any) {
    console.error("Error deleting proyecto:", error);
    throw new Error(error.message);
  }
}

const _getInstituciones = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, nombre from instituciones_ejecutoras order by nombre asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: item.nombre
      }));
    } catch (err) {
      console.error("FATAL ERROR getInstituciones:", err);
      return [];
    }
  },
  ['catalog:instituciones'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getInstituciones() { return _getInstituciones(); }

const _getRegiones = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion from regiones order by descripcion asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: item.descripcion
      }));
    } catch (err) {
      console.error("FATAL ERROR getRegiones:", err);
      return [];
    }
  },
  ['catalog:regiones'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getRegiones() { return _getRegiones(); }

// --- AVANCE PROYECTO ACTIONS ---

async function recalculateProyectoAvance(proyectoId: any, client: { query: (text: string, params?: unknown[]) => Promise<any> }) {
  const today = new Date().toISOString().split('T')[0];

  // 1. Obtener el historial de avances reales (fecha <= hoy, sin proyecciones),
  //    ordenado del más reciente al más antiguo.
  const { rows: allAvances } = await client.query(
    `select etapa_id, sustento, fecha::text as fecha, monto
       from avance_proyecto
      where proyecto_id = $1::int and fecha <= $2::date
      order by fecha desc, id desc`,
    [proyectoId, today],
  );

  if (allAvances && allAvances.length > 0) {
    // 2. El avance más reciente (índice 0) define la etapa actual
    const latestAvance = allAvances[0];
    const newEtapaId = latestAvance.etapa_id;

    // 3. Asigna como sustento el texto del avance más reciente. Si está vacío, busca hacia atrás.
    const sustentoFinal = allAvances.find((av: any) => av.sustento && av.sustento.trim() !== '')?.sustento || '';

    // Calculamos el avance financiero total (solo de avances reales <= hoy)
    const totalAvanceFinanciero = allAvances.reduce((sum: number, item: any) => sum + (Number(item.monto) || 0), 0);

    // Actualizamos el proyecto padre
    await client.query(
      'update proyectos set etapa_id = $1, sustento = $2, avance = $3 where id = $4::int',
      [newEtapaId, sustentoFinal, totalAvanceFinanciero, proyectoId],
    );

    // 4. CRÍTICO: Limpiar caché de Next.js
    revalidatePath('/dashboard/gestion-proyectos');
  }
}

export async function addAvanceProyecto(proyectoId: any, avanceData: any) {
  const userId = await getAuditUserId();
  const payload = { ...avanceData, proyecto_id: proyectoId, monto: Number(avanceData.monto) || 0 };
  const cols = Object.keys(payload);
  const values = cols.map((c) => (payload as any)[c]);
  const placeholders = cols.map((_, i) => `$${i + 1}`);

  try {
    const data = await withAuditUser(userId, async (client) => {
      const result = await client.query(
        `insert into avance_proyecto (${cols.map(colName).join(', ')}) values (${placeholders.join(', ')}) returning *`,
        values,
      );
      const inserted = result.rows[0];
      await recalculateProyectoAvance(proyectoId, client);
      return inserted;
    });

    revalidatePath('/dashboard/gestion-proyectos');
    return data;
  } catch (error: any) {
    console.error("Error inserting avance:", error);
    throw new Error(error.message);
  }
}

export async function updateAvanceProyecto(id: any, avanceData: any) {
  const userId = await getAuditUserId();
  const payload = { ...avanceData, monto: Number(avanceData.monto) || 0 };
  const cols = Object.keys(payload);
  const values = cols.map((c) => (payload as any)[c]);
  const assignments = cols.map((c, i) => `${colName(c)} = $${i + 1}`);

  try {
    const data = await withAuditUser(userId, async (client) => {
      const result = await client.query(
        `update avance_proyecto set ${assignments.join(', ')} where id = $${cols.length + 1} returning *`,
        [...values, id],
      );
      const updated = result.rows[0];
      if (updated?.proyecto_id) {
        await recalculateProyectoAvance(updated.proyecto_id, client);
      }
      return updated;
    });

    revalidatePath('/dashboard/gestion-proyectos');
    return data;
  } catch (error: any) {
    console.error("Error updating avance:", error);
    throw new Error(error.message);
  }
}


export async function deleteAvanceProyecto(id: any, proyectoId: any) {
  const userId = await getAuditUserId();
  try {
    await withAuditUser(userId, async (client) => {
      await client.query('delete from avance_proyecto where id = $1', [id]);
      await recalculateProyectoAvance(proyectoId, client);
    });

    revalidatePath('/dashboard/gestion-proyectos');
    return { success: true };
  } catch (error: any) {
    console.error("Error deleting avance:", error);
    throw new Error(error.message);
  }
}

const _getGruposProyectos = unstable_cache(
  async () => {
    try {
      const { rows } = await query('select id, descripcion, orden from grupo where tipo = 2 order by orden asc');
      return rows.map((item: any) => ({
        value: item.id,
        label: `${item.orden} - ${item.descripcion}`
      }));
    } catch (err) {
      console.error("FATAL ERROR getGruposProyectos:", err);
      return [];
    }
  },
  ['catalog:grupos'],
  { revalidate: CATALOG_REVALIDATE_SECONDS, tags: [CATALOG_TAG] }
);
export async function getGruposProyectos() { return _getGruposProyectos(); }
