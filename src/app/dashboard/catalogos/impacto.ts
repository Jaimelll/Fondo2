// ─────────────────────────────────────────────────────────────────────────────
// Sincronización  informe_impacto (Catálogos)  →  bitácora de etapas.
//
// PROBLEMA QUE RESUELVE
// La fase "Impacto" se declara en Catálogos a nivel de GRUPO (tabla
// informe_impacto: grupo, línea, fecha de inicio y de cierre de la evaluación),
// pero la etapa de cada proyecto/beca se deriva de su bitácora de eventos
// (avance_* → recalculate* → etapa_id). Eran dos verdades desconectadas: un
// grupo con informe registrado seguía teniendo a los suyos en la etapa anterior,
// el dashboard los contaba en dos fases a la vez y el filtro de fase ni siquiera
// ofrecía "Impacto".
//
// REGLA
// El informe es la fuente de verdad; el evento de etapa Impacto es su proyección
// sobre cada registro alcanzado:
//
//   crear informe        → evento etapa 10 con fecha = informe.fecha_inicio
//   editar fecha_inicio  → se mueve la fecha de esos eventos
//   editar grupo/línea   → se borran los eventos de los que ya no alcanza y se
//                          crean los de los nuevos
//   borrar informe       → ON DELETE CASCADE borra sus eventos y el registro
//                          vuelve solo a su etapa anterior
//
// DOS DESTINOS, SEGÚN EL TIPO DE GRUPO
//   grupo.tipo = 2 (proyectos) → proyectos    / avance_proyecto
//   grupo.tipo = 1 (becas)     → becas_nueva  / avance_beca
//
// Alcance: grupo_id del informe y, si declara linea_id, solo esa línea.
//
// En BECAS la prueba de impacto se hace sobre las que llevan al menos SEIS MESES
// ejecutadas a la fecha de inicio del informe: esa fecha es la que identifica a
// qué becas corresponde cada informe. Un grupo puede tener VARIOS informes, y
// cada beca pertenece a UNO solo — el primero (por fecha de inicio) que ya la
// alcanza. Las que aún no cumplen el plazo entran solas en un informe posterior.
// La antigüedad se mide contra el evento de cierre de la bitácora, nunca contra
// la etapa guardada, que puede estar desfasada.
//
// El vínculo vive en avance_*.informe_impacto_id (bigint, FK a informe_impacto
// ON DELETE CASCADE, índice único parcial por (entidad, informe)). Un evento
// con esa columna en NULL es carga manual y NUNCA se borra desde aquí.
//
// Capa de datos: Postgres directo (src/lib/db.ts). Las columnas `date` se leen
// SIEMPRE como texto ('YYYY-MM-DD') para poder compararlas como strings, igual
// que hacía PostgREST; pg las devolvería como Date.
//
// Todas las funciones son IDEMPOTENTES: correrlas dos veces no duplica nada.
// ─────────────────────────────────────────────────────────────────────────────

import { query } from '@/lib/db';
import { recalcularEtapasProyectos } from '@/app/dashboard/actions';
import { recalcularEtapasBecas } from '@/app/dashboard/gestion-servicios/actions';

/** Etapa "Impacto" del catálogo `etapas`. */
export const ETAPA_IMPACTO = 10;
/** Etapa "Ejecutado": marca el cierre desde el que se cuenta la antigüedad. */
const ETAPA_EJECUTADO = 6;

type Informe = {
    id: number;
    grupo_id: number;
    linea_id: number | null;
    titulo: string | null;
    fecha_inicio: string | null;
};

/** A qué mundo proyecta un informe, según el tipo de su grupo. */
type Destino = {
    /** Nombre en singular para los mensajes ("proyecto" / "beca"). */
    etiqueta: string;
    tablaEntidad: string;
    tablaAvance: string;
    /** Columna de avance_* que apunta a la entidad. */
    fk: string;
    /**
     * Antigüedad mínima del cierre para entrar a la evaluación de impacto.
     * `null` = sin requisito.
     *
     * En BECAS la prueba de impacto se hace sobre las que llevan al menos seis
     * meses ejecutadas al momento del informe: el informe evalúa el efecto de
     * la beca pasado ese tiempo, no el cierre administrativo. Se mide contra el
     * evento de cierre de la bitácora, no contra la etapa guardada (que puede
     * estar desfasada).
     *
     * En PROYECTOS no hay requisito: el informe se registra cuando corresponde
     * y el ciclo ya trae sus propias etapas de Cierre y Pre-Impacto.
     */
    mesesDesdeCierre: number | null;
    /** Etapa que marca el cierre (para medir la antigüedad). */
    etapaCierre: number;
    recalcular: (ids: number[]) => Promise<void>;
};

