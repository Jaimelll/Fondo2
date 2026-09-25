# =============================================================================
# Baja los datos de fondo2 del SERVIDOR (62.238.115.215) a la copia LOCAL.
# La base del servidor es la oficial: esto solo cambia la base local.
#
# Uso (PowerShell de Windows, desde cualquier carpeta):
#   powershell -ExecutionPolicy Bypass -File <carpeta de fondo2>\scripts\bajar-del-servidor.ps1
#   ej.: powershell -ExecutionPolicy Bypass -File C:\trabajo\fondo2\scripts\bajar-del-servidor.ps1
#
# Opciones:
#   -Llave "C:\ruta\pruebas_nuevo_servidor_id_ed25519"   si la llave esta en otra carpeta
#   -Completo   reemplaza TODA la base local, incluidos usuarios y sesiones
#               (entras con la contrasena del servidor). Sin esta opcion se
#               refrescan solo las tablas de negocio y se conservan los usuarios,
#               permisos (usuarios_modulos) y sesiones locales.
#
# Funciona en cualquier laptop: la carpeta de fondo2 se toma de donde esta
# este script. Requisitos: Docker Desktop con fondo2 levantado y la llave SSH
# del servidor en <Escritorio>\.ssh\pruebas_nuevo_servidor_id_ed25519
#
# Pasos:
#   1. En el servidor saca un pg_dump de la base y lo empaqueta con los PDFs.
#   2. Lo descarga a <fondo2>\respaldos_locales\servidor_FECHA.tar
#   3. Respalda la base local en respaldos_locales\local_antes_FECHA.dump
#   4. Reemplaza los datos locales con los del servidor.
#   5. Copia los PDFs a storage\documentos y reinicia la app local.
# =============================================================================
param(
    [string]$Llave = (Join-Path ([Environment]::GetFolderPath('Desktop')) '.ssh\pruebas_nuevo_servidor_id_ed25519'),
    [string]$Servidor = 'pruebas@62.238.115.215',
    [string]$CarpetaServidor = '/home/pruebas/apps/fondo2',
    [switch]$Completo
)
$ErrorActionPreference = 'Continue'

$carpeta   = Split-Path -Parent $PSScriptRoot   # carpeta de fondo2 (la que contiene scripts\)
$respaldos = Join-Path $carpeta 'respaldos_locales'
$fecha     = Get-Date -Format 'yyyyMMdd_HHmm'
$sshOpts   = @('-o', 'UserKnownHostsFile=NUL', '-o', 'StrictHostKeyChecking=accept-new', '-o', 'LogLevel=ERROR', '-i', $Llave)
$tarServidor = Join-Path $respaldos "servidor_$fecha.tar"
$extraido    = Join-Path $respaldos "servidor_$fecha"
$dumpLocal   = Join-Path $respaldos "local_antes_$fecha.dump"
# Tablas que son de cada instalacion (login y permisos): no se tocan salvo con -Completo
$tablasAuth  = @('user', 'session', 'account', 'verification', 'usuarios_modulos')

function Paso($texto) { Write-Host "`n== $texto" -ForegroundColor Green }
function Falla($texto) {
    Write-Host "XX $texto" -ForegroundColor Red
    Write-Host "No se termino. Tu base local anterior esta en: $dumpLocal" -ForegroundColor Yellow
    docker compose up -d app | Out-Null
    exit 1
}

if (-not (Test-Path (Join-Path $carpeta 'docker-compose.yml'))) { Write-Host "XX No encuentro docker-compose.yml en $carpeta" -ForegroundColor Red; exit 1 }
if (-not (Test-Path $Llave)) { Write-Host "XX No encuentro la llave SSH: $Llave (revisa tambien la Papelera)" -ForegroundColor Red; exit 1 }
New-Item -ItemType Directory -Force -Path $respaldos | Out-Null
Set-Location $carpeta

Paso '1/5 Sacando el respaldo en el servidor (base + PDFs)'
$remoto = "set -e; cd $CarpetaServidor; docker compose exec -T db pg_dump -U fondo2 -d fondo2 -F c > ~/fondo2_servidor.dump; tar -cf ~/fondo2_bajada.tar -C ~ fondo2_servidor.dump -C $CarpetaServidor storage/documentos; ls -lh ~/fondo2_bajada.tar"
& ssh @sshOpts $Servidor $remoto
if ($LASTEXITCODE -ne 0) { Write-Host 'XX No se pudo sacar el respaldo en el servidor. No se toco nada en local.' -ForegroundColor Red; exit 1 }

Paso '2/5 Descargando'
& scp @sshOpts "${Servidor}:/home/pruebas/fondo2_bajada.tar" $tarServidor
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $tarServidor) -or (Get-Item $tarServidor).Length -lt 100000) {
    Write-Host 'XX La descarga fallo o el archivo esta incompleto. No se toco nada en local.' -ForegroundColor Red; exit 1
}
& ssh @sshOpts $Servidor 'rm -f ~/fondo2_bajada.tar ~/fondo2_servidor.dump' | Out-Null
New-Item -ItemType Directory -Force -Path $extraido | Out-Null
tar -xf $tarServidor -C $extraido
$dumpServidor = Join-Path $extraido 'fondo2_servidor.dump'
if (-not (Test-Path $dumpServidor)) { Write-Host 'XX El paquete no trae la base. No se toco nada en local.' -ForegroundColor Red; exit 1 }
Write-Host ("Descargado: {0} ({1:N1} MB)" -f $tarServidor, ((Get-Item $tarServidor).Length / 1MB))

