-- ─────────────────────────────────────────────────────────────────────────────
-- Apunta a /api/documentos las URLs que todavía referencian Supabase Storage.
-- Los archivos deben estar YA en storage/documentos (ver
-- scripts/migrar_pdfs_supabase.sh); si no, los enlaces quedan en 404.
--
-- El último segmento de la URL pública de Supabase ya viene percent-encoded
-- exactamente como lo necesita la ruta, así que basta con reemplazar el prefijo.
--
-- Uso:
--   docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/reescribir_urls_locales.sql
--
-- IDEMPOTENTE, y por eso lo llama actualizar_bd_servidor.sh al final: cada sync
-- desde Supabase restaura las URLs viejas, y esto las vuelve a dejar locales.
-- ─────────────────────────────────────────────────────────────────────────────

BEGIN;

UPDATE documentos_gerenciales
   SET url_pdf = '/api/documentos/' || split_part(url_pdf, '/object/public/documentos_gerenciales/', 2)
 WHERE url_pdf LIKE '%/object/public/documentos_gerenciales/%';

UPDATE informe_impacto
   SET archivo_url = '/api/documentos/' || split_part(archivo_url, '/object/public/informes_impacto/', 2)
 WHERE archivo_url LIKE '%/object/public/informes_impacto/%';

COMMIT;

\echo '--- URLs que siguen apuntando a Supabase (debe ser 0 en ambas):'
SELECT 'documentos_gerenciales' AS tabla, count(*) AS pendientes
  FROM documentos_gerenciales WHERE url_pdf LIKE '%supabase%'
UNION ALL
SELECT 'informe_impacto', count(*)
  FROM informe_impacto WHERE archivo_url LIKE '%supabase%';
