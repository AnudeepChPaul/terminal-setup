#!/bin/sh
hook_json=$(cat)
session_id=$(printf '%s' "$hook_json" | jq -r '.session_id // empty' 2>/dev/null)
prompt_text=$(printf '%s' "$hook_json" | jq -r '.prompt // empty' 2>/dev/null)
[ -n "$session_id" ] || exit 0
if printf '%s' "$prompt_text" | grep -qiE 'large (task|tier)|clean (mode|tier)'; then
  selected_tier=Clean
elif printf '%s' "$prompt_text" | grep -qiE 'lean (mode|tier)'; then
  selected_tier=Lean
else
  exit 0
fi
mkdir -p "$HOME/.claude/tier"
printf '%s' "$selected_tier" > "$HOME/.claude/tier/$session_id"
exit 0
