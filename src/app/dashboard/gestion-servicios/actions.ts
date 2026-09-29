"use server";

import { revalidatePath } from "next/cache";
import { query, withAuditUser } from "@/lib/db";
import { descontarDeArrastre } from "@/lib/arrastre-server";
import { getSession } from "@/lib/session";
import { getModulosUsuario } from "@/lib/permisos";
import { tieneAccesoModulo } from "@/config/permissions";
import { extraerOrdenPago } from "@/lib/pagos";
import { leerAnexo02, periodoDeGlosa, pareceTarjeta, numeroOPDeArchivo, type LecturaAnexo } from "@/lib/anexo02";
import {
  validarCCI,
  validarLineaOP,
  resolverConcepto,
  normalizarNombreBanco,
  cuadraTotal,
  sustentoPagoOP,
  soloDigitos,
  type ConceptoBeca,
  type Hallazgo,
} from "@/lib/becas-validacion";

// ─────────────────────────────────────────────────────────────────────────────
// Capa de datos: Postgres directo. Los embeds de PostgREST (eje:eje_id(...),
// avances:avance_beca(...)) se replican con LEFT JOIN + json_build_object /
// json_agg, devolviendo exactamente las mismas formas anidadas.
// ─────────────────────────────────────────────────────────────────────────────

