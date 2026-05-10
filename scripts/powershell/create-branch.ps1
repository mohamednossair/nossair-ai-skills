#Requires -Version 5.1
<#
.SYNOPSIS
    Creates a work branch if currently on a protected branch (main/master/develop).

.DESCRIPTION
    Checks the current git branch. If it is a protected branch, creates and switches
    to a new branch following the naming convention: <prefix>/<issue-id>-<short-slug>.
    Outputs JSON with the branch name, previous branch, and whether a new branch was created.

.PARAMETER Prefix
    Branch prefix. Default: 'feature'.

.PARAMETER ShortName
    Short descriptive slug (e.g. 'auth-refresh').

.PARAMETER IssueId
    Optional Jira/Bitbucket issue ID (e.g. 'SE-123').

.EXAMPLE
    .\create-branch.ps1 -Prefix "feature/spec" -ShortName "auth-refresh" -IssueId "SE-123"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Prefix,

    [Parameter(Mandatory = $true)]
    [string]$ShortName,

    [Parameter(Mandatory = $false)]
    [string]$IssueId = ""
)

$protectedBranches = @("main", "master", "develop")

try {
    $currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Output '{"error":"Not inside a git repository"}'
        exit 1
    }

    $currentBranch = $currentBranch.Trim()
    $isProtected = $protectedBranches -contains $currentBranch

    if (-not $isProtected) {
        Write-Output (@{
            created     = $false
            currentBranch = $currentBranch
            previousBranch = $currentBranch
            branchName  = $currentBranch
        } | ConvertTo-Json -Compress)
        exit 0
    }

    # Build branch name
    $slug = $ShortName -replace '\s+', '-' | ForEach-Object { $_.ToLower() }
    if ($IssueId) {
        $branchName = "$Prefix/$IssueId-$slug"
    } else {
        $branchName = "$Prefix/$slug"
    }

    # Create and switch
    git switch -c $branchName 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Output "{`"error`":`"Failed to create branch '$branchName'`"}"
        exit 1
    }

    Write-Output (@{
        created        = $true
        currentBranch  = $branchName
        previousBranch = $currentBranch
        branchName     = $branchName
    } | ConvertTo-Json -Compress)
    exit 0
}
catch {
    Write-Output "{`"error`":`"$($_.Exception.Message)`"}"
    exit 1
}
