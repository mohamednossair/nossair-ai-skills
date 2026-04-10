# sync-claude.ps1
# Deploys skills from .claude/skills/ to ~/.claude/skills/ (global Claude Code slash commands)

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$SourceDir = Join-Path $RepoDir ".claude\skills"
$DestDir = Join-Path $HOME ".claude\skills"

if (-not (Test-Path $SourceDir)) {
    Write-Error "Error: Source directory not found: $SourceDir"
    exit 1
}

if (-not (Test-Path $DestDir)) {
    New-Item -Path $DestDir -ItemType Directory -Force | Out-Null
}

Write-Host "Syncing Claude Code skills..."
Write-Host "  From: $SourceDir"
Write-Host "  To:   $DestDir"
Write-Host ""

$Count = 0
$Files = Get-ChildItem -Path $SourceDir -Filter "*.md"
foreach ($File in $Files) {
    Copy-Item -Path $File.FullName -Destination $DestDir -Force
    $SkillName = $File.BaseName
    Write-Host "  v /$SkillName"
    $Count++
}

Write-Host ""
Write-Host "Done! Synced $Count skill(s) to Claude Code."
Write-Host ""
Write-Host "--- Junie and Windsurf ---"
Write-Host "These are project-specific. Copy to each project as needed."
Write-Host ""
Write-Host "Junie (PowerShell):"
Write-Host "Copy-Item -Path '$RepoDir\.junie' -Destination 'C:\your-project\' -Recurse"
Write-Host ""
Write-Host "Windsurf (PowerShell):"
Write-Host "Copy-Item -Path '$RepoDir\.windsurf' -Destination 'C:\your-project\' -Recurse"
Write-Host ""
