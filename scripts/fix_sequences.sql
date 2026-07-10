-- Recalcula todas las secuencias del esquema public segun el MAX() actual
-- de su columna asociada. Se ejecuta despues de un restore data-only.
DO $$
DECLARE r record;
BEGIN
  FOR r IN
    SELECT s.seqrelid::regclass AS seq,
           d.refobjid::regclass AS tbl,
           a.attname            AS col
    FROM pg_sequence s
    JOIN pg_depend d   ON d.objid = s.seqrelid AND d.deptype IN ('a','i')
    JOIN pg_attribute a ON a.attrelid = d.refobjid AND a.attnum = d.refobjsubid
    JOIN pg_class c    ON c.oid = d.refobjid
    JOIN pg_namespace n ON n.oid = c.relnamespace AND n.nspname = 'public'
  LOOP
    EXECUTE format(
      'SELECT setval(%L, GREATEST(COALESCE((SELECT MAX(%I) FROM %s), 0), 1), COALESCE((SELECT MAX(%I) FROM %s), 0) > 0)',
      r.seq, r.col, r.tbl, r.col, r.tbl);
  END LOOP;
END $$;
