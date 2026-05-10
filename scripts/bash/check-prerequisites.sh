#!/usr/bin/env bash
# Spec Kit prerequisite checker — locates the active feature and verifies artifacts.
# Usage: check-prerequisites.sh [--json] [--paths-only] [--require-tasks] [--include-tasks]
#
# Reads .specify/feature.json from the repo root, then checks for the presence
# of spec.md, plan.md, tasks.md, and other artifacts in the feature directory.
# Outputs JSON (default) or plain text for AI command consumption.

set -euo pipefail

JSON=false
PATHS_ONLY=false
REQUIRE_TASKS=false
INCLUDE_TASKS=false

# --- Parse args ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --json) JSON=true ; shift ;;
        --paths-only) PATHS_ONLY=true ; shift ;;
        --require-tasks) REQUIRE_TASKS=true ; shift ;;
        --include-tasks) INCLUDE_TASKS=true ; shift ;;
        *) shift ;;
    esac
done

# --- Determine repo root ---
REPO_ROOT=""
SEARCH_DIR="$(pwd)"
while [[ "$SEARCH_DIR" != "/" && -n "$SEARCH_DIR" ]]; do
    if [[ -d "$SEARCH_DIR/.git" || -d "$SEARCH_DIR/.specify" ]]; then
        REPO_ROOT="$SEARCH_DIR"
        break
    fi
    SEARCH_DIR="$(dirname "$SEARCH_DIR")"
done
[[ -z "$REPO_ROOT" ]] && REPO_ROOT="$(pwd)"

# --- Read .specify/feature.json ---
FEATURE_DIR=""
FEATURE_NAME=""
FEATURE_NUMBER=""
FEATURE_JSON="$REPO_ROOT/.specify/feature.json"

if [[ -f "$FEATURE_JSON" ]]; then
    if command -v jq >/dev/null 2>&1; then
        FEATURE_DIR_RAW="$(jq -r '.feature_dir // .dir // empty' "$FEATURE_JSON" 2>/dev/null || true)"
        FEATURE_NAME="$(jq -r '.feature_name // empty' "$FEATURE_JSON" 2>/dev/null || true)"
        FEATURE_NUMBER="$(jq -r '.feature_number // empty' "$FEATURE_JSON" 2>/dev/null || true)"
    elif command -v python3 >/dev/null 2>&1; then
        FEATURE_DIR_RAW="$(python3 -c "import json,sys; d=json.load(open('$FEATURE_JSON')); print(d.get('feature_dir') or d.get('dir',''))" 2>/dev/null || true)"
        FEATURE_NAME="$(python3 -c "import json,sys; d=json.load(open('$FEATURE_JSON')); print(d.get('feature_name',''))" 2>/dev/null || true)"
        FEATURE_NUMBER="$(python3 -c "import json,sys; d=json.load(open('$FEATURE_JSON')); print(d.get('feature_number',''))" 2>/dev/null || true)"
    fi

    if [[ -n "${FEATURE_DIR_RAW:-}" ]]; then
        FEATURE_DIR="$REPO_ROOT/$FEATURE_DIR_RAW"
    fi
fi

# --- Fallback: scan specs/ directory for most recent feature ---
if [[ -z "$FEATURE_DIR" ]]; then
    SPECS_DIR="$REPO_ROOT/specs"
    if [[ -d "$SPECS_DIR" ]]; then
        LATEST="$(find "$SPECS_DIR" -maxdepth 1 -type d -not -path "$SPECS_DIR" | sort -r | head -n 1)"
        if [[ -n "$LATEST" ]]; then
            FEATURE_DIR="$LATEST"
            FEATURE_NAME="$(basename "$LATEST")"
        fi
    fi
fi

# --- Build artifact paths ---
declare -A ARTIFACT_PATHS
declare -A ARTIFACT_EXISTS
AVAILABLE_DOCS=()

artifact_keys=(
    "FEATURE_SPEC:spec.md"
    "IMPL_PLAN:plan.md"
    "DATA_MODEL:data-model.md"
    "RESEARCH:research.md"
    "QUICKSTART:quickstart.md"
    "CONTRACTS:contracts"
    "TASKS:tasks.md"
    "CHECKLISTS:checklists"
)

