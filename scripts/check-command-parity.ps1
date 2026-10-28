# check-command-parity.ps1
# Verifies the 4 unified command contracts stay aligned across Junie and Devin.

$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)

# Source of truth for unified commands: .junie/commands/ and .devin/skills/
$checks = @(
    @{
        Name = 'review'
        Junie = '.junie/commands/review.md'
        Devin = '.devin/skills/review/SKILL.md'
        Patterns = @(
            '\[Critical\] \| \[Warning\] \| \[Suggestion\]'
        )
    },
    @{
        Name = 'review-pr'
        Junie = '.junie/commands/review-pr.md'
        Devin = '.devin/skills/review-pr/SKILL.md'
        Patterns = @(
            '\[Critical\] \| \[Warning\] \| \[Suggestion\]',
            'Merge Recommendation'
        )
    },
    @{
        Name = 'plan'
        Junie = '.junie/commands/plan.md'
        Devin = '.devin/skills/plan/SKILL.md'
        Patterns = @(
            'Risk'
        )
    },
    @{
        Name = 'test-generate'
        Junie = '.junie/commands/test-generate.md'
        Devin = '.devin/skills/test-generate/SKILL.md'
        Patterns = @(
            'pytest'
        )
    },
    @{
        Name = 'git-commit'
        Junie = '.junie/commands/git-commit.md'
        Devin = '.devin/skills/git-commit/SKILL.md'
        Patterns = @(
            'run `git commit`',
            'created commit hash and final commit message'
        )
    }
)

$failures = New-Object System.Collections.Generic.List[string]

foreach ($check in $checks) {
    $paths = @($check.Junie, $check.Devin)
    foreach ($relativePath in $paths) {
        $fullPath = Join-Path $RepoDir $relativePath
        if (-not (Test-Path $fullPath)) {
            $failures.Add("Missing file: $relativePath")
            continue
        }

        $content = Get-Content -Raw -Path $fullPath
        foreach ($pattern in $check.Patterns) {
            if ($content -notmatch $pattern) {
                $failures.Add("[$($check.Name)] pattern '$pattern' not found in $relativePath")
            }
        }
    }
}

# Check ALL Junie commands for unsupported frontmatter (unified + speckit)
$junieCommandsDir = Join-Path $RepoDir '.junie/commands'
if (Test-Path $junieCommandsDir) {
    $junieCommandPaths = Get-ChildItem -Path $junieCommandsDir -Filter '*.md' | Select-Object -ExpandProperty FullName
    foreach ($path in $junieCommandPaths) {
        $content = Get-Content -Raw -Path $path
        if ($content -match '(?m)^name:') {
            $failures.Add("Junie command uses unsupported 'name' frontmatter: $([System.IO.Path]::GetRelativePath($RepoDir, $path))")
        }
        if ($content -match '(?m)^arguments:') {
            $failures.Add("Junie command uses unsupported 'arguments' frontmatter: $([System.IO.Path]::GetRelativePath($RepoDir, $path))")
        }
    }
}

# Check ALL Devin skills for required frontmatter
$devinSkillsDir = Join-Path $RepoDir '.devin/skills'
if (Test-Path $devinSkillsDir) {
    $devinSkillFiles = Get-ChildItem -Path $devinSkillsDir -Filter 'SKILL.md' -Recurse | Select-Object -ExpandProperty FullName
    foreach ($path in $devinSkillFiles) {
        $content = Get-Content -Raw -Path $path
        if ($content -notmatch '(?m)^name:') {
            $failures.Add("Devin skill missing 'name' frontmatter: $([System.IO.Path]::GetRelativePath($RepoDir, $path))")
        }
        if ($content -notmatch '(?m)^description:') {
            $failures.Add("Devin skill missing 'description' frontmatter: $([System.IO.Path]::GetRelativePath($RepoDir, $path))")
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host 'Command parity check failed:' -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure"
    }
    exit 1
}

Write-Host 'Command parity check passed.' -ForegroundColor Green
