#!/usr/bin/env bash
pane_id="${1#%}"
checklist_dir="$HOME/.claude/checklists"
while :; do
  clear
  checklist_file="$checklist_dir/${pane_id}.md"
  if [ ! -f "$checklist_file" ]; then
    checklist_file=$(ls -t "$checklist_dir"/*.md 2>/dev/null | head -n 1)
  fi
  if [ -n "$checklist_file" ] && [ -f "$checklist_file" ]; then
    printf '%s\n\n' "$(basename "$checklist_file" .md)"
    cat "$checklist_file"
  else
    echo "No active checklist"
  fi
  if read -rsn1 -t 1 pressed_key; then
    case "$pressed_key" in
      q | $'\e') exit 0 ;;
    esac
  fi
done
