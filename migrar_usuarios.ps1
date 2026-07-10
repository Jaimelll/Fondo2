# Migra los usuarios de Supabase (sistema-activa-t) a fondo2 LOCAL,
# conservando contrasenas (hash bcrypt) y UUIDs.
# Uso:  .\migrar_usuarios.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "1/2 Exportando usuarios de Supabase..." -ForegroundColor Cyan
docker run --rm -v "${PWD}:/data" -e PGPASSWORD='DbBackupActiva2026' postgres:17-alpine `
  psql -h aws-1-us-east-1.pooler.supabase.com -p 6543 `
  -U postgres.zhtujzuuwecnqdecazam -d postgres `
  -v ON_ERROR_STOP=1 -f /data/scripts/exportar_usuarios_supabase.sql
if ($LASTEXITCODE -ne 0) { throw "Fallo la exportacion desde Supabase" }

Write-Host "2/2 Importando a fondo2 local..." -ForegroundColor Cyan
docker compose cp ./usuarios_supabase.csv db:/tmp/usuarios_supabase.csv
Get-Content scripts\importar_usuarios.sql -Raw | docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1
if ($LASTEXITCODE -ne 0) { throw "Fallo la importacion" }

Write-Host "Listo. Para el servidor: scp usuarios_supabase.csv y corre ./migrar_usuarios_servidor.sh" -ForegroundColor Green
Write-Host "OJO: usuarios_supabase.csv contiene hashes de contrasenas; borralo cuando termines." -ForegroundColor Yellow
