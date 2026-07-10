# Actualiza los datos de fondo2 desde Supabase (sistema-activa-t).
# Refresca SOLO las tablas de negocio del esquema public; NO toca las tablas
# de Better-Auth ("user", "session", "account", "verification", usuarios_modulos).
#
# Uso:
#   .\actualizar_desde_supabase.ps1                          # saca dump nuevo de Supabase y restaura
#   .\actualizar_desde_supabase.ps1 -Dump archivo.dump       # reusa un dump ya descargado
param(
    [string]$Dump = ""
)
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$FECHA = Get-Date -Format "yyyy-MM-dd_HHmm"

# Tablas de negocio (segun scripts/schema.sql)
$TABLAS = @(
  "aportantes_anual","aportes","avance_beca","avance_proyecto","avances",
  "becas_nueva","condicion","documentos_gerenciales","ejes","empresas",
  "especialistas","etapas","finanzas_anual","formato","grupo","institucion",
  "instituciones","instituciones_ejecutoras","lineas","logs_actualizacion",
  "metricas","modalidades","naturaleza_ie","pagos_gestoras",
  "presupuesto_anual_comparativo","presupuesto_mensual","programa_proyecto",
  "proyectos","regiones","sectores_ciiu","tipo_estudio","unidades_operativas"
)

# 0) verificar que el servicio db este corriendo
$up = docker compose ps --services --status running
if ($up -notcontains "db") { throw "El servicio 'db' de fondo2 no esta corriendo. Ejecuta: docker compose up -d" }

# 1) dump de Supabase
if (-not $Dump) {
    $Dump = "supabase_$FECHA.dump"
    Write-Host "1/6 Descargando dump de Supabase -> $Dump" -ForegroundColor Cyan
    docker run --rm -v "${PWD}:/data" -e PGPASSWORD='DbBackupActiva2026' postgres:17-alpine `
      pg_dump -h aws-1-us-east-1.pooler.supabase.com -p 6543 `
      -U postgres.zhtujzuuwecnqdecazam -d postgres -F c -f /data/$Dump
    if ($LASTEXITCODE -ne 0) { throw "Fallo el pg_dump de Supabase" }
} else {
    if (-not (Test-Path $Dump)) { throw "No existe el archivo $Dump" }
    Write-Host "1/6 Usando dump existente: $Dump" -ForegroundColor Cyan
}

# 2) backup local de seguridad
$BK = "backup_fondo2_local_$FECHA.dump"
Write-Host "2/6 Backup local de seguridad -> $BK" -ForegroundColor Cyan
docker compose exec -T db pg_dump -U fondo2 -d fondo2 -F c -f /tmp/$BK
if ($LASTEXITCODE -ne 0) { throw "Fallo el backup local" }
docker compose cp db:/tmp/$BK ./$BK

# 3) copiar dump al contenedor y ver que tablas trae
Write-Host "3/6 Analizando el dump..." -ForegroundColor Cyan
docker compose cp ./$Dump db:/tmp/restore.dump
$toc = docker compose exec -T db pg_restore -l /tmp/restore.dump
$enDump = $toc | Select-String 'TABLE DATA public (\S+)' | ForEach-Object { $_.Matches[0].Groups[1].Value }
$objetivo  = @($TABLAS | Where-Object { $enDump -contains $_ })
$faltantes = @($TABLAS | Where-Object { $enDump -notcontains $_ })
if ($objetivo.Count -eq 0) { throw "El dump no contiene ninguna tabla de negocio esperada" }
Write-Host ("   Tablas a refrescar: {0} de {1}" -f $objetivo.Count, $TABLAS.Count)
if ($faltantes.Count -gt 0) {
    Write-Host ("   NO estan en el dump (se dejan intactas): {0}" -f ($faltantes -join ", ")) -ForegroundColor Yellow
}

# 4) truncate + restore solo-datos
Write-Host "4/6 Reemplazando datos..." -ForegroundColor Cyan
$lista = ($objetivo | ForEach-Object { '"{0}"' -f $_ }) -join ", "
docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 -c "TRUNCATE TABLE $lista CASCADE;"
if ($LASTEXITCODE -ne 0) { throw "Fallo el TRUNCATE" }
$tArgs = @(); foreach ($t in $objetivo) { $tArgs += @("-t", $t) }
docker compose exec -T db pg_restore -U fondo2 -d fondo2 --data-only --disable-triggers --no-owner -n public @tArgs /tmp/restore.dump
if ($LASTEXITCODE -ne 0) {
    Write-Host "   pg_restore reporto advertencias; revisa la salida de arriba. Tu backup es $BK" -ForegroundColor Yellow
}

# 5) recalcular secuencias
Write-Host "5/6 Ajustando secuencias..." -ForegroundColor Cyan
Get-Content scripts\fix_sequences.sql -Raw | docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1

# 6) resumen y reinicio de la app (limpia el cache de catalogos)
Write-Host "6/6 Resumen de filas por tabla:" -ForegroundColor Cyan
docker compose exec -T db psql -U fondo2 -d fondo2 -c "ANALYZE;" | Out-Null
docker compose exec -T db psql -U fondo2 -d fondo2 -c "SELECT relname AS tabla, n_live_tup AS filas FROM pg_stat_user_tables WHERE schemaname='public' ORDER BY relname;"
docker compose exec -T db rm -f /tmp/restore.dump
docker compose restart app
Write-Host "Listo. Dump usado: $Dump | Backup previo local: $BK" -ForegroundColor Green
