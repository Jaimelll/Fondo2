#!/usr/bin/env bash
# Importa en el SERVIDOR los usuarios exportados de Supabase.
# Antes copia el CSV desde tu PC:  scp usuarios_supabase.csv pruebas@servidor:/apps/fondo2/
# Uso:  ./migrar_usuarios_servidor.sh
set -euo pipefail
CSV="${1:-usuarios_supabase.csv}"
[[ -f "$CSV" ]] || { echo "No existe $CSV. Copialo con scp desde tu PC."; exit 1; }
docker compose cp "$CSV" db:/tmp/usuarios_supabase.csv
docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/importar_usuarios.sql
echo "Listo. OJO: $CSV contiene hashes de contrasenas; borralo cuando termines (rm $CSV)."
