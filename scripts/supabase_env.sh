#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Carga las credenciales de Supabase desde .env (NO trackeado). Ver .env.example.
#
# Uso desde otro script:
#   source "$(dirname "$0")/supabase_env.sh"
#   # deja exportadas: SB_HOST, SB_PORT, SB_USER, SB_PASSWORD
# ─────────────────────────────────────────────────────────────────────────────

_env_file="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/.env"

if [ ! -f "$_env_file" ]; then
    echo "No existe $_env_file. Copia .env.example a .env y completa las variables SUPABASE_DB_*." >&2
    return 1 2>/dev/null || exit 1
fi

# Solo las claves que interesan, sin ejecutar el archivo.
_leer() { sed -n "s/^[[:space:]]*$1[[:space:]]*=[[:space:]]*//p" "$_env_file" | tail -1 | tr -d '"'\''' | tr -d '\r'; }

export SB_HOST="$(_leer SUPABASE_DB_HOST)"
export SB_PORT="$(_leer SUPABASE_DB_PORT)"
export SB_USER="$(_leer SUPABASE_DB_USER)"
export SB_PASSWORD="$(_leer SUPABASE_DB_PASSWORD)"
: "${SB_PORT:=6543}"

if [ -z "$SB_HOST" ] || [ -z "$SB_USER" ] || [ -z "$SB_PASSWORD" ]; then
    echo "Faltan SUPABASE_DB_HOST / SUPABASE_DB_USER / SUPABASE_DB_PASSWORD en $_env_file (ver .env.example)." >&2
    return 1 2>/dev/null || exit 1
fi