if [[ -n "$FEATURE_DIR" && -d "$FEATURE_DIR" ]]; then
    for entry in "${artifact_keys[@]}"; do
        key="${entry%%:*}"
        file="${entry##*:}"
        path="$FEATURE_DIR/$file"
        if [[ -e "$path" ]]; then
            ARTIFACT_EXISTS[$key]=true
            AVAILABLE_DOCS+=("$file")
        else
            ARTIFACT_EXISTS[$key]=false
            if [[ "$key" == "TASKS" && "$INCLUDE_TASKS" == true ]]; then
                AVAILABLE_DOCS+=("$file")
            fi
        fi
        ARTIFACT_PATHS[$key]="$path"
    done
else
    FEATURE_DIR="$REPO_ROOT/specs"
fi

# --- RequireTasks gate ---
if [[ "$REQUIRE_TASKS" == true && "${ARTIFACT_EXISTS[TASKS]:-false}" != true ]]; then
    echo "ERROR: tasks.md is required but not found in feature directory. Run /speckit.tasks first." >&2
    exit 1
fi

# --- Output helpers ---
json_escape() {
    printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\t/\\t/g; s/\n/\\n/g'
}

emit_json() {
    local first=true
    echo "{"
    echo "  \"REPO_ROOT\": \"$(json_escape "$REPO_ROOT")\","
    echo "  \"FEATURE_DIR\": \"$(json_escape "$FEATURE_DIR")\","
    echo "  \"FEATURE_NAME\": \"$(json_escape "$FEATURE_NAME")\","
    echo "  \"FEATURE_NUMBER\": \"$(json_escape "$FEATURE_NUMBER")\","

    local docs_json=""
    for doc in "${AVAILABLE_DOCS[@]}"; do
        [[ -n "$docs_json" ]] && docs_json+=", "
        docs_json+="\"$(json_escape "$doc")\""
    done
    echo "  \"AVAILABLE_DOCS\": [$docs_json],"

    local first_art=true
    for entry in "${artifact_keys[@]}"; do
        key="${entry%%:*}"
        if [[ "$first_art" == true ]]; then
            first_art=false
        else
            echo ","
        fi
        echo -n "  \"${key}_PATH\": \"$(json_escape "${ARTIFACT_PATHS[$key]:-}")\","
        echo -n "  \"${key}_EXISTS\": ${ARTIFACT_EXISTS[$key]:-false}"
    done
    echo ""
    echo "}"
}

emit_paths_only_json() {
    echo "{"
    echo "  \"FEATURE_DIR\": \"$(json_escape "$FEATURE_DIR")\","
    echo "  \"FEATURE_SPEC\": \"$(json_escape "${ARTIFACT_PATHS[FEATURE_SPEC]:-}")\","
    echo "  \"IMPL_PLAN\": \"$(json_escape "${ARTIFACT_PATHS[IMPL_PLAN]:-}")\","
    echo "  \"TASKS\": \"$(json_escape "${ARTIFACT_PATHS[TASKS]:-}")\""
    echo "}"
}

emit_plain() {
    echo "REPO_ROOT=$REPO_ROOT"
    echo "FEATURE_DIR=$FEATURE_DIR"
    echo "FEATURE_NAME=$FEATURE_NAME"
    echo "FEATURE_NUMBER=$FEATURE_NUMBER"
    echo "AVAILABLE_DOCS=${AVAILABLE_DOCS[*]}"
    for entry in "${artifact_keys[@]}"; do
        key="${entry%%:*}"
        echo "${key}_PATH=${ARTIFACT_PATHS[$key]:-}"
        echo "${key}_EXISTS=${ARTIFACT_EXISTS[$key]:-false}"
    done
}

# --- Emit output ---
if [[ "$PATHS_ONLY" == true ]]; then
    if [[ "$JSON" == true ]]; then
        emit_paths_only_json
    else
        echo "FEATURE_DIR=$FEATURE_DIR"
        echo "FEATURE_SPEC=${ARTIFACT_PATHS[FEATURE_SPEC]:-}"
        echo "IMPL_PLAN=${ARTIFACT_PATHS[IMPL_PLAN]:-}"
        echo "TASKS=${ARTIFACT_PATHS[TASKS]:-}"
    fi
else
    if [[ "$JSON" == true ]]; then
        emit_json
    else
        emit_plain
    fi
fi
