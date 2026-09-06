import { query } from "@/lib/db";
import { ARRASTRE_PREFIX } from "@/lib/pagos";

type Args = {
  tabla: 'avance_proyecto' | 'avance_beca';
  fk: 'proyecto_id' | 'beca_id';
  padreId: any;
  monto: number;
};

/**
 * Descuenta `monto` del evento de arrastre del proyecto / beca.
 *
 * Se usa cuando se registra una orden de pago que YA estaba incluida en el acumulado
 * migrado: el pago entra con su propio evento (trazable) y el arrastre baja en el
 * mismo importe, así el avance total no cambia. Cuando el arrastre llega a 0 queda
 * como testigo ("desglosado por completo").
 *
 * Devuelve el monto efectivamente descontado (puede ser menor si el arrastre no
 * alcanzaba) o 0 si no hay arrastre vigente.
 *
 * Porteado de sistema-activa-t/src/lib/arrastre-server.ts (allí recibe el cliente
 * de Supabase; aquí va directo a Postgres).
 */
export async function descontarDeArrastre({ tabla, fk, padreId, monto }: Args): Promise<number> {
  const aDescontar = Math.round((Number(monto) || 0) * 100) / 100;
  if (aDescontar <= 0) return 0;

  // `tabla` y `fk` vienen de una unión literal, no del usuario: es seguro interpolarlos.
  const { rows: filas } = await query<{ id: number; monto: string | number }>(
    `select id, monto from ${tabla}
      where ${fk} = $1 and sustento like $2 and monto > 0
      order by fecha asc, id asc`,
    [padreId, `${ARRASTRE_PREFIX}%`],
  );
  if (filas.length === 0) return 0;

  let restante = aDescontar;
  let descontado = 0;
  for (const fila of filas) {
    if (restante <= 0) break;
    const actual = Number(fila.monto) || 0;
    const quita = Math.min(actual, restante);
    const nuevo = Math.round((actual - quita) * 100) / 100;
    await query(`update ${tabla} set monto = $1 where id = $2`, [nuevo, fila.id]);
    restante = Math.round((restante - quita) * 100) / 100;
    descontado = Math.round((descontado + quita) * 100) / 100;
  }
  return descontado;
}
