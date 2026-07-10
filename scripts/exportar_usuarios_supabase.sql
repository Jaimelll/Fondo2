-- Exporta los usuarios de Supabase (auth.users) a CSV.
-- Lo ejecuta migrar_usuarios.ps1 dentro de un contenedor postgres con ${PWD} montado en /data.
\copy (SELECT u.id, lower(u.email) AS email, COALESCE(u.raw_user_meta_data->>'name', split_part(u.email,'@',1)) AS name, u.encrypted_password AS hash, u.created_at FROM auth.users u WHERE u.email IS NOT NULL AND u.deleted_at IS NULL) TO /data/usuarios_supabase.csv WITH CSV HEADER
