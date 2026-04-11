[CmdletBinding()]
param(
    [string]$TargetRoot = (Get-Location).Path,
    [switch]$Force
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$foldersToCopy = @(
    "skills",
    "runtime",
    "router",
    "templates",
    "rules",
    "docs"
)

if (-not (Test-Path -LiteralPath $TargetRoot)) {
    New-Item -ItemType Directory -Path $TargetRoot -Force | Out-Null
}

foreach ($folder in $foldersToCopy) {
    $source = Join-Path $repoRoot $folder
    $destination = Join-Path $TargetRoot $folder
    if (-not (Test-Path -LiteralPath $source)) {
        throw "Source folder not found: $source"
    }
    if ((Test-Path -LiteralPath $destination) -and (-not $Force)) {
        Write-Host "Skip existing folder: $destination"
        continue
    }
    Copy-Item -LiteralPath $source -Destination $TargetRoot -Recurse -Force
    Write-Host "Installed folder: $folder"
}

Write-Host "Local install complete."
Write-Host "Target: $TargetRoot"
