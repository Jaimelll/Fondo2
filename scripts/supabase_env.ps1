# ─────────────────────────────────────────────────────────────────────────────
# Carga las credenciales de Supabase desde .env (NO trackeado).
#
# Antes vivían escritas en backup_diario.ps1, migrar_usuarios.ps1 y
# actualizar_desde_supabase.ps1 — y el repo es público. Ver .env.example.
#
# Uso desde un script de la raíz:
#   . "$PSScriptRoot\scripts\supabase_env.ps1"
#   # deja disponibles: $SB_HOST, $SB_PORT, $SB_USER, $SB_PASSWORD
#
# Estas credenciales solo hacen falta hasta el corte a fondo2; después,
# ninguno de estos scripts se usa.
# ─────────────────────────────────────────────────────────────────────────────

$envFile = Join-Path (Split-Path $PSScriptRoot -Parent) '.env'
if (-not (Test-Path $envFile)) {
    throw "No existe $envFile. Copia .env.example a .env y completa las variables SUPABASE_DB_*."
}

$valores = @{}
foreach ($linea in Get-Content $envFile) {
    if ($linea -match '^\s*#' -or $linea -notmatch '=') { continue }
    $partes = $linea -split '=', 2
    $valores[$partes[0].Trim()] = $partes[1].Trim().Trim('"').Trim("'")
}

$SB_HOST     = $valores['SUPABASE_DB_HOST']
$SB_PORT     = if ($valores['SUPABASE_DB_PORT']) { $valores['SUPABASE_DB_PORT'] } else { '6543' }
$SB_USER     = $valores['SUPABASE_DB_USER']
$SB_PASSWORD = $valores['SUPABASE_DB_PASSWORD']

if (-not $SB_HOST -or -not $SB_USER -or -not $SB_PASSWORD) {
    throw "Faltan SUPABASE_DB_HOST / SUPABASE_DB_USER / SUPABASE_DB_PASSWORD en $envFile (ver .env.example)."
}
