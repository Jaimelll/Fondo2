#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Saca un dump de la base de Supabase (sistema-activa-t, puerto 8081) para
# alimentar actualizar_bd_servidor.sh. Las credenciales salen de .env, no del
# historial de comandos.
#
# Uso (desde la carpeta del proyecto):
#   bash scripts/dump_supabase.sh
#
# Imprime el nombre del archivo generado, que es el que se le pasa después a:
#   bash actualizar_bd_servidor.sh <archivo.dump>
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

cd "$(dirname "$0")/.."
source scripts/supabase_env.sh

DUMP="supabase_$(date +%F_%H%M).dump"

echo "Descargando dump de Supabase -> $DUMP"
docker run --rm -v "$(pwd):/data" -e PGPASSWORD="$SB_PASSWORD" postgres:17-alpine \
    pg_dump -h "$SB_HOST" -p "$SB_PORT" -U "$SB_USER" -d postgres -F c -f "/data/$DUMP"

if [ ! -s "$DUMP" ]; then
    echo "El dump salió vacío: revisa las credenciales de .env" >&2
    exit 1
fi

echo
echo "Listo: $DUMP ($(du -h "$DUMP" | cut -f1))"
echo "Siguiente paso:"
echo "  bash actualizar_bd_servidor.sh $DUMP"
