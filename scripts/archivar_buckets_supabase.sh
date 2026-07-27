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

# Lista un bucket (recursivo: evidencias_supervision guarda subcarpetas por uuid).
listar() {
    local bucket="$1" prefijo="$2"
    curl -sS -X POST "$SB_URL/storage/v1/object/list/$bucket" \
        -H "apikey: $SB_KEY" -H "Authorization: Bearer $SB_KEY" \
        -H 'Content-Type: application/json' \
        -d "{\"prefix\":\"$prefijo\",\"limit\":1000,\"sortBy\":{\"column\":\"name\",\"order\":\"asc\"}}" |
        node -e "
            let d='';process.stdin.on('data',c=>d+=c).on('end',()=>{
                let j=[];try{j=JSON.parse(d)}catch(e){process.exit(0)}
                for (const o of j) {
                    if (o.name === '.emptyFolderPlaceholder') continue;
                    // sin id = carpeta
                    console.log((o.id ? 'F|' : 'D|') + '$prefijo' + o.name);
                }
            })"
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
