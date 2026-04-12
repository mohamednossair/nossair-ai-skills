# sync-codex.ps1
# Deploys skills from .junie/skills/ to $CODEX_HOME/skills/ (global Codex skills)

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$SourceDir = Join-Path $RepoDir ".junie\skills"

if ($env:CODEX_HOME) {
    $DestRoot = $env:CODEX_HOME
} elseif ($env:HOME) {
    $DestRoot = Join-Path $env:HOME ".codex"
} else {
    $DestRoot = Join-Path $env:USERPROFILE ".codex"
}

$DestDir = Join-Path $DestRoot "skills"

if (-not (Test-Path $SourceDir)) {
    Write-Error "Error: Source directory not found: $SourceDir"
    exit 1
}

if (-not (Test-Path $DestDir)) {
    New-Item -Path $DestDir -ItemType Directory -Force | Out-Null
}

Write-Host "Syncing Codex skills..."
Write-Host "  From: $SourceDir"
Write-Host "  To:   $DestDir"
Write-Host ""

$Count = 0
$SkillDirs = Get-ChildItem -Path $SourceDir -Directory
foreach ($SkillDir in $SkillDirs) {
    Copy-Item -Path $SkillDir.FullName -Destination $DestDir -Recurse -Force
    Write-Host "  v $($SkillDir.Name)"
    $Count++
}

Write-Host ""
Write-Host "Done! Synced $Count skill(s) to Codex."
Write-Host "Restart Codex to pick up new skills."
Write-Host ""
