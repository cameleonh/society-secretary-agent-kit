[CmdletBinding()]
param(
    [string]$TargetSkillsDir = (Join-Path $HOME ".codex\\skills"),
    [switch]$Force
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsRoot = Join-Path $repoRoot "skills"

if (-not (Test-Path -LiteralPath $skillsRoot)) {
    throw "Skills folder not found: $skillsRoot"
}

if (-not (Test-Path -LiteralPath $TargetSkillsDir)) {
    New-Item -ItemType Directory -Path $TargetSkillsDir -Force | Out-Null
}

$skills = Get-ChildItem -LiteralPath $skillsRoot -Directory
foreach ($skill in $skills) {
    $destination = Join-Path $TargetSkillsDir $skill.Name
    if ((Test-Path -LiteralPath $destination) -and (-not $Force)) {
        Write-Host "Skip existing skill: $destination"
        continue
    }
    Copy-Item -LiteralPath $skill.FullName -Destination $TargetSkillsDir -Recurse -Force
    Write-Host "Installed skill: $($skill.Name)"
}

Write-Host "Global install complete."
Write-Host "Target: $TargetSkillsDir"
