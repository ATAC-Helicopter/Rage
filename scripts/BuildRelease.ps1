$ErrorActionPreference = "Stop"

$vswhere = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"

if (-not (Test-Path $vswhere)) {
    throw "vswhere.exe not found. Visual Studio Installer may be missing."
}

$vsRoot = & $vswhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath

if (-not $vsRoot) {
    throw "Visual Studio installation not found."
}

$msbuild = Join-Path $vsRoot "MSBuild\Current\Bin\MSBuild.exe"

if (-not (Test-Path $msbuild)) {
    throw "MSBuild not found at $msbuild"
}

$toolsetRoot = Join-Path $vsRoot "MSBuild\Microsoft\VC\v180\Platforms\x64\PlatformToolsets"

if (-not (Test-Path $toolsetRoot)) {
    throw "PlatformToolsets folder not found at $toolsetRoot"
}

$toolset = Get-ChildItem $toolsetRoot -Directory |
    Where-Object { $_.Name -like "v*" } |
    Sort-Object Name -Descending |
    Select-Object -First 1 -ExpandProperty Name

if (-not $toolset) {
    throw "No platform toolset found."
}

Write-Host "Using MSBuild:" $msbuild
Write-Host "Using PlatformToolset:" $toolset
Write-Host "Building Ragenut only, Release x64"

& $msbuild Rage.sln `
    /t:Ragenut `
    /p:Configuration=Release `
    /p:Platform=x64 `
    /p:PlatformToolset=$toolset `
    /m