const DESTINO_PROYECTOS: Destino = {
    etiqueta: 'proyecto',
    tablaEntidad: 'proyectos',
    tablaAvance: 'avance_proyecto',
    fk: 'proyecto_id',
    mesesDesdeCierre: null,
    etapaCierre: ETAPA_EJECUTADO,
    recalcular: recalcularEtapasProyectos,
};

const DESTINO_BECAS: Destino = {
    etiqueta: 'beca',
    tablaEntidad: 'becas_nueva',
    tablaAvance: 'avance_beca',
    fk: 'beca_id',
    mesesDesdeCierre: 6,
    etapaCierre: ETAPA_EJECUTADO,
    recalcular: recalcularEtapasBecas,
};

/**
 * Identificador SQL entre comillas. Los nombres salen de las constantes de
 * arriba, pero se valida igual antes de interpolarlos.
 */
function ident(name: string): string {
    if (!/^[\p{L}_][\p{L}\p{N}_]*$/u.test(name)) {
        throw new Error(`Identificador no válido: "${name}"`);
    }
    return `"${name}"`;
}

/** Resta meses a una fecha 'YYYY-MM-DD'. */
function restarMeses(fecha: string, meses: number): string {
    const d = new Date(`${fecha}T00:00:00Z`);
    d.setUTCMonth(d.getUTCMonth() - meses);
    return d.toISOString().split('T')[0];
}

export type ResultadoSync = {
    informeId: number;
    titulo: string;
    /** Eventos nuevos creados. */
    creados: number;
    /** Eventos de etapa Impacto ya existentes que se vincularon al informe. */
    adoptados: number;
    /** Eventos vinculados cuya fecha se corrigió. */
    actualizados: number;
    /** Eventos borrados porque su registro dejó de estar alcanzado. */
    eliminados: number;
    /** Situaciones que requieren mirada humana (no bloquean la sincronización). */
    avisos: string[];
};

/** Destino de un informe según el tipo de su grupo. */
async function resolverDestino(grupoId: number): Promise<Destino | null> {
    let rows: any[];
    try {
        ({ rows } = await query('select tipo from grupo where id = $1', [grupoId]));
    } catch (e: any) {
        throw new Error(`No se pudo leer el grupo ${grupoId}: ${e?.message ?? e}`);
    }
    const data = rows[0];
    if (!data) return null;
    if (Number(data.tipo) === 1) return DESTINO_BECAS;
    if (Number(data.tipo) === 2) return DESTINO_PROYECTOS;
    return null;
}

/**
 * Deja los eventos de etapa Impacto de un informe exactamente iguales a lo que
 * el informe declara. Devuelve null si el informe ya no existe (el CASCADE de
 * la BD se encargó de sus eventos).
 */
