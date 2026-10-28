# test-install.ps1
# End-to-end verification for install.ps1 using a temporary target project inside the repo.

$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$TestRoot = Join-Path $RepoDir '.tmp\install-test'
$TargetProject = Join-Path $TestRoot 'target-project'

if (Test-Path $TestRoot) {
    Remove-Item -Path $TestRoot -Recurse -Force
}

New-Item -Path $TargetProject -ItemType Directory -Force | Out-Null

try {
    & "$RepoDir\scripts\install.ps1" $TargetProject

    foreach ($requiredPath in @('.junie', '.aiassistant', '.devin')) {
        $destinationPath = Join-Path $TargetProject $requiredPath
        if (-not (Test-Path $destinationPath)) {
            throw "Missing installed directory: $requiredPath"
        }
    }

    $junieSkillCount = (Get-ChildItem -Path (Join-Path $TargetProject '.junie\skills') -Directory).Count
    if ($junieSkillCount -eq 0) {
        throw 'No Junie skills were copied during installation.'
    }

    $devinSkillCount = (Get-ChildItem -Path (Join-Path $TargetProject '.devin\skills') -Directory).Count
    if ($devinSkillCount -eq 0) {
        throw 'No Devin skills were copied during installation.'
    }

    $aiAssistantRules = (Get-ChildItem -Path (Join-Path $TargetProject '.aiassistant\rules') -Filter '*.md').Count
    if ($aiAssistantRules -eq 0) {
        throw 'No AI Assistant rules were copied during installation.'
    }

    Write-Host 'Install test passed.' -ForegroundColor Green
}
finally {
    if (Test-Path $TestRoot) {
        Remove-Item -Path $TestRoot -Recurse -Force
    }
}
