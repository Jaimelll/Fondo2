#!/usr/bin/env bash
# Baja del servidor Hetzner (activa-t-servidor) un pg_dump de fondo2 + los PDFs
# de storage/documentos, en UNA sola conexion SSH (pide la contrasena una vez).
# Uso (desde la carpeta fondo2, en Git Bash):  bash bajar_del_servidor.sh
set -euo pipefail
cd "$(dirname "$0")"
FECHA=$(date +%F_%H%M)
SALIDA="servidor_$FECHA.tar"

echo "Conectando a activa-t-servidor (te pedira la contrasena de 'pruebas')..."
ssh activa-t-servidor 'bash -s' > "$SALIDA" <<'REMOTO'
set -euo pipefail
DOCKER=docker
docker ps >/dev/null 2>&1 || DOCKER="sudo -n docker"
C=$($DOCKER ps --format '{{.Names}}' | grep -E 'fondo2.*db' | head -1)
[ -n "$C" ] || { echo "No encontre el contenedor db de fondo2" >&2; exit 1; }
DIR=$($DOCKER inspect -f '{{index .Config.Labels "com.docker.compose.project.working_dir"}}' "$C")
echo "Contenedor: $C  Carpeta: $DIR" >&2
T=$(mktemp -d)
$DOCKER exec "$C" pg_dump -U fondo2 -d fondo2 -F c -f /tmp/fondo2_servidor.dump
$DOCKER cp "$C:/tmp/fondo2_servidor.dump" "$T/fondo2_servidor.dump"
$DOCKER exec "$C" rm -f /tmp/fondo2_servidor.dump
if [ -d "$DIR/storage/documentos" ]; then
  tar -cf - -C "$T" fondo2_servidor.dump -C "$DIR" storage/documentos
else
  tar -cf - -C "$T" fondo2_servidor.dump
fi
rm -rf "$T"
REMOTO

echo "Descargado: $SALIDA ($(du -h "$SALIDA" | cut -f1))"
tar -tf "$SALIDA" | head -5