export async function sincronizarInformeImpacto(
    informeId: number,
): Promise<{ resultado: ResultadoSync; destino: Destino; afectados: number[] } | null> {
    let informeRows: any[];
    try {
        ({ rows: informeRows } = await query(
            `select id, grupo_id, linea_id, titulo, fecha_inicio::text as fecha_inicio
               from informe_impacto where id = $1`,
            [informeId],
        ));
    } catch (e: any) {
        throw new Error(`No se pudo leer el informe ${informeId}: ${e?.message ?? e}`);
    }
    if (!informeRows[0]) return null;

    const inf: Informe = {
        id: Number(informeRows[0].id),
        grupo_id: Number(informeRows[0].grupo_id),
        linea_id: informeRows[0].linea_id === null ? null : Number(informeRows[0].linea_id),
        titulo: informeRows[0].titulo ?? null,
        fecha_inicio: informeRows[0].fecha_inicio ?? null,
    };
    const resultado: ResultadoSync = {
        informeId: inf.id,
        titulo: inf.titulo || `Informe ${inf.id}`,
        creados: 0,
        adoptados: 0,
        actualizados: 0,
        eliminados: 0,
        avisos: [],
    };

    const destino = await resolverDestino(inf.grupo_id);
    if (!destino) {
        resultado.avisos.push(
            `El grupo ${inf.grupo_id} no es de proyectos ni de becas: el informe no proyecta ninguna etapa.`,
        );
        return { resultado, destino: DESTINO_PROYECTOS, afectados: [] };
    }

    // Sin fecha de inicio no hay etapa Impacto que proyectar.
    if (!inf.fecha_inicio) {
        resultado.avisos.push('El informe no tiene fecha de inicio: no se generó ningún evento.');
        return { resultado, destino, afectados: [] };
    }
    const fechaInicio = inf.fecha_inicio;

    const tAvance = ident(destino.tablaAvance);
    const fk = ident(destino.fk);

    // ── Alcance ──────────────────────────────────────────────────────────────
    let entidades: any[];
    try {
        const params: unknown[] = [inf.grupo_id];
        let sql = `select id, linea_id from ${ident(destino.tablaEntidad)} where grupo_id = $1`;
        if (inf.linea_id !== null && inf.linea_id !== undefined) {
            params.push(inf.linea_id);
            sql += ' and linea_id = $2';
        }
        ({ rows: entidades } = await query(sql, params));
    } catch (e: any) {
        throw new Error(`No se pudieron leer los ${destino.etiqueta}s del grupo: ${e?.message ?? e}`);
    }

    const alcanzados = entidades.map((e: any) => Number(e.id));
    const lineaDe = new Map<number, number | null>(
        entidades.map((e: any) => [Number(e.id), e.linea_id === null ? null : Number(e.linea_id)]),
    );
    const afectados = new Set<number>();

    if (alcanzados.length === 0) {
        resultado.avisos.push(
            inf.linea_id !== null
                ? `Ningún ${destino.etiqueta} en el grupo ${inf.grupo_id} con línea ${inf.linea_id}.`
                : `Ningún ${destino.etiqueta} en el grupo ${inf.grupo_id}: el informe no se ve en ninguna línea de tiempo.`,
        );
        return { resultado, destino, afectados: [] };
    }

    // ── 1. Eventos ya vinculados a este informe ──────────────────────────────
    let vinculados: any[];
    try {
        ({ rows: vinculados } = await query(
            `select id, ${fk}, fecha::text as fecha from ${tAvance} where informe_impacto_id = $1`,
            [inf.id],
        ));
    } catch (e: any) {
        throw new Error(`No se pudieron leer los eventos del informe: ${e?.message ?? e}`);
    }

    const idEntidad = (a: any) => Number(a[destino.fk]);
    const yaVinculados = new Set(vinculados.map(idEntidad));

    // ── Candidatos ───────────────────────────────────────────────────────────
    // Un grupo puede tener VARIOS informes, y cada registro pertenece a UNO
    // solo: el primero (por fecha de inicio) que ya lo alcanza. Se decide igual
    // desde cualquier informe que se sincronice, así que el resultado no depende
    // del orden en que se procesen.
    let hermanosRaw: any[];
    try {
        ({ rows: hermanosRaw } = await query(
            `select id, linea_id, fecha_inicio::text as fecha_inicio
               from informe_impacto where grupo_id = $1`,
            [inf.grupo_id],
        ));
    } catch (e: any) {
        throw new Error(`No se pudieron leer los informes del grupo: ${e?.message ?? e}`);
    }
    const hermanos = hermanosRaw
        .filter((h) => h.fecha_inicio)
        .sort((a, b) =>
            a.fecha_inicio === b.fecha_inicio
                ? Number(a.id) - Number(b.id)
                : a.fecha_inicio < b.fecha_inicio ? -1 : 1,
        );

    // Fecha de cierre de cada registro (primer evento de Ejecutado en su
    // bitácora). Es la referencia real: la etapa guardada puede estar desfasada.
    const cierreDe = new Map<number, string>();
    if (destino.mesesDesdeCierre !== null) {
        let cierres: any[];
        try {
            ({ rows: cierres } = await query(
                `select ${fk}, fecha::text as fecha from ${tAvance}
                  where ${fk} = any($1::int[]) and etapa_id = $2`,
                [alcanzados, destino.etapaCierre],
            ));
        } catch (e: any) {
            throw new Error(`No se pudieron leer los cierres: ${e?.message ?? e}`);
        }
        for (const c of cierres) {
            const eid = idEntidad(c);
            const actual = cierreDe.get(eid);
            if (!actual || c.fecha < actual) cierreDe.set(eid, c.fecha);
        }
    }

    /**
     * Informe al que pertenece un registro: el primero del grupo que cubre su
     * línea y para el que, a su fecha de inicio, ya cumplía la antigüedad de
     * cierre exigida. `null` = todavía no le toca ningún informe.
     */
    const informeDe = (eid: number) => {
        const linea = lineaDe.get(eid);
        const cierre = cierreDe.get(eid);
        for (const h of hermanos) {
            if (h.linea_id !== null && Number(h.linea_id) !== Number(linea)) continue;
            if (destino.mesesDesdeCierre !== null) {
                if (!cierre) continue;
                if (cierre > restarMeses(h.fecha_inicio, destino.mesesDesdeCierre)) continue;
            }
            return h;
        }
        return null;
    };

    const candidatos: number[] = [];
    let deOtroInforme = 0;
    let sinCumplir = 0;
    for (const id of alcanzados) {
        const duenho = informeDe(id);
        if (!duenho) sinCumplir++;
        else if (Number(duenho.id) === Number(inf.id)) candidatos.push(id);
        else deOtroInforme++;
    }

    if (sinCumplir > 0) {
        resultado.avisos.push(
            destino.mesesDesdeCierre !== null
                ? `${sinCumplir} ${destino.etiqueta}(s) del grupo aún no cumplen ${destino.mesesDesdeCierre} mes(es) desde su cierre (o no lo tienen registrado): entrarán al reconciliar cuando corresponda.`
                : `${sinCumplir} ${destino.etiqueta}(s) del grupo no están cubiertos por ningún informe.`,
        );
    }
    if (deOtroInforme > 0) {
        resultado.avisos.push(
            `${deOtroInforme} ${destino.etiqueta}(s) del grupo pertenecen a otro informe anterior del mismo grupo.`,
        );
    }

    // ── Fecha del evento, por registro ───────────────────────────────────────
    // La etapa se deriva del evento MÁS RECIENTE, así que el evento de Impacto
    // no puede quedar por detrás de un avance posterior del mismo registro: lo
    // dejaría en la etapa vieja. Cuando lo hay, el evento se ancla en esa fecha
    // y se avisa, porque es una contradicción entre el informe y la bitácora.
    const fechaPorEntidad = new Map<number, string>();
    {
        let posteriores: any[];
        try {
            ({ rows: posteriores } = await query(
                `select ${fk}, fecha::text as fecha from ${tAvance}
                  where ${fk} = any($1::int[]) and etapa_id <> $2 and fecha > $3::date`,
                [candidatos, ETAPA_IMPACTO, fechaInicio],
            ));
        } catch (e: any) {
            throw new Error(`No se pudieron leer los avances posteriores: ${e?.message ?? e}`);
        }

        const ultimoPosterior = new Map<number, string>();
        for (const a of posteriores) {
            const eid = idEntidad(a);
            const actual = ultimoPosterior.get(eid);
            if (!actual || a.fecha > actual) ultimoPosterior.set(eid, a.fecha);
        }
        for (const eid of candidatos) {
            fechaPorEntidad.set(eid, ultimoPosterior.get(eid) ?? fechaInicio);
        }
    }
    const fechaDe = (eid: number) => fechaPorEntidad.get(eid) ?? fechaInicio;

    // ── Elegibles: los que ya entraron al impacto DE VERDAD ──────────────────
    // Si el anclaje deja el evento en el futuro es porque la bitácora todavía
    // proyecta el cierre (p. ej. un "Ejecutado" fechado en 2027). Ese registro
    // no ha terminado, por más que su etapa guardada diga lo contrario: crear el
    // evento no lo movería a Impacto (recalculate* ignora fechas futuras) y sí
    // ensuciaría la bitácora. Entra solo cuando llegue esa fecha.
    const hoy = new Date().toISOString().split('T')[0];
    const elegibles = candidatos.filter((id) => fechaDe(id) <= hoy);
    const elegiblesSet = new Set(elegibles);
    elegibles.forEach((id) => afectados.add(id));

    const proyectados = candidatos.length - elegibles.length;
    if (proyectados > 0) {
        resultado.avisos.push(
            `${proyectados} ${destino.etiqueta}(s) tienen su cierre proyectado a futuro en la bitácora: quedan fuera del impacto hasta que llegue esa fecha.`,
        );
    }

    const anclados = elegibles.filter((id) => fechaDe(id) !== fechaInicio).length;
    if (anclados > 0) {
        resultado.avisos.push(
            `${anclados} ${destino.etiqueta}(s) tienen un avance posterior al inicio del informe (${fechaInicio}); su evento de Impacto se ancló en esa fecha para que la etapa quede correcta.`,
        );
    }

    // ── 2. Eventos que sobran ────────────────────────────────────────────────
    // Su registro salió del alcance (cambió el grupo o la línea del informe) o
    // dejó de ser elegible (su cierre volvió a estar proyectado a futuro). La
    // regla se autocorrige: lo que no debe estar, se borra.
    const sobrantes = vinculados.filter((a: any) => !elegiblesSet.has(idEntidad(a)));
    if (sobrantes.length > 0) {
        try {
            await query(`delete from ${tAvance} where id = any($1::bigint[])`, [
                sobrantes.map((a: any) => Number(a.id)),
            ]);
        } catch (e: any) {
            throw new Error(`No se pudieron borrar los eventos sobrantes: ${e?.message ?? e}`);
        }
        resultado.eliminados = sobrantes.length;
        sobrantes.forEach((a: any) => afectados.add(idEntidad(a)));
    }

    // ── 3. Corregir la fecha de los vigentes ─────────────────────────────────
    const vigentes = vinculados.filter((a: any) => elegiblesSet.has(idEntidad(a)));
    const desfasados = vigentes.filter((a: any) => a.fecha !== fechaDe(idEntidad(a)));
    if (desfasados.length > 0) {
        const porFecha = new Map<string, number[]>();
        for (const a of desfasados) {
            const f = fechaDe(idEntidad(a));
            if (!porFecha.has(f)) porFecha.set(f, []);
            porFecha.get(f)!.push(Number(a.id));
        }
        for (const [fecha, ids] of porFecha) {
            try {
                await query(`update ${tAvance} set fecha = $1::date where id = any($2::bigint[])`, [
                    fecha,
                    ids,
                ]);
            } catch (e: any) {
                throw new Error(`No se pudo corregir la fecha de los eventos: ${e?.message ?? e}`);
            }
        }
        resultado.actualizados = desfasados.length;
    }

    // ── 4. Elegibles que todavía no tienen su evento ─────────────────────────
    const faltantes = elegibles.filter((id) => !yaVinculados.has(id));
    if (faltantes.length === 0) return { resultado, destino, afectados: [...afectados] };

    // Eventos de etapa Impacto cargados a mano: se adoptan en lugar de crear un
    // duplicado, y se les corrige la fecha.
    let huerfanos: any[];
    try {
        ({ rows: huerfanos } = await query(
            `select id, ${fk}, fecha::text as fecha, sustento from ${tAvance}
              where ${fk} = any($1::int[]) and etapa_id = $2 and informe_impacto_id is null
              order by fecha asc`,
            [faltantes, ETAPA_IMPACTO],
        ));
    } catch (e: any) {
        throw new Error(`No se pudieron leer los eventos de impacto existentes: ${e?.message ?? e}`);
    }

    const adoptables = new Map<number, any>();
    for (const h of huerfanos) {
        const eid = idEntidad(h);
        if (adoptables.has(eid)) {
            // Más de un evento de Impacto para el mismo registro: se adopta el
            // más antiguo y el resto queda como estaba, para revisión manual.
            resultado.avisos.push(
                `El ${destino.etiqueta} ${eid} tiene más de un evento de etapa Impacto; se vinculó el más antiguo (${adoptables.get(eid).fecha}) y quedó suelto el del ${h.fecha}.`,
            );
            continue;
        }
        adoptables.set(eid, h);
    }

    const sustentoAuto = `Informe de impacto: ${resultado.titulo}`;

    for (const [eid, h] of adoptables) {
        const sinSustento = !h.sustento || String(h.sustento).trim() === '';
        try {
            if (sinSustento) {
                await query(
                    `update ${tAvance} set informe_impacto_id = $1, fecha = $2::date, sustento = $3 where id = $4`,
                    [inf.id, fechaDe(eid), sustentoAuto, Number(h.id)],
                );
            } else {
                await query(
                    `update ${tAvance} set informe_impacto_id = $1, fecha = $2::date where id = $3`,
                    [inf.id, fechaDe(eid), Number(h.id)],
                );
            }
        } catch (e: any) {
            throw new Error(`No se pudo vincular el evento del ${destino.etiqueta} ${eid}: ${e?.message ?? e}`);
        }
        resultado.adoptados++;
    }

    const porCrear = faltantes.filter((id) => !adoptables.has(id));
    if (porCrear.length > 0) {
        // Un solo INSERT multi-fila: (fk, etapa_id, fecha, sustento, monto, informe_impacto_id).
        const values: unknown[] = [];
        const tuplas = porCrear.map((eid) => {
            const base = values.length;
            values.push(eid, ETAPA_IMPACTO, fechaDe(eid), sustentoAuto, 0, inf.id);
            return `($${base + 1}, $${base + 2}, $${base + 3}::date, $${base + 4}, $${base + 5}, $${base + 6})`;
        });
        try {
            await query(
                `insert into ${tAvance} (${fk}, etapa_id, fecha, sustento, monto, informe_impacto_id)
                 values ${tuplas.join(', ')}`,
                values,
            );
        } catch (e: any) {
            throw new Error(`No se pudieron crear los eventos de impacto: ${e?.message ?? e}`);
        }
        resultado.creados = porCrear.length;
    }

    return { resultado, destino, afectados: [...afectados] };
}

