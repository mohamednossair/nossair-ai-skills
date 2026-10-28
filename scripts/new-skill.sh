#!/bin/bash
# new-skill.sh
# Automates the creation of a new skill across Junie, AI Assistant, and Devin.
# Usage: ./scripts/new-skill.sh <tech-name>

TECH_NAME=$1
if [ -z "$TECH_NAME" ]; then
    echo "Error: Please provide a technology name (e.g., rust, go, flutter)."
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JUNIE_SKILL_DIR="$REPO_DIR/.junie/skills/$TECH_NAME"
DEVIN_SKILL_DIR="$REPO_DIR/.devin/skills/$TECH_NAME"
CAP_TECH_NAME=$(echo "$TECH_NAME" | sed 's/./\U&/')

# 1. Create Junie Skill folder and file (source of truth)
if [ ! -d "$JUNIE_SKILL_DIR" ]; then
    mkdir -p "$JUNIE_SKILL_DIR"
    sed -e "s/\[technology-name\]/$TECH_NAME/g" \
        -e "s/\[Technology Name\]/$CAP_TECH_NAME/g" \
        "$REPO_DIR/templates/skill_template.md" > "$JUNIE_SKILL_DIR/SKILL.md"
    echo "  ✓ Created Junie Skill: .junie/skills/$TECH_NAME/SKILL.md"
else
    echo "  ! Junie Skill directory already exists: $JUNIE_SKILL_DIR"
fi

# 2. Create Devin Skill folder and file
if [ ! -d "$DEVIN_SKILL_DIR" ]; then
    mkdir -p "$DEVIN_SKILL_DIR"
    cat > "$DEVIN_SKILL_DIR/SKILL.md" << EOF
---
name: $TECH_NAME
description: Review or develop $CAP_TECH_NAME code following project standards in .junie/skills/$TECH_NAME/SKILL.md
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Apply the project's $CAP_TECH_NAME standards when working on $CAP_TECH_NAME code.

1. Read the detailed skill at \`.junie/skills/$TECH_NAME/SKILL.md\` and follow it.
2. Also apply \`.junie/guidelines.md\` and the \`global\` skill.
3. When reviewing, group findings by: [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix.
EOF
    echo "  ✓ Created Devin Skill: .devin/skills/$TECH_NAME/SKILL.md"
else
    echo "  ! Devin Skill directory already exists: $DEVIN_SKILL_DIR"
fi

echo -e "\nSkill scaffolding complete for: $TECH_NAME"
echo "Next steps:"
echo "1. Edit .junie/skills/$TECH_NAME/SKILL.md to add specific rules (source of truth)."
echo "2. Add the technology to .junie/guidelines.md (optional for core tech)."
echo "3. Update README.md (Tech Stack Covered) and .aiassistant/rules/project-rules.md Standards Map if needed."
echo "4. Run ./scripts/check-command-parity.sh to validate."
