if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Solicitando permisos de administrador..." -ForegroundColor Yellow
    try {
        Start-Process PowerShell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    }
    catch {
        Write-Host "Error: No se pudieron obtener permisos de administrador." -ForegroundColor Red
        Write-Host "Detalle: $_" -ForegroundColor Red
        pause
    }
    exit
}

try {
    $url = "https://raw.githubusercontent.com/santiagodiazlua/WinRAR-Key/refs/heads/main/rarreg.key"
    $destino = "$env:SystemDrive\Program Files\WinRAR"
    $archivo = "$destino\rarreg.key"

    if (-Not (Test-Path $destino)) {
        Write-Host "La carpeta $destino no existe. Creandola..." -ForegroundColor Yellow
        try {
            New-Item -Path $destino -ItemType Directory -Force | Out-Null
            Write-Host "Carpeta creada exitosamente." -ForegroundColor Green
        }
        catch {
            Write-Host "Error: No se pudo crear la carpeta $destino" -ForegroundColor Red
            Write-Host "Detalle: $_" -ForegroundColor Red
            pause
            exit 1
        }
    }

    Write-Host "Descargando archivo de licencia..." -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $url -OutFile $archivo -UseBasicParsing -ErrorAction Stop
    }
    catch {
        Write-Host "Error: No se pudo descargar el archivo desde $url" -ForegroundColor Red
        Write-Host "Verifica tu conexion a internet e intenta de nuevo." -ForegroundColor Red
        Write-Host "Detalle: $_" -ForegroundColor Red
        pause
        exit 1
    }

    if (Test-Path $archivo) {
        Write-Host "Archivo copiado exitosamente en $archivo" -ForegroundColor Green
        Write-Host "WinRAR ha sido activado correctamente." -ForegroundColor Green
    }
    else {
        Write-Host "Error: El archivo no se encuentra en la ruta de destino." -ForegroundColor Red
        pause
        exit 1
    }
}
catch {
    Write-Host "Ocurrio un error inesperado: $_" -ForegroundColor Red
    pause
    exit 1
}

pause
