# test-install.ps1
# End-to-end verification for install.ps1 using a temporary HOME and target project inside the repo.

$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$TestRoot = Join-Path $RepoDir '.tmp\install-test'
$HomeDir = Join-Path $TestRoot 'home'
$TargetProject = Join-Path $TestRoot 'target-project'
$OriginalHome = $env:HOME

if (Test-Path $TestRoot) {
    Remove-Item -Path $TestRoot -Recurse -Force
}

New-Item -Path $HomeDir -ItemType Directory -Force | Out-Null
New-Item -Path $TargetProject -ItemType Directory -Force | Out-Null

try {
    $env:HOME = $HomeDir

    & "$RepoDir\scripts\install.ps1" $TargetProject

    foreach ($requiredPath in @('.junie', '.windsurf', '.aiassistant')) {
        $destinationPath = Join-Path $TargetProject $requiredPath
        if (-not (Test-Path $destinationPath)) {
            throw "Missing installed directory: $requiredPath"
        }
    }

    $claudeSkillsDir = Join-Path $HomeDir '.claude\skills'
    if (-not (Test-Path $claudeSkillsDir)) {
        throw 'Claude skills directory was not created.'
    }

    $skillCount = (Get-ChildItem -Path $claudeSkillsDir -Filter '*.md').Count
    if ($skillCount -eq 0) {
        throw 'No Claude skills were copied during installation.'
    }

    Write-Host 'Install test passed.' -ForegroundColor Green
}
finally {
    $env:HOME = $OriginalHome
    if (Test-Path $TestRoot) {
        Remove-Item -Path $TestRoot -Recurse -Force
    }
}