# check-contract-templates.ps1
# Verifies that every template announcement in the speckit/review command files is
# followed by a non-empty four-space-indented example, and that no command source
# contains escaped Markdown artifacts (backslash-escaped syntax or <br> tags).
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File scripts/check-contract-templates.ps1

$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$CommandsDir = Join-Path $RepoDir '.junie/commands'

$failures = New-Object System.Collections.Generic.List[string]
$totalAnnounces = 0
$totalOk = 0

Get-ChildItem -Path $CommandsDir -Filter '*.md' | Sort-Object Name | ForEach-Object {
    $file = $_
    $lines = Get-Content -Path $file.FullName

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        # 1. Every template announcement must be followed by a non-empty
        #    four-space-indented example within the next 3 lines.
        if ($line -match '(?i)as normal (markdown|json|text) without the example indentation') {
            $totalAnnounces++
            $ok = $false
            $max = [Math]::Min($i + 3, $lines.Count - 1)
            for ($j = $i + 1; $j -le $max; $j++) {
                if ($lines[$j] -match '^    \S') { $ok = $true; $totalOk++; break }
            }
            if (-not $ok) {
                $failures.Add("[$($file.Name)] announce at line $($i + 1) has no non-empty indented example within 3 lines")
            }
        }

        # 2. Parser safety: no escaped Markdown syntax and no <br> artifacts.
        if ($line -match '\\[-\[\]#|`]') {
            $preview = $line.Substring(0, [Math]::Min(80, $line.Length))
            $failures.Add("[$($file.Name)] escaped Markdown syntax at line $($i + 1): $preview")
        }
        if ($line -match '<br>') {
            $failures.Add("[$($file.Name)] <br> tag at line $($i + 1)")
        }
    }
}

Write-Host "Template announcements checked: $totalAnnounces (followed by an example: $totalOk)"

if ($failures.Count -gt 0) {
    Write-Host 'Contract template check FAILED:' -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure"
    }
    exit 1
}

Write-Host 'Contract template check passed: every announcement is followed by a non-empty indented example; no escaped syntax or <br> found in any command file.' -ForegroundColor Green
