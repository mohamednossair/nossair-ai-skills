# install.ps1
# One-stop installation for all agents:
# 1. Deploys Claude Code skills globally ($HOME\.claude\skills\)
# 2. Copies Junie and Windsurf configurations to the target project

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$TargetProject = $args[0]

# 1. Deploy Claude Code Skills (Global)
& "$RepoDir\scripts\sync-claude.ps1"

# 2. Deploy Project-Specific Skills (if target project provided)
if (-not $TargetProject) {
    Write-Host ""
    Write-Host "Tip: To install Junie & Windsurf skills for a specific project, provide the path:"
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

    Write-Host ""
    Write-Host "Done! Junie and Windsurf skills installed to $TargetProject."
}

Write-Host "All agents setup complete!"
