---
description: Create or update a cross-repository Constitution by analyzing workspace repositories and mapping features to the correct repo boundaries
---

# Speckit – Workspace Constitution Generator

This workflow helps you:
- Discover repositories in one or more workspace roots
- Ask targeted questions to capture org rules, ownership, and integration contracts
- Generate or update a single Constitution document describing each repo and how features map to the right repo
- Optionally write repo-local excerpts to each repository

## 1) Select roots to analyze
Provide absolute paths (comma-separated) to the directories that contain your repositories. Example (Windows):
- C:\SiliconExpert\Nossair\nossair-ai-skills
- C:\SiliconExpert\Presales

Note: The analyzer will detect repos by locating `.git` folders under these roots.

## 2) Discovery plan (preview)
- Find all Git repos under the selected roots
- For each repo, probe tech stack by presence of conventional files (package.json, pom.xml, build.gradle, requirements.txt, pyproject.toml, Cargo.toml, go.mod, etc.)
- Extract remote URL, default branch, and current branch
- Capture monorepo hints (workspace/package manager files)
- Do not write anything yet — show a dry-run summary first

## 3) Run discovery
Paste or confirm the roots, then run this PowerShell command to list repos and basic metadata.

```powershell
# Edit $roots with your selected paths
$roots = @(
  "C:\\SiliconExpert\\Nossair\\nossair-ai-skills",
  "C:\\SiliconExpert\\Presales"
)

$repoInfo = @()
foreach ($root in $roots) {
  if (Test-Path $root) {
    Get-ChildItem -Path $root -Recurse -Directory -Force -ErrorAction SilentlyContinue |
      Where-Object { Test-Path (Join-Path $_.FullName ".git") } |
      ForEach-Object {
        $path = $_.FullName
        $git = git -C $path rev-parse --is-inside-work-tree 2>$null
        if ($LASTEXITCODE -eq 0 -and $git -eq "true") {
          $remote = git -C $path remote get-url origin 2>$null
          $default = git -C $path symbolic-ref refs/remotes/origin/HEAD 2>$null
          $defaultBranch = if ($default) { ($default -split "/")[-1] } else { "" }
          $branch = git -C $path rev-parse --abbrev-ref HEAD 2>$null
          $stack = @()
          if (Test-Path (Join-Path $path "package.json")) { $stack += "node" }
          if (Test-Path (Join-Path $path "pom.xml")) { $stack += "maven" }
          if (Test-Path (Join-Path $path "build.gradle") -or Test-Path (Join-Path $path "build.gradle.kts")) { $stack += "gradle" }
          if (Test-Path (Join-Path $path "requirements.txt") -or Test-Path (Join-Path $path "pyproject.toml")) { $stack += "python" }
          if (Test-Path (Join-Path $path "go.mod")) { $stack += "go" }
          if (Test-Path (Join-Path $path "Cargo.toml")) { $stack += "rust" }
          $repoInfo += [pscustomobject]@{
            Name = Split-Path $path -Leaf
            Path = $path
            Remote = $remote
            DefaultBranch = $defaultBranch
            CurrentBranch = $branch
            Stack = ($stack -join ", ")
          }
        }
      }
  }
}
$repoInfo | Format-Table -AutoSize
```

## 4) Clarify rules and boundaries (answer these)
- Feature-to-repo mapping: How do you decide where a feature lives? By domain, layer, or tech?
- Repo ownership: Who approves changes for each repo? Any protected branches?
- Integration contracts: APIs, events, schemas that define cross-repo boundaries?
- Shared modules: Which repos are "platform" libraries vs. "application" services?
- CI/CD gates: Required checks per repo? Promotion flows?
- Out-of-scope repos: Any to exclude or mark read-only?
- Constitution location: Single master doc path (e.g., C:\...\CONSTITUTION.md) and per-repo excerpt path (e.g., .spec/constitution.md)?
- Auto-commit: Should the workflow create branches and commits automatically when writing updates?

## 5) Generate draft Constitution (template)
Copy this structure into your chosen Constitution file. Replace placeholders with real data from discovery and your answers.

```markdown
# Workspace Constitution

## Overview
- Scope: <roots>
- Last updated: <date>
- Source of truth: this document + per-repo excerpts

## Repositories

<!-- Repeat for each repo -->
### <repo-name>
- Path: <abs-path>
- Remote: <url>
- Default branch: <name>
- Tech stack: <stack>
- Ownership: <team/approvers>
- Role: <application|service|library|infra>
- Boundaries: <apis/events/contracts>
- Feature mapping rules: <when to change this repo>
- CI/CD gates: <required checks>
- Notes: <read-only?|monorepo package?>

## Cross-Repository Rules
- Domain boundaries: <domains and their owning repos>
- Integration contracts: <shared schemas, OpenAPI, AsyncAPI, protobuf>
- Shared modules: <list and versioning strategy>
- Branching & release: <strategy per repo>
- Testing: <unit/integration/e2e responsibilities>

## Feature Routing Matrix
| Feature | Primary Repo | Secondary Repos | Rationale |
|--------|---------------|-----------------|-----------|
| <feat> | <repo>        | <repos>         | <why>     |

## Governance
- Change management: <how to update constitution and excerpts>
- Review gates: <who signs off>
- Automation: <bots, CI tasks>
```

## 6) Optional: write per-repo excerpts
For each repo, write a concise `.spec/constitution.md` excerpt that includes only the repo’s section and any shared rules it depends on. Consider adding a link back to the master Constitution.

## 7) Apply changes safely
- Prefer creating a feature branch across all repos to keep changes atomic
- Commit message suggestion: `docs(spec): initialize or update workspace constitution`
- If auto-commit is enabled, ensure protected branches are respected and open PRs as needed

## 8) Keep in sync
- Re-run discovery when repos are added/removed
- Update mapping rules when new domains or services are introduced
- Treat this Constitution as the contract for feature placement and cross-repo work
```
