#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Descarga al disco local los PDFs que la base todavía referencia en Supabase
# Storage (buckets documentos_gerenciales e informes_impacto).
#
# Se guía por la BASE, no por el bucket: así no arrastra archivos huérfanos de
# reemplazos anteriores (el bucket tiene más objetos que filas).
#
# Uso (desde la carpeta del proyecto, con el compose levantado):
#   bash scripts/migrar_pdfs_supabase.sh
#
# Deja los archivos en storage/documentos con su nombre original y un
# inventario CSV con tamaño y sha256 para poder verificar después.
# NO toca la base: la reescritura de URLs va aparte, en
# scripts/reescribir_urls_locales.sql, y debe correrse DESPUÉS de esto.
#
# Idempotente: los archivos ya descargados se saltan.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

cd "$(dirname "$0")/.."
DEST="${STORAGE_DOCUMENTS_PATH:-./storage/documentos}"
INV="inventario_pdfs_$(date +%F_%H%M).csv"

# Decodifica %20 y compañía: el nombre en disco debe ser el del objeto, no el
# de la URL. La ruta /api/documentos/[archivo] hace decodeURIComponent.
urldecode() { local d="${1//+/ }"; printf '%b' "${d//%/\\x}"; }

mkdir -p "$DEST"

# La carpeta la crea el contenedor, que corre como uid 1001 (nextjs): el usuario
# del host no suele poder escribir en ella. Mejor avisar aquí que fallar 21 veces.
if ! touch "$DEST/.prueba_escritura" 2>/dev/null; then
    cat >&2 <<AYUDA
Sin permiso de escritura en $DEST (pertenece al uid 1001 del contenedor).
Corre el script como root y devuélvele el dueño al terminar:

  su -c 'cd $(pwd) && bash scripts/migrar_pdfs_supabase.sh && chown -R 1001:1001 $DEST'
AYUDA
    exit 1
fi
rm -f "$DEST/.prueba_escritura"

echo 'tabla,id,archivo,bytes,sha256,url_origen' > "$INV"

total=0; bajados=0; existentes=0; fallos=0

while IFS='|' read -r tabla id url; do
    [ -z "${url:-}" ] && continue
    total=$((total + 1))
    nombre="$(urldecode "${url##*/}")"
    destino="$DEST/$nombre"

    if [ -s "$destino" ]; then
        echo "  = ya estaba: $nombre"
        existentes=$((existentes + 1))
    elif curl -fsSL "$url" -o "$destino"; then
        echo "  + $nombre"
        bajados=$((bajados + 1))
    else
        echo "  ! FALLO $tabla#$id -> $url" >&2
        rm -f "$destino"
        fallos=$((fallos + 1))
        continue
    fi

    printf '%s,%s,"%s",%s,%s,%s\n' \
        "$tabla" "$id" "$nombre" \
        "$(stat -c%s "$destino")" \
        "$(sha256sum "$destino" | cut -d' ' -f1)" \
        "$url" >> "$INV"
done < <(docker compose exec -T db psql -U fondo2 -d fondo2 -tA -c "
    select 'documentos_gerenciales', id::text, url_pdf
      from documentos_gerenciales where url_pdf like '%supabase%'
    union all
    select 'informe_impacto', id::text, archivo_url
      from informe_impacto where archivo_url like '%supabase%'
    order by 1, 2;")

echo
echo "Referenciados: $total | descargados: $bajados | ya estaban: $existentes | fallos: $fallos"
echo "Inventario: $INV"

if [ "$fallos" -gt 0 ]; then
    echo "Hay descargas fallidas: NO corras la reescritura de URLs todavía." >&2
    exit 1
fi

echo
echo "Siguiente paso (reescribe las URLs a /api/documentos):"
echo "  docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/reescribir_urls_locales.sql"
