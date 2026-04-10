# check-command-parity.ps1
# Verifies the 7 unified command contracts stay aligned across Claude, Junie, and Windsurf.

$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)

$checks = @(
    @{
        Name = 'review'
        Claude = '.claude/skills/review.md'
        Junie = '.junie/commands/review.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            '\[Critical\] \| \[Warning\] \| \[Suggestion\]'
        )
    },
    @{
        Name = 'plan'
        Claude = '.claude/skills/plan.md'
        Junie = '.junie/commands/plan.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            'Risk'
        )
    },
    @{
        Name = 'test-generate'
        Claude = '.claude/skills/test-generate.md'
        Junie = '.junie/commands/test-generate.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            'pytest'
        )
    },
    @{
        Name = 'git-commit'
        Claude = '.claude/skills/git-commit.md'
        Junie = '.junie/commands/git-commit.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            'Output only the commit message'
        )
    },
    @{
        Name = 'spec-init'
        Claude = '.claude/skills/spec-init.md'
        Junie = '.junie/commands/spec-init.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            'constitution\.md'
        )
    },
    @{
        Name = 'spec-plan'
        Claude = '.claude/skills/spec-plan.md'
        Junie = '.junie/commands/spec-plan.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            'Coverage matrix: requirement -> task mapping'
        )
    },
    @{
        Name = 'spec-validate'
        Claude = '.claude/skills/spec-validate.md'
        Junie = '.junie/commands/spec-validate.md'
        Windsurf = '.windsurf/memories/commands-reference.md'
        Patterns = @(
            '\[Critical\] \| \[Warning\] \| \[Suggestion\]'
        )
    }
)

$failures = New-Object System.Collections.Generic.List[string]

foreach ($check in $checks) {
    $paths = @($check.Claude, $check.Junie, $check.Windsurf)
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

if ($failures.Count -gt 0) {
    Write-Host 'Command parity check failed:' -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure"
    }
    exit 1
}

Write-Host 'Command parity check passed.' -ForegroundColor Green