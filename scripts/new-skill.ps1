# new-skill.ps1
# Automates the creation of a new skill across Claude Code, Junie, and Windsurf.
# Usage: .\scripts\new-skill.ps1 <tech-name>

$TechName = $args[0]
if (-not $TechName) {
    Write-Error "Error: Please provide a technology name (e.g., rust, go, flutter)."
    exit 1
}

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$JunieSkillDir = Join-Path $RepoDir ".junie\skills\$TechName"
$ClaudeSkillFile = Join-Path $RepoDir ".claude\skills\$TechName-review.md"
$WindsurfMemoryFile = Join-Path $RepoDir ".windsurf\memories\$TechName-standards.md"

# 1. Create Junie Skill folder and file
if (-not (Test-Path $JunieSkillDir)) {
    New-Item -ItemType Directory -Path $JunieSkillDir -Force | Out-Null
    $Content = Get-Content (Join-Path $RepoDir "templates\skill_template.md") -Raw
    $Content = $Content -replace '\[technology-name\]', $TechName
    $Content = $Content -replace '\[Technology Name\]', ($TechName.ToUpper().Substring(0,1) + $TechName.Substring(1))
    $Content | Out-File -FilePath (Join-Path $JunieSkillDir "SKILL.md") -Encoding utf8
    Write-Host "  * Created Junie Skill: .junie\skills\$TechName\SKILL.md"
} else {
    Write-Warning "  ! Junie Skill directory already exists: $JunieSkillDir"
}

# 2. Create Claude Skill file
if (-not (Test-Path $ClaudeSkillFile)) {
    $Content = Get-Content (Join-Path $RepoDir "templates\claude_skill_template.md") -Raw
    $Content = $Content -replace '\[Technology\]', ($TechName.ToUpper().Substring(0,1) + $TechName.Substring(1))
    $Content | Out-File -FilePath $ClaudeSkillFile -Encoding utf8
    Write-Host "  * Created Claude Command: .claude\skills\$TechName-review.md"
} else {
    Write-Warning "  ! Claude Command file already exists: $ClaudeSkillFile"
}

# 3. Create Windsurf Memory file
if (-not (Test-Path $WindsurfMemoryFile)) {
    $Header = "# $($TechName.ToUpper().Substring(0,1) + $TechName.Substring(1)) Standards`n"
    $Header += "## Coding Standards`n- Standard 1`n- Standard 2`n"
    $Header | Out-File -FilePath $WindsurfMemoryFile -Encoding utf8
    Write-Host "  * Created Windsurf Memory: .windsurf\memories\$TechName-standards.md"
} else {
    Write-Warning "  ! Windsurf Memory file already exists: $WindsurfMemoryFile"
}

Write-Host "`nSkill scaffolding complete for: $TechName"
Write-Host "Next steps:"
Write-Host "1. Edit the generated files to add specific rules."
Write-Host "2. Add the technology to .junie/guidelines.md (Optional for core tech)."
Write-Host "3. Update the relevant README sections if needed (for example: Tech Stack Covered or Claude tech-review commands)."
Write-Host "4. Re-sync Claude Code with .\scripts\sync-claude.ps1"
