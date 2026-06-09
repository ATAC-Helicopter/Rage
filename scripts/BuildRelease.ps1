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

Write-Host "Using MSBuild:" $msbuild
Write-Host "Building Ragenut only, Release x64"

& $msbuild Rage.sln `
    /t:Ragenut `
    /p:Configuration=Release `
    /p:Platform=x64 `
    /m