Paso '3/5 Respaldando la base local'
docker compose exec -T db pg_dump -U fondo2 -d fondo2 -F c -f /tmp/local_antes.dump
if ($LASTEXITCODE -ne 0) { Write-Host 'XX No se pudo respaldar la base local (esta encendido Docker?). No se toco nada.' -ForegroundColor Red; exit 1 }
docker compose cp db:/tmp/local_antes.dump $dumpLocal | Out-Null
if (-not (Test-Path $dumpLocal)) { Write-Host 'XX No se pudo copiar el respaldo local. No se toco nada.' -ForegroundColor Red; exit 1 }
Write-Host "Respaldo local: $dumpLocal"

Paso '4/5 Reemplazando los datos locales con los del servidor'
docker compose stop app | Out-Null
docker compose cp $dumpServidor db:/tmp/servidor.dump | Out-Null
if ($LASTEXITCODE -ne 0) { Falla 'No se pudo copiar el respaldo al contenedor.' }
if ($Completo) {
    docker compose exec -T db psql -U fondo2 -d postgres -v ON_ERROR_STOP=1 -c 'DROP DATABASE fondo2 WITH (FORCE);' -c 'CREATE DATABASE fondo2;'
    if ($LASTEXITCODE -ne 0) { Falla 'No se pudo recrear la base local.' }
    docker compose exec -T db pg_restore -U fondo2 -d fondo2 --no-owner /tmp/servidor.dump
    if ($LASTEXITCODE -ne 0) { Falla 'pg_restore termino con errores.' }
    Write-Host 'Base completa reemplazada (usuarios y contrasenas = los del servidor).'
} else {
    # Tablas de negocio = las que trae el dump, menos las de login/permisos,
    # y que existan en la base local (si el codigo local es mas viejo, avisa).
    $enDump  = docker compose exec -T db pg_restore -l /tmp/servidor.dump | ForEach-Object { if ($_ -match 'TABLE DATA public (\S+) ') { $Matches[1] } }
    $enLocal = docker compose exec -T db psql -U fondo2 -d fondo2 -tAc "select tablename from pg_tables where schemaname='public'"
    $tablas  = @($enDump | Where-Object { $tablasAuth -notcontains $_ -and $enLocal -contains $_ })
    $faltan  = @($enDump | Where-Object { $tablasAuth -notcontains $_ -and $enLocal -notcontains $_ })
    if ($faltan.Count -gt 0) { Write-Host "OJO: tablas del servidor que no existen en local (haz git pull): $($faltan -join ', ')" -ForegroundColor Yellow }
    if ($tablas.Count -eq 0) { Falla 'El dump no trae tablas de negocio.' }
    $lista = ($tablas | ForEach-Object { '"' + $_ + '"' }) -join ', '
    docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 -q -c "TRUNCATE TABLE $lista CASCADE;"
    if ($LASTEXITCODE -ne 0) { Falla 'No se pudieron vaciar las tablas locales.' }
    $targs = @(); foreach ($t in $tablas) { $targs += @('-t', $t) }
    docker compose exec -T db pg_restore -U fondo2 -d fondo2 --data-only --disable-triggers --no-owner -n public @targs /tmp/servidor.dump
    if ($LASTEXITCODE -ne 0) { Falla 'pg_restore termino con errores.' }
    Get-Content -Raw (Join-Path $carpeta 'scripts\fix_sequences.sql') | docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 -q
    Write-Host "Tablas refrescadas: $($tablas.Count). Usuarios, permisos y sesiones locales: sin cambios."
}
docker compose exec -T db rm -f /tmp/servidor.dump /tmp/local_antes.dump | Out-Null

Paso '5/5 Copiando PDFs y levantando la app local'
$pdfOrigen  = Join-Path $extraido 'storage\documentos'
$pdfDestino = Join-Path $carpeta 'storage\documentos'
New-Item -ItemType Directory -Force -Path $pdfDestino | Out-Null
$nuevos = 0
Get-ChildItem $pdfOrigen -File | ForEach-Object {
    $dest = Join-Path $pdfDestino $_.Name
    if (-not (Test-Path $dest) -or (Get-FileHash $dest).Hash -ne (Get-FileHash $_.FullName).Hash) {
        Copy-Item $_.FullName $dest -Force; $nuevos++
    }
}
$soloLocal = @(Get-ChildItem $pdfDestino -File | Where-Object { -not (Test-Path (Join-Path $pdfOrigen $_.Name)) })
Write-Host "PDFs del servidor: $((Get-ChildItem $pdfOrigen -File).Count)  copiados/actualizados: $nuevos"
if ($soloLocal.Count -gt 0) { Write-Host "OJO: $($soloLocal.Count) PDF(s) existen solo en local (no se borraron)." -ForegroundColor Yellow }
Remove-Item -Recurse -Force $extraido
docker compose up -d | Out-Null
docker compose restart app | Out-Null
if ($LASTEXITCODE -ne 0) { Falla 'No se pudo levantar la app.' }

$becas = docker compose exec -T db psql -U fondo2 -d fondo2 -tAc 'select count(*) from becas_nueva'
$proy  = docker compose exec -T db psql -U fondo2 -d fondo2 -tAc 'select count(*) from proyectos'
Write-Host "`nLISTO. Local = servidor ($proy proyectos, $becas becas). Abre http://localhost:8082/dashboard" -ForegroundColor Green
Write-Host "Para volver a la base local anterior:" -ForegroundColor Yellow
Write-Host "  cd `"$carpeta`""
Write-Host "  docker compose cp `"$dumpLocal`" db:/tmp/antes.dump"
Write-Host "  docker compose exec -T db psql -U fondo2 -d postgres -c `"DROP DATABASE fondo2 WITH (FORCE);`" -c `"CREATE DATABASE fondo2;`""
Write-Host "  docker compose exec -T db pg_restore -U fondo2 -d fondo2 --no-owner /tmp/antes.dump"