/**
 * Sincroniza un informe y recalcula la etapa de lo que tocó.
 * Es el punto de entrada normal desde el CRUD de Catálogos.
 */
export async function sincronizarYRecalcular(informeId: number): Promise<ResultadoSync | null> {
    const salida = await sincronizarInformeImpacto(informeId);
    if (!salida) return null;
    await salida.destino.recalcular(salida.afectados);
    return salida.resultado;
}

/**
 * Registros alcanzados por un informe ANTES de borrarlo, con su destino. Hay que
 * capturarlos antes porque el ON DELETE CASCADE se lleva los eventos y después
 * ya no queda rastro de a quién había que recalcular.
 */
export async function afectadosDeInforme(
    informeId: number,
): Promise<{ destino: Destino; ids: number[] } | null> {
    const { rows: infRows } = await query('select grupo_id from informe_impacto where id = $1', [
        informeId,
    ]);
    const inf = infRows[0];
    if (!inf) return null;

    const destino = await resolverDestino(Number(inf.grupo_id));
    if (!destino) return null;

    const { rows } = await query(
        `select ${ident(destino.fk)} from ${ident(destino.tablaAvance)} where informe_impacto_id = $1`,
        [informeId],
    );
    const ids = Array.from(new Set(rows.map((a: any) => Number(a[destino.fk]))));
    return { destino, ids };
}

/**
 * Pasa por todos los informes registrados. Sirve para la carga inicial (los
 * informes que ya existían antes de esta sincronización) y como red de
 * seguridad si alguien edita la tabla por fuera del módulo Catálogos.
 */
export async function reconciliarTodosLosInformes(): Promise<ResultadoSync[]> {
    let informes: any[];
    try {
        ({ rows: informes } = await query('select id from informe_impacto order by id asc'));
    } catch (e: any) {
        throw new Error(`No se pudieron listar los informes: ${e?.message ?? e}`);
    }

    const resultados: ResultadoSync[] = [];
    // Un recálculo por destino, al final: así una beca tocada por dos informes
    // se recalcula una sola vez.
    const porDestino = new Map<Destino, Set<number>>();

    for (const inf of informes) {
        const salida = await sincronizarInformeImpacto(Number(inf.id));
        if (!salida) continue;
        resultados.push(salida.resultado);
        if (salida.afectados.length === 0) continue;
        if (!porDestino.has(salida.destino)) porDestino.set(salida.destino, new Set());
        salida.afectados.forEach((id) => porDestino.get(salida.destino)!.add(id));
    }

    for (const [destino, ids] of porDestino) {
        await destino.recalcular([...ids]);
    }
    return resultados;
}
