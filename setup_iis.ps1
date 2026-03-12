# setup_iis_activa_v2.ps1
# Script para configurar IIS local para Activa V2
# EJECUTAR COMO ADMINISTRADOR

Write-Host "Configurando IIS para Activa V2..." -ForegroundColor Cyan

Import-Module WebAdministration

$siteName = "ActivaV2"
$port = 8090
$physicalPath = "C:\Repos\activa\activa-v2"
$appPoolName = "ActivaV2Pool"

# 1. Crear Application Pool
if (!(Test-Path "IIS:\AppPools\$appPoolName")) {
    Write-Host "Creando AppPool: $appPoolName"
    New-Item "IIS:\AppPools\$appPoolName"
}

# Configurar AppPool para 32-bit (común en Classic ASP antiguo) e integrar
Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name "enable32BitAppOnWin64" -Value $true
Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name "managedPipelineMode" -Value "Integrated"

# 2. Crear Sitio Web
if (!(Test-Path "IIS:\Sites\$siteName")) {
    Write-Host "Creando Sitio Web: $siteName en puerto $port"
    New-Website -Name $siteName -Port $port -PhysicalPath $physicalPath -ApplicationPool $appPoolName
} else {
    Write-Host "El sitio $siteName ya existe. Actualizando ruta y pool..."
    Set-ItemProperty "IIS:\Sites\$siteName" -Name "physicalPath" -Value $physicalPath
    Set-ItemProperty "IIS:\Sites\$siteName" -Name "applicationPool" -Value $appPoolName
}

# 3. Configurar Classic ASP (Parent Paths, errores detallados)
Write-Host "Configurando opciones de Classic ASP..."
# Habilitar rutas relativas al padre (..)
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location $siteName -filter "system.webServer/asp" -name "enableParentPaths" -value $true
# Enviar errores al navegador (útil para debug)
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -location $siteName -filter "system.webServer/asp" -name "scriptErrorSentToBrowser" -value $true

# 4. Asegurar permisos de carpeta para el AppPool
Write-Host "Asegurando permisos NTFS para IIS AppPool\$appPoolName..."
$acl = Get-Acl $physicalPath
$permission = "IIS AppPool\$appPoolName","FullControl","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl $physicalPath $acl

Write-Host "¡Configuración completada!" -ForegroundColor Green
Write-Host "Puedes acceder en: http://localhost:$port/ia/debug.asp" -ForegroundColor Yellow
