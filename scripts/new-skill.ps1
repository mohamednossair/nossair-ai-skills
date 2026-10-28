# new-skill.ps1
# Automates the creation of a new skill across Junie, AI Assistant, and Devin.
# Usage: .\scripts\new-skill.ps1 <tech-name>

$TechName = $args[0]
if (-not $TechName) {
    Write-Error "Error: Please provide a technology name (e.g., rust, go, flutter)."
    exit 1
}

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$JunieSkillDir = Join-Path $RepoDir ".junie\skills\$TechName"
$DevinSkillDir = Join-Path $RepoDir ".devin\skills\$TechName"
$CapTechName = $TechName.ToUpper().Substring(0,1) + $TechName.Substring(1)

# 1. Create Junie Skill folder and file (source of truth)
if (-not (Test-Path $JunieSkillDir)) {
    New-Item -ItemType Directory -Path $JunieSkillDir -Force | Out-Null
    $Content = Get-Content (Join-Path $RepoDir "templates\skill_template.md") -Raw
    $Content = $Content -replace '\[technology-name\]', $TechName
    $Content = $Content -replace '\[Technology Name\]', $CapTechName
    $Content | Out-File -FilePath (Join-Path $JunieSkillDir "SKILL.md") -Encoding utf8
    Write-Host "  * Created Junie Skill: .junie\skills\$TechName\SKILL.md"
} else {
    Write-Warning "  ! Junie Skill directory already exists: $JunieSkillDir"
}

# 2. Create Devin Skill folder and file
if (-not (Test-Path $DevinSkillDir)) {
    New-Item -ItemType Directory -Path $DevinSkillDir -Force | Out-Null
    $DevinContent = @"
---
name: $TechName
description: Review or develop $CapTechName code following project standards in .junie/skills/$TechName/SKILL.md
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Apply the project's $CapTechName standards when working on $CapTechName code.

1. Read the detailed skill at ``.junie/skills/$TechName/SKILL.md`` and follow it.
2. Also apply ``.junie/guidelines.md`` and the ``global`` skill.
3. When reviewing, group findings by: [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix.
"@
    $DevinContent | Out-File -FilePath (Join-Path $DevinSkillDir "SKILL.md") -Encoding utf8
    Write-Host "  * Created Devin Skill: .devin\skills\$TechName\SKILL.md"
} else {
    Write-Warning "  ! Devin Skill directory already exists: $DevinSkillDir"
}

Write-Host "`nSkill scaffolding complete for: $TechName"
Write-Host "Next steps:"
Write-Host "1. Edit .junie\skills\$TechName\SKILL.md to add specific rules (source of truth)."
Write-Host "2. Add the technology to .junie\guidelines.md (optional for core tech)."
Write-Host "3. Update README.md (Tech Stack Covered) and the .aiassistant\rules\project-rules.md Standards Map if needed."
Write-Host "4. Run .\scripts\check-command-parity.ps1 to validate."
