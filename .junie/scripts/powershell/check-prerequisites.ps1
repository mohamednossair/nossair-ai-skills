param(
    [switch]$Json,
    [switch]$PathsOnly,
    [switch]$RequireTasks,
    [switch]$IncludeTasks
)

$ErrorActionPreference = 'Stop'

# Determine repo root
$repoRoot = $null
$current = Get-Location
$search = $current.Path
$rootPath = [System.IO.Path]::GetPathRoot($search)
while ($search -and ($search -ne $rootPath)) {
    $gitPath = Join-Path $search '.git'
    $specifyPath = Join-Path $search '.specify'
    $hasGit = Test-Path $gitPath
    $hasSpecify = Test-Path $specifyPath
    if ($hasGit -or $hasSpecify) {
        $repoRoot = $search
        break
    }
    $search = Split-Path $search -Parent
}
if (-not $repoRoot) {
    $repoRoot = $current.Path
}

# Read .specify/feature.json
$featureJsonPath = Join-Path (Join-Path $repoRoot '.specify') 'feature.json'
$featureDir = $null
$featureName = $null
$featureNumber = $null

if (Test-Path $featureJsonPath) {
    try {
        $featureConfig = Get-Content $featureJsonPath -Raw | ConvertFrom-Json
        $rawDir = $featureConfig.feature_dir
        if (-not $rawDir) { $rawDir = $featureConfig.dir }
        if ($rawDir) {
            $featureDir = Join-Path $repoRoot $rawDir
        }
        $featureName = $featureConfig.feature_name
        $featureNumber = $featureConfig.feature_number
    } catch {
        # Invalid JSON - continue without feature dir
    }
}

# Fallback: scan specs/ directory for most recent feature
if (-not $featureDir) {
    $specsDir = Join-Path $repoRoot 'specs'
    if (Test-Path $specsDir) {
        $dirs = Get-ChildItem -Path $specsDir -Directory | Sort-Object Name -Descending
        if ($dirs) {
            $featureDir = $dirs[0].FullName
            $featureName = $dirs[0].Name
        }
    }
}

# Build artifact paths
$artifactNames = @(
    @{ Key = 'FEATURE_SPEC'; File = 'spec.md' },
    @{ Key = 'IMPL_PLAN';    File = 'plan.md' },
    @{ Key = 'DATA_MODEL';   File = 'data-model.md' },
    @{ Key = 'RESEARCH';     File = 'research.md' },
    @{ Key = 'QUICKSTART';   File = 'quickstart.md' },
    @{ Key = 'CONTRACTS';    File = 'contracts' },
    @{ Key = 'TASKS';        File = 'tasks.md' },
    @{ Key = 'CHECKLISTS';   File = 'checklists' }
)

$artifacts = @{}
$availableDocs = @()

if ($featureDir -and (Test-Path $featureDir)) {
    foreach ($art in $artifactNames) {
        $path = Join-Path $featureDir $art.File
        $exists = Test-Path $path
        $artifacts[$art.Key + '_PATH'] = $path
        $artifacts[$art.Key + '_EXISTS'] = $exists
        if ($exists -or ($art.Key -eq 'TASKS' -and $IncludeTasks)) {
            $availableDocs += $art.File
        }
    }
} else {
    $featureDir = Join-Path $repoRoot 'specs'
}

# RequireTasks gate
if ($RequireTasks) {
    $tasksExists = $artifacts['TASKS_EXISTS']
    if (-not $tasksExists) {
        Write-Error 'tasks.md is required but not found. Run /speckit.tasks first.'
        exit 1
    }
}

# Build output
$output = [ordered]@{
    REPO_ROOT      = $repoRoot
    FEATURE_DIR    = $featureDir
    FEATURE_NAME   = $featureName
    FEATURE_NUMBER = $featureNumber
    AVAILABLE_DOCS = $availableDocs
}

foreach ($key in $artifacts.Keys) {
    $output[$key] = $artifacts[$key]
}

if ($PathsOnly) {
    $minimal = [ordered]@{
        FEATURE_DIR  = $featureDir
        FEATURE_SPEC = $artifacts['FEATURE_SPEC_PATH']
        IMPL_PLAN    = $artifacts['IMPL_PLAN_PATH']
        TASKS        = $artifacts['TASKS_PATH']
    }
    $output = $minimal
}

# Emit output
if ($Json) {
    $output | ConvertTo-Json -Depth 3 -Compress
} else {
    foreach ($key in $output.Keys) {
        $value = $output[$key]
        if ($value -is [System.Collections.IEnumerable] -and -not ($value -is [string])) {
            $value = $value -join ','
        }
        "$key=$value"
    }
}