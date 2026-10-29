# install.ps1
# One-stop installation for all supported agents (Junie, AIR, Devin):
# Copies Junie, AI Assistant, and Devin project configuration to the target project.

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$TargetProject = $args[0]

if (-not $TargetProject) {
    Write-Host ""
    Write-Host "Tip: To install Junie, AI Assistant, and Devin project files for a specific project, provide the path:"
    Write-Host "  .\scripts\install.ps1 C:\path\to\your-project"
    Write-Host ""
} else {
    Write-Host "Installing project-specific skills to: $TargetProject"

    if (-not (Test-Path $TargetProject)) {
        Write-Error "Error: Target project directory does not exist: $TargetProject"
        exit 1
    }

    # Copy .junie
    Write-Host "  Copying .junie..."
    Copy-Item -Path "$RepoDir\.junie" -Destination $TargetProject -Recurse -Force

    # Copy .aiassistant
    Write-Host "  Copying .aiassistant..."
    Copy-Item -Path "$RepoDir\.aiassistant" -Destination $TargetProject -Recurse -Force

    # Copy .devin
    Write-Host "  Copying .devin..."
    Copy-Item -Path "$RepoDir\.devin" -Destination $TargetProject -Recurse -Force

    Write-Host ""
    # Copy only the speckit runtime helpers — maintenance scripts (install, test-install,
    # new-skill, check-command-parity, check-contract-templates) stay in this skills repo.
    Write-Host "  Copying speckit runtime helpers (scripts\bash, scripts\powershell)..."
    New-Item -ItemType Directory -Path "$TargetProject\scripts" -Force | Out-Null
    Copy-Item -Path "$RepoDir\scripts\bash" -Destination "$TargetProject\scripts\" -Recurse -Force
    Copy-Item -Path "$RepoDir\scripts\powershell" -Destination "$TargetProject\scripts\" -Recurse -Force

    Write-Host ""
    Write-Host "Done! Junie, AI Assistant, Devin project files, and speckit runtime helpers installed to $TargetProject."
}

Write-Host "All supported agents setup complete!"
