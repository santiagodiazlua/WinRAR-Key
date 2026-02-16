$url = "https://raw.githubusercontent.com/santiagodiazlua/WinRAR-Key/refs/heads/main/rarreg.key"
$unidadSistema = $env:SystemDrive
$carpetaDestino = "$unidadSistema\Program Files\WinRAR"
$rutaDestino = "$carpetaDestino\rarreg.key"
$archivoTemporal = "$env:TEMP\rarreg.key"

Write-Host "Iniciando descarga del archivo..." -ForegroundColor Cyan

try {
    Invoke-WebRequest -Uri $url -OutFile $archivoTemporal -ErrorAction Stop
    Write-Host "Archivo descargado correctamente" -ForegroundColor Green
}
catch {
    Write-Host "Error al descargar el archivo: $_" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $carpetaDestino)) {
    Write-Host "La carpeta de WinRAR no existe" -ForegroundColor Red
    exit 1
}

try {
    Copy-Item -Path $archivoTemporal -Destination $rutaDestino -Force -ErrorAction Stop
    Write-Host "Archivo copiado exitosamente a $rutaDestino" -ForegroundColor Green
}
catch {
    Write-Host "Error al copiar el archivo: $_" -ForegroundColor Red
    exit 1
}

try {
    Remove-Item -Path $archivoTemporal -ErrorAction Stop
}
catch {
    Write-Host "Advertencia: No se pudo eliminar archivo temporal" -ForegroundColor Yellow
}

Write-Host "Proceso completado" -ForegroundColor Green
