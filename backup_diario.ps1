$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
. "$PSScriptRoot\scripts\supabase_env.ps1"   # credenciales desde .env, no en el repo

$FECHA = Get-Date -Format "yyyy-MM-dd_HHmm"
$NOMBRE_ARCHIVO = "backup_activa_t_$FECHA.dump"

Write-Host "🚀 Iniciando respaldo de Supabase..." -ForegroundColor Cyan

# Ejecuta el backup usando volúmenes de Docker para evitar corrupción de PowerShell
docker run --rm -v "${PWD}:/data" -e PGPASSWORD=$SB_PASSWORD postgres:17-alpine `
  pg_dump -h $SB_HOST -p $SB_PORT `
  -U $SB_USER -d postgres -F c -f /data/$NOMBRE_ARCHIVO

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ ¡Éxito! Backup guardado como: $NOMBRE_ARCHIVO" -ForegroundColor Green
} else {
    Write-Host "❌ Error: No se pudo realizar el respaldo." -ForegroundColor Red
}