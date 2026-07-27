#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Respaldo completo de fondo2: base de datos + PDFs.
#
# Los PDFs NO viajan en el pg_dump — viven en storage/documentos, que es un
# volumen del host. Respaldar solo la base deja los documentos sin copia.
#
# Uso (desde la carpeta del proyecto):
#   bash scripts/backup_fondo2.sh [carpeta_destino] [dias_retencion]
# Por defecto: ./backups y 30 días.
#
# Para dejarlo diario en el servidor (3:15 am), con crontab -e:
#   15 3 * * * cd /apps/fondo2 && bash scripts/backup_fondo2.sh >> backups/backup.log 2>&1
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

# Git Bash (Windows) reescribe las rutas /tmp que van dentro del contenedor.
# En Linux la variable simplemente se ignora.
export MSYS_NO_PATHCONV=1

cd "$(dirname "$0")/.."
DESTINO="${1:-./backups}"
RETENCION="${2:-30}"
FECHA="$(date +%F_%H%M)"
STORAGE="${STORAGE_DOCUMENTS_PATH:-./storage/documentos}"

mkdir -p "$DESTINO"

echo "1/3 Base de datos..."
docker compose exec -T db pg_dump -U fondo2 -d fondo2 -F c -f "/tmp/bd_$FECHA.dump"
docker compose cp "db:/tmp/bd_$FECHA.dump" "$DESTINO/fondo2_bd_$FECHA.dump"
docker compose exec -T db rm -f "/tmp/bd_$FECHA.dump"

echo "2/3 PDFs de storage..."
if [ -d "$STORAGE" ]; then
    tar -czf "$DESTINO/fondo2_storage_$FECHA.tar.gz" -C "$(dirname "$STORAGE")" "$(basename "$STORAGE")"
else
    echo "   (no existe $STORAGE; se omite)"
fi

echo "3/3 Limpiando copias de más de $RETENCION días..."
find "$DESTINO" -maxdepth 1 -name 'fondo2_*' -type f -mtime "+$RETENCION" -print -delete || true

echo
echo "Listo:"
ls -lh "$DESTINO" | grep "$FECHA" || true
echo
echo "Recuerda llevar una copia FUERA del servidor (OneDrive corporativo)."
