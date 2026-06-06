#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$HOME/Softwareprojekte"
LOG="$SCRIPT_DIR/status.log"

BLUE=$'\033[1;34m'
RED=$'\033[1;31m'
RESET=$'\033[0m'

repos=(
  "HEIZUNGSSTEUERUNG:$BASE_DIR/Arduinoprojekte/Heizungssteuerung_git"
  "AUTOPILOT:$BASE_DIR/Arduinoprojekte/Autopilot_git"
  "CONFIGS:$BASE_DIR/myconfig_git"
  "QMK:$BASE_DIR/qmk_keyboard_flow"
  "STUDIUM:$BASE_DIR/Studium_git"
  "COMMITMESSAGE:$BASE_DIR/commitmessage"
  "OPENAI:$BASE_DIR/openai_git"
  "SCRIPTS:$BASE_DIR/scripts_git"
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
