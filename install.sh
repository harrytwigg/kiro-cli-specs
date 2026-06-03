#!/usr/bin/env bash
# kiro-cli-specs installer
# Installs Kiro spec agents into ~/.kiro/agents/
set -euo pipefail

REPO="harrytwigg/kiro-cli-specs"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/agents"
INSTALL_DIR="${HOME}/.kiro/agents"

AGENTS=(
  "requirement-detailer.json"
  "spec-bugfix.json"
  "spec-design.json"
  "spec-fast-plan.json"
  "spec-orchestrator.json"
  "spec-requirements.json"
  "spec-task-executor.json"
  "spec-tasks.json"
)

PROMPTS=(
  "requirement-detailer.md"
  "spec-bugfix.md"
  "spec-design.md"
  "spec-fast-plan.md"
  "spec-orchestrator.md"
  "spec-requirements.md"
  "spec-task-executor.md"
  "spec-tasks.md"
)

echo ""
echo "  kiro-cli-specs installer"
echo "  ========================"
echo ""

# Detect existing agents (read from /dev/tty so this works when piped via curl | bash)
if [ -d "${INSTALL_DIR}" ] && compgen -G "${INSTALL_DIR}/*.json" > /dev/null 2>&1; then
  echo "⚠️  Existing agents detected in ${INSTALL_DIR}:"
  echo ""
  for f in "${INSTALL_DIR}"/*.json; do
    name=$(basename "$f" .json)
    echo "     • ${name}"
  done
  echo ""
  printf "  Reinstall and override them? [y/N] " >&2
  read -r REPLY </dev/tty
  echo ""
  if [[ ! "${REPLY}" =~ ^[Yy]$ ]]; then
    echo "  Installation cancelled. No files were changed."
    echo ""
    exit 0
  fi
fi

mkdir -p "${INSTALL_DIR}/prompts"

echo "  Installing to ${INSTALL_DIR} ..."
echo ""

for agent in "${AGENTS[@]}"; do
  if curl -fsSL "${BASE_URL}/${agent}" -o "${INSTALL_DIR}/${agent}"; then
    echo "  ✓  ${agent}"
  else
    echo "  ✗  Failed to download ${agent}" >&2
    exit 1
  fi
done

for prompt in "${PROMPTS[@]}"; do
  if curl -fsSL "${BASE_URL}/prompts/${prompt}" -o "${INSTALL_DIR}/prompts/${prompt}"; then
    echo "  ✓  prompts/${prompt}"
  else
    echo "  ✗  Failed to download prompts/${prompt}" >&2
    exit 1
  fi
done

echo ""
echo "  ✅ Done! ${#AGENTS[@]} agents installed to ${INSTALL_DIR}"
echo ""
echo "  Usage:"
echo ""
echo "    Start chat with a specific agent directly:"
echo "      kiro-cli chat --agent spec-orchestrator"
echo "      kiro-cli chat --agent spec-fast-plan"
echo "      kiro-cli chat --agent spec-bugfix"
echo ""
echo "    Or launch kiro-cli and select an agent interactively:"
echo "      kiro-cli"
echo "      then type: /agent"
echo ""
echo "    List all available agents:"
echo "      kiro-cli agent list"
echo ""
