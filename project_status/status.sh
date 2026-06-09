#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$HOME/projects"
LOG="$SCRIPT_DIR/status.log"

BLUE=$'\033[1;34m'
RED=$'\033[1;31m'
RESET=$'\033[0m'

repos=(
  "HEATER:$BASE_DIR/embedded/heatingControl"
  "AUTOPILOT:$BASE_DIR/embedded/autopilot"
  "DOTFILES:$BASE_DIR/dotfiles"
  "QMK:$BASE_DIR/qmk_keyboard_flow"
  "STUDY:$BASE_DIR/study"
  "COMMITMESSAGE:$BASE_DIR/commitmessage"
  "OPENAI:$BASE_DIR/openai_git"
  "SCRIPTS:$BASE_DIR/scripts"
)

: > "$LOG"

for repo in "${repos[@]}"; do
  name="${repo%%:*}"
  path="${repo#*:}"

  {
    printf '\n%s========== %s ==========%s\n' "$BLUE" "$name" "$RESET"

    if [[ -d "$path/.git" ]]; then
      git -C "$path" -c color.status=always status
    else
      printf '%sNot a git repository: %s%s\n' "$RED" "$path" "$RESET"
    fi
  } >> "$LOG"
done

cat "$LOG"
