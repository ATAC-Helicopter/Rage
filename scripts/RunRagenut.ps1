$ErrorActionPreference = "Stop"

$exe = Get-ChildItem -Recurse -Filter Ragenut.exe .\bin |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $exe) {
    throw "Ragenut.exe not found. Build Release x64 first."
}

Write-Host "Running:" $exe.FullName
Write-Host "Working directory: Ragenut"

Push-Location Ragenut
try {
    & $exe.FullName
}
finally {
    Pop-Location
}
