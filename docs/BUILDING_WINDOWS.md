# Building Rage on Windows

## Known-good setup

This branch currently has a working Windows build path using:

- Windows
- Visual Studio 18 / Visual Studio 2026
- MSBuild from the installed Visual Studio instance
- Vulkan SDK 1.4.350.0
- Python on PATH
- VS Code as the editor and task runner

## Generate project files

From the repository root:

``powershell
cd scripts
python Setup.py
cd ..
``

The bundled Premake version currently generates Visual Studio 2019 project files. This is expected for now.

## Build from VS Code

Use:

``txt
Ctrl + Shift + P
Tasks: Run Task
Rage: Build Release x64
``

The VS Code build script is:

``txt
scripts/BuildRelease.ps1
``

It detects MSBuild from Visual Studio and builds Ragenut in Release x64.

## Run from VS Code

Use:

``txt
Ctrl + Shift + P
Tasks: Run Task
Rage: Run Ragenut
``

The run script is:

``txt
scripts/RunRagenut.ps1
``

It launches Ragenut.exe with Ragenut/ as the working directory so assets, shaders, and fonts resolve correctly.

## Current caveats

- Debug is not the reliable baseline yet.
- Use Release x64 for now.
- The bundled Premake does not support the vs2022 action.
- Dependency updates should be done one at a time after this baseline.
