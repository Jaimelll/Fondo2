#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Archivo FRÍO de los 5 buckets de Supabase Storage, antes de apagar el
# proyecto. Es la única copia de los buckets de los módulos descontinuados
# (documentos_evaluacion, evidencias_supervision, proyectos_postulantes): el
# Storage NO viaja en el pg_dump y borrar el proyecto es irreversible.
#
# Distinto de migrar_pdfs_supabase.sh: ese baja SOLO lo que la base referencia
# y lo pone en producción; este baja TODO, incluidos los huérfanos, para
# guardarlo y olvidarse.
#
# Requiere en .env (ver .env.example):
#   SUPABASE_URL=https://xxxx.supabase.co
#   SUPABASE_SERVICE_ROLE_KEY=eyJ...        (hace falta para LISTAR el bucket)
#
# Uso:
#   bash scripts/archivar_buckets_supabase.sh [carpeta_destino]
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

cd "$(dirname "$0")/.."
DESTINO="${1:-./respaldo_supabase_$(date +%F)}"

leer_env() { sed -n "s/^[[:space:]]*$1[[:space:]]*=[[:space:]]*//p" .env | tail -1 | tr -d '"'\''' | tr -d '\r'; }
SB_URL="$(leer_env SUPABASE_URL)"
SB_KEY="$(leer_env SUPABASE_SERVICE_ROLE_KEY)"

if [ -z "$SB_URL" ] || [ -z "$SB_KEY" ]; then
    echo "Faltan SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY en .env (ver .env.example)." >&2
    exit 1
fi

# Se puede acotar para probar:  BUCKETS="informes_impacto" bash scripts/archivar_buckets_supabase.sh
BUCKETS="${BUCKETS:-documentos_gerenciales informes_impacto proyectos_postulantes documentos_evaluacion evidencias_supervision}"
INV="$DESTINO/inventario.csv"
mkdir -p "$DESTINO"
echo 'bucket,ruta,bytes,sha256' > "$INV"

total=0; fallos=0

# Lee por stdin la respuesta del listado y emite "F|nombre" (archivo) o
# "D|nombre" (carpeta: en Supabase se distinguen porque no traen id).
# El host del servidor no tiene node ni jq, así que probamos varios intérpretes
# y caemos a un contenedor si no hay ninguno.
json_entradas() {
    # Ojo: se comprueba que el intérprete FUNCIONE, no que exista. En Windows
    # "python3" es un alias de la Store que existe en el PATH y no ejecuta nada.
    if jq --version >/dev/null 2>&1; then
        jq -r '.[] | select(.name != ".emptyFolderPlaceholder") | (if .id then "F|" else "D|" end) + .name'
    elif python3 -c 'import json' >/dev/null 2>&1; then
        python3 -c 'import sys, json
try:
    datos = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for o in datos:
    n = o.get("name", "")
    if n and n != ".emptyFolderPlaceholder":
        print(("F|" if o.get("id") else "D|") + n)'
    else
        docker run --rm -i node:20-alpine node -e "
            let d='';process.stdin.on('data',c=>d+=c).on('end',()=>{
                let j=[];try{j=JSON.parse(d)}catch(e){process.exit(0)}
                for (const o of j) {
                    if (!o.name || o.name === '.emptyFolderPlaceholder') continue;
                    console.log((o.id ? 'F|' : 'D|') + o.name);
                }
            })"
    fi
}

# Lista un bucket (recursivo: evidencias_supervision guarda subcarpetas por uuid).
listar() {
    local bucket="$1" prefijo="$2"
    curl -sS -X POST "$SB_URL/storage/v1/object/list/$bucket" \
        -H "apikey: $SB_KEY" -H "Authorization: Bearer $SB_KEY" \
        -H 'Content-Type: application/json' \
        -d "{\"prefix\":\"$prefijo\",\"limit\":1000,\"sortBy\":{\"column\":\"name\",\"order\":\"asc\"}}" |
        json_entradas | sed "s#^\([FD]\)|#\1|$prefijo#"
}

descargar_bucket() {
    local bucket="$1" prefijo="${2:-}"
    while IFS='|' read -r tipo ruta; do
        [ -z "${ruta:-}" ] && continue
        if [ "$tipo" = 'D' ]; then
            descargar_bucket "$bucket" "$ruta/"
            continue
        fi
        local destino="$DESTINO/$bucket/$ruta"
        mkdir -p "$(dirname "$destino")"
        if [ -s "$destino" ]; then
            echo "  = $bucket/$ruta"
        elif curl -fsSL "$SB_URL/storage/v1/object/public/$bucket/$(printf '%s' "$ruta" | sed 's/ /%20/g')" -o "$destino"; then
            echo "  + $bucket/$ruta"
        else
            echo "  ! FALLO $bucket/$ruta" >&2
            rm -f "$destino"; fallos=$((fallos + 1)); continue
        fi
        total=$((total + 1))
        printf '%s,"%s",%s,%s\n' "$bucket" "$ruta" \
            "$(stat -c%s "$destino")" "$(sha256sum "$destino" | cut -d' ' -f1)" >> "$INV"
    done < <(listar "$bucket" "$prefijo")
}

for b in $BUCKETS; do
    echo "· $b"
    descargar_bucket "$b"
done

echo
echo "Archivos: $total | fallos: $fallos"
echo "Destino: $DESTINO ($(du -sh "$DESTINO" | cut -f1))"
echo "Inventario: $INV"
echo
echo "Comprime y sube una copia fuera del servidor ANTES de apagar Supabase:"
echo "  tar -czf ${DESTINO##*/}.tar.gz -C $(dirname "$DESTINO") ${DESTINO##*/}"
[ "$fallos" -eq 0 ] || exit 1
