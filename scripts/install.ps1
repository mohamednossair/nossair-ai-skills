# install.ps1
# One-stop installation for all agents:
# 1. Deploys Claude Code skills globally ($HOME\.claude\skills\)
# 2. Deploys Codex skills globally ($CODEX_HOME\skills or $HOME\.codex\skills)
# 3. Copies Junie, Windsurf, and AI Assistant project configuration to the target project

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$TargetProject = $args[0]

# 1. Deploy Claude Code Skills (Global)
& "$RepoDir\scripts\sync-claude.ps1"

# 2. Deploy Codex Skills (Global)
& "$RepoDir\scripts\sync-codex.ps1"

# 3. Deploy Project-Specific Skills (if target project provided)
if (-not $TargetProject) {
    Write-Host ""
    Write-Host "Tip: To install Junie, Windsurf, and AI Assistant project files for a specific project, provide the path:"
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

    # Copy .windsurf
    Write-Host "  Copying .windsurf..."
    Copy-Item -Path "$RepoDir\.windsurf" -Destination $TargetProject -Recurse -Force

    # Copy .aiassistant
    Write-Host "  Copying .aiassistant..."
    Copy-Item -Path "$RepoDir\.aiassistant" -Destination $TargetProject -Recurse -Force

    Write-Host ""
    Write-Host "Done! Junie, Windsurf, and AI Assistant project files installed to $TargetProject."
}

Write-Host "All supported agents setup complete!"