const BECA_BASE_SELECT = `
  select
    b.id, b.nombre, b.documento, b.periodo, b.eje_id, b.linea_id, b.etapa_id, b.modalidad_id,
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
    // 'avance' NO: es derivado, lo calcula recalculateBecaAvance sumando los pagos de la bitácora
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

/**
 * Recalcula etapa/avance derivados de la bitácora para varias becas a la vez.
 * Lo usa la sincronización de informes de impacto (módulo Catálogos), que
 * escribe eventos de etapa Impacto directamente en avance_beca sin pasar por
 * addAvanceServicio.
 */
export async function recalcularEtapasBecas(becaIds: number[]) {
  const ids = Array.from(new Set((becaIds || []).filter((id) => id != null)));
  if (ids.length === 0) return;

  for (const id of ids) {
    await recalculateBecaAvance(id);
  }
  revalidatePath('/dashboard/servicios');
  revalidatePath('/dashboard/gestion-servicios');
}

/**
 * Registra un evento en la bitácora de la beca. Si trae `monto`, es un PAGO PARCIAL
 * (la orden de pago va al inicio del sustento: "OP 138-UPS-AS - S/ 903.40").
 *
 * `descontarDeArrastre`: el pago ya estaba incluido en el acumulado migrado
 * (evento "Arrastre:"); se registra igual para dejarlo trazable, pero el arrastre
 * baja en el mismo monto y el avance total de la beca no cambia.
 */
export async function addAvanceServicio(becaId: any, avanceData: any) {
  const monto = Number(avanceData.monto) || 0;
  let data: any;
  try {
    const { rows } = await query(
      `insert into avance_beca (beca_id, etapa_id, fecha, sustento, monto)
       values ($1::int, $2, $3, $4, $5) returning *`,
      [becaId, avanceData.etapa_id, avanceData.fecha, avanceData.sustento, monto],
    );
    data = rows[0];
  } catch (err: any) {
    console.error("Error inserting avance:", err);
    throw new Error(err.message);
  }

  if (avanceData.descontarDeArrastre && monto > 0) {
    await descontarDeArrastre({ tabla: 'avance_beca', fk: 'beca_id', padreId: becaId, monto });
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

// ═════════════════════════════════════════════════════════════════════════════
// ÓRDENES DE PAGO DE BECAS (skill pago-becas)
//
// Tablas: beca_orden_pago (cabecera) y beca_orden_pago_detalle (una línea por
// fila del Anexo 02). Cuando el banco ejecuta el pago, cada línea genera (o
// adopta) su evento en avance_beca con el sustento "OP 205-UPS-AS - S/ 822.26"
// y queda enlazada en avance_beca_id. El avance de la beca sigue siendo la suma
// de su bitácora (recalculateBecaAvance): aquí nunca se edita a mano.
//
// A diferencia del resto del módulo, estas acciones revalidan el permiso
// (módulo Gestión de Servicios) y escriben con withAuditUser.
// ═════════════════════════════════════════════════════════════════════════════

const ESTADOS_OP_MANUALES = ['GENERADA', 'ENVIADA', 'EN_TESORERIA', 'PENDIENTE_FIRMA', 'OBSERVADA'] as const;

async function assertGestionServicios(): Promise<{ userId: string | null; email: string }> {
  const session = await getSession();
  const email = session?.user.email ?? '';
  const modulos = await getModulosUsuario(email);
  if (!session || !tieneAccesoModulo(modulos, 'Gestión de Servicios')) {
    throw new Error('No autorizado: se requiere el módulo Gestión de Servicios.');
  }
  return { userId: session.user.id ?? null, email };
}

function revalidarOrdenes(id?: number | string) {
  revalidatePath('/dashboard/gestion-servicios/ordenes-pago');
  if (id !== undefined) revalidatePath(`/dashboard/gestion-servicios/ordenes-pago/${id}`);
  revalidatePath('/dashboard/gestion-servicios');
}

/** Número de OP de un sustento ("OP 205-UPS-AS - S/ 1.00" → 205). */
function numeroOPDeSustento(sustento: string | null | undefined): number | null {
  const ref = extraerOrdenPago(sustento);
  const m = ref?.match(/^OP (\d+)/);
  return m ? Number(m[1]) : null;
}

const r2 = (n: number) => Math.round(n * 100) / 100;

// ─── Lectura ────────────────────────────────────────────────────────────────

export async function getOrdenesPago() {
  await assertGestionServicios();
  const { rows } = await query(`
    select op.id, op.codigo, op.numero, op.anio, op.fecha_emision::text as fecha_emision,
           op.informe_codigo, op.grupo_id, g.descripcion as grupo, op.linea_id, l.descripcion as linea,
           op.modalidad, op.descripcion, op.importe, op.n_becarios, op.estado,
           op.dia_pago::text as dia_pago, op.fecha_ejecucion::text as fecha_ejecucion,
           op.nro_orden_banco, op.observaciones,
           coalesce(d.lineas, 0)::int as lineas, coalesce(d.suma, 0) as suma_lineas,
           coalesce(d.pagadas, 0)::int as pagadas, coalesce(d.grupos, '') as grupos_lineas,
           coalesce(d.grupo_ids, '{}') as grupo_ids
      from beca_orden_pago op
      left join grupo g  on g.id = op.grupo_id
      left join lineas l on l.id = op.linea_id
      left join lateral (
        select count(*) as lineas,
               sum(x.monto) filter (where x.estado <> 'ANULADA') as suma,
               count(*) filter (where x.estado = 'PAGADA') as pagadas,
               string_agg(distinct gg.descripcion, ' | ') as grupos,
               array_agg(distinct b.grupo_id) filter (where b.grupo_id is not null) as grupo_ids
          from beca_orden_pago_detalle x
          join becas_nueva b on b.id = x.beca_id
          left join grupo gg on gg.id = b.grupo_id
         where x.orden_pago_id = op.id
      ) d on true
     order by op.anio desc, op.numero desc`);
  return rows;
}

export async function getOrdenPago(id: number) {
  await assertGestionServicios();
  const { rows: cab } = await query(`
    select op.*, op.fecha_emision::text as fecha_emision, op.dia_pago::text as dia_pago,
           op.fecha_ejecucion::text as fecha_ejecucion, op.created_at::text as created_at,
           g.descripcion as grupo, l.descripcion as linea
      from beca_orden_pago op
      left join grupo g  on g.id = op.grupo_id
      left join lineas l on l.id = op.linea_id
     where op.id = $1`, [id]);
  if (!cab[0]) return null;
  const { rows: lineas } = await query(`
    select d.*, d.comprobante_fecha::text as comprobante_fecha,
           b.nombre as becario, b.documento as becario_dni, b.grupo_id, g.descripcion as grupo,
           c.codigo as concepto_codigo, c.nombre as concepto_nombre,
           i.descripcion as institucion, bk.sigla as banco_sigla, bk.nombre as banco_nombre,
           a.fecha::text as avance_fecha, a.sustento as avance_sustento
      from beca_orden_pago_detalle d
      join becas_nueva b   on b.id = d.beca_id
      left join grupo g    on g.id = b.grupo_id
      join concepto_beca c on c.id = d.concepto_id
      left join institucion i on i.id = d.institucion_id
      left join bancos bk  on bk.id = d.banco_id
      left join avance_beca a on a.id = d.avance_beca_id
     where d.orden_pago_id = $1
     order by coalesce(d.fila_anexo, 0), d.id`, [id]);
  return { ...cab[0], lineas };
}

/** Cuenta (vigente + historial), presupuesto por concepto y líneas de OP de una beca. */
export async function getCuentaPresupuestoBeca(becaId: number) {
  await assertGestionServicios();
  const [cuentas, presupuesto, lineas] = await Promise.all([
    query(`
      select bc.id, bc.titular_tipo, bc.titular_nombre, bc.titular_dni, bc.numero_cuenta, bc.cci,
             bc.cci_valido, bc.vigente, bc.fuente, bc.desde::text as desde, bc.observacion,
             bk.sigla as banco_sigla, bk.nombre as banco_nombre
        from beca_cuenta bc
        left join bancos bk on bk.id = bc.banco_id
       where bc.beca_id = $1
       order by bc.vigente desc, bc.desde desc nulls last, bc.id desc`, [becaId]),
    query(`
      with pend as (
        select concepto_id, sum(monto) as pendiente
          from beca_orden_pago_detalle
         where beca_id = $1 and estado = 'PENDIENTE'
         group by concepto_id
      ), pag as (
        select concepto_id, sum(monto) as pagado
          from beca_orden_pago_detalle
         where beca_id = $1 and estado = 'PAGADA' and cuenta_en_saldo
         group by concepto_id
      )
      select c.id as concepto_id, c.codigo, c.nombre,
             s.programado, coalesce(s.ejecutado, pag.pagado, 0) as ejecutado,
             s.saldo, coalesce(pend.pendiente, 0) as pendiente,
             (s.beca_id is not null) as tiene_presupuesto
        from concepto_beca c
        left join v_beca_saldo s on s.beca_id = $1 and s.concepto_id = c.id
        left join pend on pend.concepto_id = c.id
        left join pag  on pag.concepto_id = c.id
       where s.beca_id is not null or pend.concepto_id is not null or pag.concepto_id is not null
       order by c.orden nulls last, c.codigo`, [becaId]),
    query(`
      select d.id, d.orden_pago_id, op.codigo, op.numero, op.estado as op_estado,
             op.fecha_emision::text as fecha_emision, d.estado, d.monto, d.avance_beca_id,
             d.periodo_academico, d.cuenta_en_saldo, c.codigo as concepto
        from beca_orden_pago_detalle d
        join beca_orden_pago op on op.id = d.orden_pago_id
        join concepto_beca c on c.id = d.concepto_id
       where d.beca_id = $1
       order by op.anio desc, op.numero desc, d.id`, [becaId]),
  ]);
  return { cuentas: cuentas.rows, presupuesto: presupuesto.rows, lineas: lineas.rows };
}

// ─── Acciones sobre la OP ───────────────────────────────────────────────────

export type ResultadoOP = { ok: boolean; error?: string; mensaje?: string };

export async function cambiarEstadoOP(
  id: number,
  estado: string,
  datos?: { dia_pago?: string | null; txt_archivo?: string | null; carpeta_sharepoint?: string | null; observaciones?: string | null },
): Promise<ResultadoOP> {
  try {
    const { userId } = await assertGestionServicios();
    if (!(ESTADOS_OP_MANUALES as readonly string[]).includes(estado)) {
      return { ok: false, error: `Estado no permitido aquí: ${estado}. PAGADA se registra con «Registrar pago ejecutado» y ANULADA con «Anular».` };
    }
    await withAuditUser(userId, async (c) => {
      const { rows } = await c.query('select estado from beca_orden_pago where id = $1 for update', [id]);
      if (!rows[0]) throw new Error('La OP no existe.');
      if (['PAGADA', 'ANULADA'].includes(rows[0].estado)) throw new Error(`La OP está ${rows[0].estado}: ya no cambia de estado.`);
      await c.query(
        `update beca_orden_pago
            set estado = $2,
                dia_pago = coalesce($3::date, dia_pago),
                txt_archivo = coalesce($4, txt_archivo),
                carpeta_sharepoint = coalesce($5, carpeta_sharepoint),
                observaciones = coalesce($6, observaciones)
          where id = $1`,
        [id, estado, datos?.dia_pago || null, datos?.txt_archivo || null, datos?.carpeta_sharepoint || null, datos?.observaciones || null],
      );
    });
    revalidarOrdenes(id);
    return { ok: true, mensaje: `Estado cambiado a ${estado}.` };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}

/**
 * El banco ejecutó la OP: marca las líneas PAGADA y crea (o adopta) su evento en
 * avance_beca. Idempotente: una línea ya pagada no se toca, y si la beca ya
 * tiene un evento de la misma OP con el mismo monto se enlaza en vez de duplicarlo.
 */
export async function registrarPagoEjecutado(
  id: number,
  datos: { fecha_ejecucion: string; nro_orden_banco: string; importe_cargado?: number | null; dia_pago?: string | null },
): Promise<ResultadoOP> {
  try {
    const { userId } = await assertGestionServicios();
    if (!datos?.fecha_ejecucion || !/^\d{4}-\d{2}-\d{2}$/.test(datos.fecha_ejecucion)) return { ok: false, error: 'Indica la fecha de ejecución.' };
    if (!String(datos.nro_orden_banco ?? '').trim()) return { ok: false, error: 'Indica el N° de orden del banco.' };

    const res = await withAuditUser(userId, async (c) => {
      const { rows: ops } = await c.query('select id, numero, estado from beca_orden_pago where id = $1 for update', [id]);
      const op = ops[0];
      if (!op) throw new Error('La OP no existe.');
      if (op.estado === 'ANULADA') throw new Error('La OP está anulada.');

      const { rows: lineas } = await c.query(
        `select d.id, d.beca_id, d.monto, d.estado, d.avance_beca_id, b.etapa_id
           from beca_orden_pago_detalle d
           join becas_nueva b on b.id = d.beca_id
          where d.orden_pago_id = $1 and d.estado in ('PENDIENTE', 'PAGADA')
          order by d.id
          for update of d`,
        [id],
      );
      if (lineas.length === 0) throw new Error('La OP no tiene líneas pendientes.');

      let creados = 0, enlazados = 0, yaPagadas = 0;
      const becas = new Set<number>();
      for (const l of lineas) {
        if (l.estado === 'PAGADA' && l.avance_beca_id) { yaPagadas++; continue; }
        const monto = r2(Number(l.monto));

        // ¿Ya hay un evento de esta OP y este monto sin enlazar? (carga manual previa o 2.ª ejecución)
        const { rows: cand } = await c.query(
          `select a.id, a.sustento
             from avance_beca a
            where a.beca_id = $1 and a.monto = $2::numeric
              and not exists (select 1 from beca_orden_pago_detalle x where x.avance_beca_id = a.id)
            order by a.id`,
          [l.beca_id, monto.toFixed(2)],
        );
        let avanceId: number | null = cand.find((e: any) => numeroOPDeSustento(e.sustento) === Number(op.numero))?.id ?? null;

        if (avanceId) {
          enlazados++;
        } else {
          // El pago no cambia la etapa: el evento va con la etapa actual de la beca.
          let etapaId = l.etapa_id;
          if (!etapaId) {
            const { rows: ult } = await c.query(
              'select etapa_id from avance_beca where beca_id = $1 order by fecha desc, id desc limit 1', [l.beca_id]);
            etapaId = ult[0]?.etapa_id ?? null;
          }
          if (!etapaId) throw new Error(`La beca ${l.beca_id} no tiene etapa: no puedo registrar su evento de pago.`);
          const { rows: ins } = await c.query(
            `insert into avance_beca (beca_id, etapa_id, fecha, sustento, monto)
             values ($1, $2, $3::date, $4, $5::numeric) returning id`,
            [l.beca_id, etapaId, datos.fecha_ejecucion, sustentoPagoOP(Number(op.numero), monto), monto.toFixed(2)],
          );
          avanceId = Number(ins[0].id);
          creados++;
        }
        await c.query(
          "update beca_orden_pago_detalle set estado = 'PAGADA', avance_beca_id = $2 where id = $1",
          [l.id, avanceId],
        );
        becas.add(Number(l.beca_id));
      }

      await c.query(
        `update beca_orden_pago
            set estado = 'PAGADA', fecha_ejecucion = $2::date, nro_orden_banco = $3,
                importe_cargado = coalesce($4::numeric, importe_cargado),
                dia_pago = coalesce($5::date, dia_pago)
          where id = $1`,
        [id, datos.fecha_ejecucion, String(datos.nro_orden_banco).trim(), datos.importe_cargado ?? null, datos.dia_pago || null],
      );
      return { creados, enlazados, yaPagadas, becas: Array.from(becas) };
    });

    // Fuera de la transacción: el recálculo lee la bitácora ya confirmada.
    await recalcularEtapasBecas(res.becas);
    revalidarOrdenes(id);
    return {
      ok: true,
      mensaje: `Pago registrado: ${res.creados} evento(s) creado(s), ${res.enlazados} enlazado(s) a eventos existentes, ${res.yaPagadas} línea(s) ya estaban pagadas.`,
    };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}

/** El banco rechazó el abono de una línea (antes de registrarla como pagada). */
export async function rechazarLineaOP(lineaId: number, motivo: string): Promise<ResultadoOP> {
  try {
    const { userId } = await assertGestionServicios();
    if (!String(motivo ?? '').trim()) return { ok: false, error: 'Indica el motivo del rechazo.' };
    const opId = await withAuditUser(userId, async (c) => {
      const { rows } = await c.query('select orden_pago_id, estado from beca_orden_pago_detalle where id = $1 for update', [lineaId]);
      if (!rows[0]) throw new Error('La línea no existe.');
      if (rows[0].estado !== 'PENDIENTE') throw new Error(`Solo se rechaza una línea PENDIENTE (esta está ${rows[0].estado}).`);
      await c.query(
        `update beca_orden_pago_detalle
            set estado = 'RECHAZADA',
                observacion = concat_ws(' · ', nullif(observacion, ''), 'Rechazada por el banco: ' || $2)
          where id = $1`,
        [lineaId, String(motivo).trim()],
      );
      return rows[0].orden_pago_id;
    });
    revalidarOrdenes(opId);
    return { ok: true, mensaje: 'Línea marcada como RECHAZADA.' };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}

/** Anula la OP y sus líneas. Solo si ninguna línea está pagada. */
export async function anularOP(id: number, motivo: string): Promise<ResultadoOP> {
  try {
    const { userId } = await assertGestionServicios();
    if (!String(motivo ?? '').trim()) return { ok: false, error: 'Indica el motivo de la anulación.' };
    await withAuditUser(userId, async (c) => {
      const { rows } = await c.query('select estado from beca_orden_pago where id = $1 for update', [id]);
      if (!rows[0]) throw new Error('La OP no existe.');
      const { rows: pag } = await c.query(
        "select count(*)::int as n from beca_orden_pago_detalle where orden_pago_id = $1 and estado = 'PAGADA'", [id]);
      if (pag[0].n > 0) throw new Error(`No se puede anular: tiene ${pag[0].n} línea(s) pagada(s).`);
      await c.query("update beca_orden_pago_detalle set estado = 'ANULADA' where orden_pago_id = $1 and estado <> 'RECHAZADA'", [id]);
      await c.query(
        `update beca_orden_pago
            set estado = 'ANULADA',
                observaciones = concat_ws(' · ', nullif(observaciones, ''), 'Anulada: ' || $2)
          where id = $1`,
        [id, String(motivo).trim()],
      );
    });
    revalidarOrdenes(id);
    return { ok: true, mensaje: 'OP anulada.' };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}

// ─── Importar OP desde el Anexo 02 ──────────────────────────────────────────

export type LineaImportacion = {
  fila: number;
  incluir: boolean;
  dni: string | null;
  beca_id: number | null;
  becario: string | null;
  grupo_id: number | null;
  grupo: string | null;
  condicion: string | null;
  codigo_concepto: string | null;
  concepto_id: number | null;
  periodo_academico: string | null;
  institucion_id: number | null;
  institucion: string | null;
  cuenta_contable: string | null;
  tipo_abono: 'IE' | 'BECARIO';
  beneficiario_nombre: string;
  beneficiario_doc_tipo: 'DNI' | 'RUC' | 'CE';
  beneficiario_doc: string;
  banco_id: number | null;
  banco_texto: string | null;
  numero_cuenta: string | null;
  cci: string | null;
  monto: number;
  glosa: string | null;
  observacion: string | null;
  hallazgos: Hallazgo[];
};

export type CabeceraImportacion = {
  codigo: string;
  numero: number | null;
  anio: number;
  fecha_emision: string | null;
  informe_codigo: string | null;
  grupo_id: number | null;
  linea_id: number | null;
  modalidad: 'ABONO_IE' | 'REEMBOLSO' | 'ABONO_BECARIO';
  descripcion: string | null;
  importe: number;
  estado: string;
  observaciones: string | null;
};

type BancoCat = { id: number; codigo_cci: string; sigla: string | null; nombre: string };

export type VistaPreviaAnexo = {
  ok: boolean;
  error?: string;
  archivo?: string;
  lectura?: Omit<LecturaAnexo, 'filas'>;
  cabecera?: CabeceraImportacion;
  lineas?: LineaImportacion[];
  conceptos?: { id: number; codigo: string; nombre: string }[];
  grupos?: { id: number; descripcion: string }[];
  lineasCat?: { id: number; descripcion: string }[];
};

const normTxt = (s: unknown) =>
  String(s ?? '').normalize('NFD').replace(/[̀-ͯ]/g, '').toUpperCase().replace(/[^A-Z0-9 ]/g, ' ').replace(/\s+/g, ' ').trim();

async function catalogosImportacion() {
  const [conceptos, bancos, grupos, lineasCat, instituciones] = await Promise.all([
    query(`select id, codigo, nombre, tipo, abono_por_defecto, codigos_anexo from concepto_beca where activo order by orden nulls last, codigo`),
    query(`select id, codigo_cci, sigla, nombre from bancos order by codigo_cci`),
    query(`select id, descripcion from grupo where tipo = 1 order by orden, descripcion`),
    query(`select id, descripcion from lineas order by id`),
    query(`select id, descripcion, ruc from institucion`),
  ]);
  return {
    conceptos: conceptos.rows as ConceptoBeca[],
    bancos: bancos.rows as BancoCat[],
    grupos: grupos.rows as { id: number; descripcion: string }[],
    lineasCat: lineasCat.rows as { id: number; descripcion: string }[],
    instituciones: instituciones.rows as { id: number; descripcion: string; ruc: string | null }[],
  };
}

/** Banco por el texto que trae el Anexo («BCP», «Banco de Crédito del Perú», «Interbank»). */
function bancoPorTexto(texto: string | null, bancos: BancoCat[]): BancoCat | null {
  const t = normTxt(texto);
  if (!t) return null;
  return (
    bancos.find((b) => normTxt(b.sigla) === t || normTxt(b.nombre) === t) ??
    bancos.find((b) => normTxt(b.nombre).includes(t) || t.includes(normTxt(b.nombre)) || (!!b.sigla && t.split(' ').includes(normTxt(b.sigla)))) ??
    null
  );
}

function moda<T>(xs: (T | null | undefined)[]): T | null {
  const cuenta = new Map<T, number>();
  for (const x of xs) if (x !== null && x !== undefined) cuenta.set(x, (cuenta.get(x) ?? 0) + 1);
  let mejor: T | null = null, n = 0;
  for (const [k, v] of cuenta) if (v > n) { mejor = k; n = v; }
  return mejor;
}

/**
 * Valida las líneas contra la BD (becario, saldo, banco). La usan la vista previa
 * y la confirmación (que revalida lo que manda el cliente).
 */
async function validarLineasImportacion(
  lineas: LineaImportacion[],
  bancos: BancoCat[],
  instituciones: { id: number; ruc: string | null }[],
) {
  const ids = Array.from(new Set(lineas.map((l) => l.beca_id).filter(Boolean))) as number[];
  const saldos = ids.length
    ? (await query('select beca_id, concepto_id, saldo from v_beca_saldo where beca_id = any($1::int[])', [ids])).rows
    : [];
  const codigos = new Set(bancos.map((b) => b.codigo_cci));
  for (const l of lineas) {
    const saldo = saldos.find((s: any) => s.beca_id === l.beca_id && s.concepto_id === l.concepto_id);
    const cci = validarCCI(l.cci);
    const declarado = bancoPorTexto(l.banco_texto, bancos);
    l.hallazgos = validarLineaOP(
      {
        tipo_abono: l.tipo_abono,
        beneficiario_nombre: l.beneficiario_nombre,
        beneficiario_doc_tipo: l.beneficiario_doc_tipo,
        beneficiario_doc: l.beneficiario_doc,
        cci: l.cci,
        banco_codigo_declarado: declarado?.codigo_cci ?? null,
        monto: l.monto,
      },
      {
        becaEncontrada: Boolean(l.beca_id),
        condicionBeca: l.condicion,
        saldoConcepto: saldo ? Number(saldo.saldo) : null,
        bancoConocido: cci.codigoBanco ? codigos.has(cci.codigoBanco) : undefined,
        rucIE: l.tipo_abono === 'IE' ? instituciones.find((i) => i.id === l.institucion_id)?.ruc ?? null : null,
      },
    );
    if (!l.concepto_id) {
      l.hallazgos.unshift({ severidad: 'error', campo: 'concepto', mensaje: `No reconozco el concepto «${l.codigo_concepto ?? ''}»: agrégalo como alias en Catálogos → Conceptos de beca o elígelo en la lista.` });
    }
  }
  // Mismo becario + concepto + monto repetido dentro de la misma OP.
  const vistos = new Map<string, number>();
  for (const l of lineas.filter((x) => x.incluir)) {
    const k = `${l.beca_id}|${l.concepto_id}|${l.monto}`;
    if (vistos.has(k)) l.hallazgos.push({ severidad: 'alerta', campo: 'duplicado', mensaje: `Repite becario, concepto y monto de la fila ${vistos.get(k)}.` });
    else vistos.set(k, l.fila);
  }
}

const SQL_BECAS_POR_DNI = `
  select b.id, b.nombre, b.grupo_id, b.linea_id, b.institucion_id, g.descripcion as grupo, c.descripcion as condicion,
         lpad(regexp_replace(coalesce(b.documento, ''), '\\D', '', 'g'), 8, '0') as dni, 'BECA' as via
    from becas_nueva b
    left join grupo g on g.id = b.grupo_id
    left join condicion c on c.id = b.condicion_id
   where lpad(regexp_replace(coalesce(b.documento, ''), '\\D', '', 'g'), 8, '0') = any($1::text[])
  union all
  select b.id, b.nombre, b.grupo_id, b.linea_id, b.institucion_id, g.descripcion, c.descripcion,
         lpad(regexp_replace(bc.titular_dni, '\\D', '', 'g'), 8, '0'), 'CUENTA'
    from beca_cuenta bc
    join becas_nueva b on b.id = bc.beca_id
    left join grupo g on g.id = b.grupo_id
    left join condicion c on c.id = b.condicion_id
   where bc.vigente and lpad(regexp_replace(bc.titular_dni, '\\D', '', 'g'), 8, '0') = any($1::text[])`;

export async function previsualizarAnexo(formData: FormData): Promise<VistaPreviaAnexo> {
  try {
    await assertGestionServicios();
    const file = formData.get('archivo') as File | null;
    const hoja = (formData.get('hoja') as string | null) || null;
    if (!file || file.size === 0) return { ok: false, error: 'Selecciona el archivo .xlsx del Anexo 02.' };
    if (file.size > 20 * 1024 * 1024) return { ok: false, error: 'El archivo excede 20 MB.' };

    const lectura = leerAnexo02(Buffer.from(await file.arrayBuffer()), hoja);
    const cat = await catalogosImportacion();

    // Becas por DNI del becario y, si no, por el DNI del titular de su cuenta vigente (aval).
    const dnis = Array.from(new Set(lectura.filas.map((f) => f.dni).filter(Boolean))) as string[];
    const becas: any[] = dnis.length ? (await query(SQL_BECAS_POR_DNI, [dnis])).rows : [];

    const periodoOP = moda(lectura.filas.map((f) => periodoDeGlosa(f.glosa)));
    const lineas: LineaImportacion[] = lectura.filas.map((f) => {
      const obs: string[] = [];
      const posibles = becas.filter((b) => b.dni === f.dni);
      const directas = posibles.filter((b) => b.via === 'BECA');
      const lista = directas.length ? directas : posibles;
      const beca = lista.find((b) => b.condicion === 'Activo') ?? lista[lista.length - 1] ?? null;
      if (beca && lista.length > 1) obs.push(`El DNI tiene ${lista.length} becas; se usa la id ${beca.id} (${beca.grupo}).`);
      if (beca && beca.via === 'CUENTA') obs.push('Emparejada por el DNI del titular de la cuenta (aval).');

      const concepto = resolverConcepto(f.codigo_concepto, cat.conceptos);
      const esIE = Boolean(f.ruc_ie) && !f.titular;
      const cci = validarCCI(f.cci);
      const banco = cci.codigoBanco ? cat.bancos.find((b) => b.codigo_cci === cci.codigoBanco) ?? null : null;
      const declarado = bancoPorTexto(f.banco, cat.bancos);
      if (banco && declarado && declarado.codigo_cci !== banco.codigo_cci) {
        obs.push(`El Anexo dice «${f.banco}» pero el CCI es de ${banco.sigla ?? banco.nombre} (${banco.codigo_cci}): manda el CCI.`);
      }
      let numeroCuenta = f.numero_cuenta;
      if (pareceTarjeta(numeroCuenta)) {
        obs.push('En «cuenta bancaria» viene lo que parece un número de tarjeta: no se guarda, queda solo el CCI.');
        numeroCuenta = null;
      }
      const periodo = periodoDeGlosa(f.glosa);
      if (periodo && periodoOP && periodo !== periodoOP) obs.push(`La glosa dice ${periodo}; el resto de la OP es ${periodoOP}. Revisa el periodo.`);

      // Institución: por RUC (abono a IE), por nombre, o la de la beca.
      const porRuc = f.ruc_ie ? cat.instituciones.find((i) => soloDigitos(i.ruc) === f.ruc_ie) : null;
      const porNombre = f.institucion ? cat.instituciones.find((i) => normTxt(i.descripcion) === normTxt(f.institucion)) : null;

      return {
        fila: f.fila,
        incluir: true,
        dni: f.dni,
        beca_id: beca?.id ?? null,
        becario: beca?.nombre ?? f.becario ?? f.titular,
        grupo_id: beca?.grupo_id ?? null,
        grupo: beca?.grupo ?? null,
        condicion: beca?.condicion ?? null,
        codigo_concepto: f.codigo_concepto,
        concepto_id: concepto?.id ?? null,
        periodo_academico: periodo,
        institucion_id: porRuc?.id ?? porNombre?.id ?? beca?.institucion_id ?? null,
        institucion: f.institucion,
        cuenta_contable: f.cuenta_contable,
        tipo_abono: esIE ? 'IE' : 'BECARIO',
        beneficiario_nombre: normalizarNombreBanco(esIE ? f.institucion : (f.titular ?? f.becario)),
        beneficiario_doc_tipo: esIE ? 'RUC' : 'DNI',
        beneficiario_doc: esIE ? String(f.ruc_ie) : String(f.dni ?? ''),
        banco_id: banco?.id ?? null,
        banco_texto: f.banco,
        numero_cuenta: numeroCuenta,
        cci: cci.cci || null,
        monto: f.monto,
        glosa: f.glosa,
        observacion: obs.length ? obs.join(' ') : null,
        hallazgos: [],
      };
    });
    await validarLineasImportacion(lineas, cat.bancos, cat.instituciones);

    const numero = numeroOPDeArchivo(file.name);
    const anio = new Date().getFullYear();
    const grupos = new Set(lineas.map((l) => l.grupo_id).filter(Boolean));
    if (numero) {
      const { rows: existe } = await query('select codigo, estado from beca_orden_pago where numero = $1 and anio = $2', [numero, anio]);
      if (existe[0]) lectura.avisos.unshift(`Ya existe la OP ${existe[0].codigo} (${existe[0].estado}). No se puede volver a importar con ese número.`);
    }

    const { filas: _filas, ...resto } = lectura;
    return {
      ok: true,
      archivo: file.name,
      lectura: resto,
      cabecera: {
        codigo: numero ? `${numero}-UPS-AS/FE-${anio}` : '',
        numero,
        anio,
        fecha_emision: null,
        informe_codigo: null,
        grupo_id: grupos.size === 1 ? (Array.from(grupos)[0] as number) : null,
        linea_id: moda(becas.map((b) => b.linea_id)),
        modalidad: lineas.every((l) => l.tipo_abono === 'IE') ? 'ABONO_IE' : lineas.some((l) => /REEMBOLSO/i.test(l.glosa ?? '')) ? 'REEMBOLSO' : 'ABONO_BECARIO',
        descripcion: lectura.filas[0]?.glosa ?? null,
        importe: r2(lineas.reduce((a, l) => a + l.monto, 0)),
        estado: 'GENERADA',
        observaciones: null,
      },
      lineas,
      conceptos: cat.conceptos.map((c) => ({ id: c.id, codigo: c.codigo, nombre: c.nombre })),
      grupos: cat.grupos,
      lineasCat: cat.lineasCat,
    };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}

/** Guarda la OP revisada en la vista previa. Revalida en el servidor antes de escribir. */
export async function confirmarImportacionAnexo(
  cabecera: CabeceraImportacion,
  lineasCliente: LineaImportacion[],
): Promise<ResultadoOP & { id?: number }> {
  try {
    const { userId, email } = await assertGestionServicios();
    const cat = await catalogosImportacion();
    const lineas = (lineasCliente ?? [])
      .filter((l) => l.incluir)
      .map((l) => ({ ...l, monto: r2(Number(l.monto)), hallazgos: [] as Hallazgo[] }));
    if (lineas.length === 0) return { ok: false, error: 'No hay líneas incluidas.' };

    const codigo = String(cabecera?.codigo ?? '').trim();
    const numero = Number(cabecera?.numero);
    const anio = Number(cabecera?.anio);
    if (!codigo || !numero || !anio) return { ok: false, error: 'Completa el código, número y año de la OP.' };
    if (!['ABONO_IE', 'REEMBOLSO', 'ABONO_BECARIO'].includes(cabecera.modalidad)) return { ok: false, error: 'Modalidad no válida.' };
    if (!(ESTADOS_OP_MANUALES as readonly string[]).includes(cabecera.estado)) return { ok: false, error: 'Estado inicial no válido.' };

    // Revalidar becario, concepto y banco desde la BD (no confiar en lo que manda el cliente).
    const ids = Array.from(new Set(lineas.map((l) => l.beca_id).filter(Boolean))) as number[];
    const { rows: becas } = await query(
      'select b.id, c.descripcion as condicion from becas_nueva b left join condicion c on c.id = b.condicion_id where b.id = any($1::int[])',
      [ids],
    );
    for (const l of lineas) {
      const b = becas.find((x: any) => x.id === l.beca_id);
      l.beca_id = b ? b.id : null;
      l.condicion = b?.condicion ?? null;
      if (l.concepto_id && !cat.conceptos.some((c) => c.id === Number(l.concepto_id))) l.concepto_id = null;
      l.cci = validarCCI(l.cci).cci || null;
      l.banco_id = l.cci ? cat.bancos.find((x) => x.codigo_cci === l.cci!.slice(0, 3))?.id ?? null : null;
      l.beneficiario_nombre = normalizarNombreBanco(l.beneficiario_nombre);
      if (pareceTarjeta(l.numero_cuenta)) l.numero_cuenta = null;
    }
    await validarLineasImportacion(lineas, cat.bancos, cat.instituciones);
    const errores = lineas.flatMap((l) => l.hallazgos.filter((h) => h.severidad === 'error').map((h) => `Fila ${l.fila}: ${h.mensaje}`));
    if (errores.length) return { ok: false, error: `Hay errores que impiden guardar:\n${errores.join('\n')}` };

    const cuadre = cuadraTotal(Number(cabecera.importe), lineas.map((l) => l.monto));
    if (!cuadre.cuadra) {
      return { ok: false, error: `El importe de la OP (S/ ${Number(cabecera.importe).toFixed(2)}) no cuadra con la suma de las líneas (S/ ${cuadre.suma.toFixed(2)}).` };
    }

    const id = await withAuditUser(userId, async (c) => {
      const { rows: dup } = await c.query('select codigo from beca_orden_pago where codigo = $1 or (numero = $2 and anio = $3)', [codigo, numero, anio]);
      if (dup[0]) throw new Error(`Ya existe la OP ${dup[0].codigo}.`);
      const { rows: ins } = await c.query(
        `insert into beca_orden_pago
           (codigo, numero, anio, fecha_emision, informe_codigo, grupo_id, linea_id, modalidad, descripcion,
            importe, n_becarios, estado, observaciones, created_by)
         values ($1,$2,$3,$4::date,$5,$6,$7,$8,$9,$10::numeric,$11,$12,$13,$14) returning id`,
        [codigo, numero, anio, cabecera.fecha_emision || null, cabecera.informe_codigo || null,
         cabecera.grupo_id || null, cabecera.linea_id || null, cabecera.modalidad, cabecera.descripcion || null,
         cuadre.suma.toFixed(2), new Set(lineas.map((l) => l.beca_id)).size, cabecera.estado,
         cabecera.observaciones || null, email],
      );
      const opId = Number(ins[0].id);
      for (const l of lineas) {
        const alertas = l.hallazgos.filter((h) => h.severidad === 'alerta').map((h) => h.mensaje);
        const observacion = [l.observacion, ...alertas].filter(Boolean).join(' · ') || null;
        await c.query(
          `insert into beca_orden_pago_detalle
             (orden_pago_id, beca_id, concepto_id, periodo_academico, institucion_id, cuenta_contable, tipo_abono,
              beneficiario_nombre, beneficiario_doc_tipo, beneficiario_doc, banco_id, numero_cuenta, cci, monto,
              fila_anexo, observacion)
           values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14::numeric,$15,$16)`,
          [opId, l.beca_id, l.concepto_id, l.periodo_academico || null, l.institucion_id || null, l.cuenta_contable || null,
           l.tipo_abono, l.beneficiario_nombre, l.beneficiario_doc_tipo, soloDigitos(l.beneficiario_doc),
           l.banco_id, l.numero_cuenta || null, l.cci, l.monto.toFixed(2), l.fila, observacion],
        );
      }
      return opId;
    });
    revalidarOrdenes(id);
    return { ok: true, id, mensaje: `OP ${codigo} registrada con ${lineas.length} línea(s).` };
  } catch (e: any) {
    return { ok: false, error: e?.message ?? String(e) };
  }
}
