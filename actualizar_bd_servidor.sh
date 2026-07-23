#!/usr/bin/env bash
# Actualiza los datos de fondo2 en el SERVIDOR a partir de un dump de Supabase.
# Ejecutar dentro de la carpeta de fondo2 (donde esta docker-compose.yml):
#   ./actualizar_bd_servidor.sh supabase_YYYY-MM-DD_HHMM.dump
# Refresca SOLO las tablas de negocio; NO toca las tablas de Better-Auth.
set -euo pipefail

DUMP="${1:?Uso: $0 <archivo.dump>}"
FECHA=$(date +%F_%H%M)

TABLAS=(
  aportantes_anual aportes auditoria_eeff_historico avance_beca
  avance_proyecto avances becas_nueva condicion
  documentos_gerenciales ejes empresas especialistas etapas
  finanzas_anual formato grupo informe_impacto institucion
  instituciones instituciones_ejecutoras lineas logs_actualizacion
  metricas modalidades naturaleza_ie pagos_gestoras
  presupuesto_anual_comparativo presupuesto_mensual programa_proyecto
  proyectos regiones saldo_bancario sectores_ciiu tipo_estudio
  unidades_operativas
)

echo "1/5 Backup local de seguridad..."
BK="backup_fondo2_servidor_$FECHA.dump"
docker compose exec -T db pg_dump -U fondo2 -d fondo2 -F c -f "/tmp/$BK"
docker compose cp "db:/tmp/$BK" "./$BK"

echo "2/5 Analizando el dump..."
docker compose cp "$DUMP" db:/tmp/restore.dump
mapfile -t EN_DUMP < <(docker compose exec -T db pg_restore -l /tmp/restore.dump | sed -n 's/.*TABLE DATA public \([^ ]*\).*/\1/p')
OBJ=()
for t in "${TABLAS[@]}"; do
  for d in "${EN_DUMP[@]}"; do [[ "$t" == "$d" ]] && OBJ+=("$t") && break; done
done
[[ ${#OBJ[@]} -gt 0 ]] || { echo "El dump no contiene tablas de negocio"; exit 1; }
echo "   Tablas a refrescar: ${#OBJ[@]} de ${#TABLAS[@]}"

echo "3/5 Reemplazando datos..."
LISTA=$(printf '"%s", ' "${OBJ[@]}"); LISTA=${LISTA%, }
docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 -c "TRUNCATE TABLE $LISTA CASCADE;"
TARGS=(); for t in "${OBJ[@]}"; do TARGS+=(-t "$t"); done
docker compose exec -T db pg_restore -U fondo2 -d fondo2 --data-only --disable-triggers --no-owner -n public "${TARGS[@]}" /tmp/restore.dump \
  || echo "   pg_restore reporto advertencias; revisar salida. Backup: $BK"

echo "4/5 Ajustando secuencias..."
docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/fix_sequences.sql

echo "5/5 Resumen:"
docker compose exec -T db psql -U fondo2 -d fondo2 -c "ANALYZE;" >/dev/null
docker compose exec -T db psql -U fondo2 -d fondo2 -c "SELECT relname AS tabla, n_live_tup AS filas FROM pg_stat_user_tables WHERE schemaname='public' ORDER BY relname;"
docker compose exec -T db rm -f /tmp/restore.dump
docker compose restart app
echo "Listo. Backup previo: $BK"
