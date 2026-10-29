---
name: graphify
description: Build and query a knowledge graph of the codebase with the Graphify CLI (query/path/explain/affected) — architecture questions, impact analysis, exports, and speckit research
allowed-tools:
  - exec
  - read
  - grep
  - glob
permissions:
  allow:
    - Exec(graphify --version*)
    - Exec(graphify query*)
    - Exec(graphify path*)
    - Exec(graphify explain*)
    - Exec(graphify affected*)
    - Exec(graphify god-nodes*)
    - Exec(graphify update*)
    - Exec(graphify extract*)
    - Exec(graphify .*)
    - Exec(graphify cluster-only*)
    - Exec(graphify label*)
    - Exec(graphify export*)
    - Exec(graphify tree*)
    - Exec(graphify benchmark*)
    - Exec(graphify global list*)
    - Exec(graphify global path*)
    - Exec(graphify merge-graphs*)
    - Exec(graphify prs*)
    - Exec(graphify check-update*)
    - Exec(graphify save-result*)
    - Exec(graphify reflect*)
triggers:
  - user
  - model
---

Use the Graphify knowledge graph to answer codebase questions instead of grepping files.

1. Read the detailed skill at `.junie/skills/graphify/SKILL.md` and follow it.
2. Setup check: run `graphify --version`. If missing, install with `uv tool install graphifyy` (PyPI package is `graphifyy` — double y; CLI command is `graphify`; needs Python 3.10+ and uv). Extras: `"graphifyy[pdf]"`, `"graphifyy[sql]"`, `"graphifyy[office]"`, `"graphifyy[mcp]"`, `"graphifyy[all]"`.
3. Build if absent or stale: `graphify .` (or `graphify extract . --code-only` for a fully offline code-only graph). Rebuild with `graphify update .` after recent changes.
4. Query instead of grep — escalation ladder, cheapest sufficient step first: `graphify query "<question>"` (cap with `--budget N`; `--seed <file path>` for precision) → `graphify explain`/`path`/`affected` → grep (exact strings only) → read only the files the graph pointed to. Run `graphify affected "Symbol"` before proposing changes to shared components. Cite `EXTRACTED`/`INFERRED` edge tags; confirm critical findings in source files. Never read `GRAPH_REPORT.md` wholesale to answer a question.
5. Work memory: after a query settles a question, `graphify save-result --question "..." --answer "..." --nodes X --outcome useful|dead_end|corrected`; run `graphify reflect` occasionally — LESSONS.md compounds across sessions.
6. During speckit: use graphify for research (`/speckit-plan`), impact analysis and `[P]` conflict checks (`/speckit-tasks`), and dependency checks (`/speckit-implement`). Build the graph BEFORE `/speckit-implement` — building writes `graphify-out/`, queries are read-only.
7. Exports when asked: `graphify export callflow-html|obsidian|wiki|svg|neo4j`, `graphify tree`. DB push passwords go in env vars (`NEO4J_PASSWORD`/`FALKORDB_PASSWORD`), never on the command line.
8. Do not commit `graphify-out/`; it is a build artifact.
