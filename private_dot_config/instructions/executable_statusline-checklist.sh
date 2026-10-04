#!/bin/sh
status_json=$(cat)
compact_threshold=20

model_name=$(printf '%s' "$status_json" | jq -r '.model.display_name // empty' 2>/dev/null)
session_id=$(printf '%s' "$status_json" | jq -r '.session_id // empty' 2>/dev/null)
context_percent=$(printf '%s' "$status_json" | jq -r '.context_window.used_percentage // empty | if type == "number" then floor else . end' 2>/dev/null)

write_context_percent() {
  [ -n "$1" ] && [ -n "$2" ] || return 0
  mkdir -p "$HOME/.claude/context"
  printf '%s' "$2" > "$HOME/.claude/context/$1.pct"
}

compact_warning() {
  [ -n "$context_percent" ] && [ "$context_percent" -ge "$compact_threshold" ] && printf ' · ⚠ ctx %s%% · run /compact' "$context_percent"
}

current_tier() {
  tier_file="$HOME/.claude/tier/$session_id"
  if [ -n "$session_id" ] && [ -f "$tier_file" ]; then cat "$tier_file"; else printf 'Lean'; fi
}

write_context_percent "$session_id" "$context_percent"
printf '%s · ' "$(current_tier)"

if [ -n "$TMUX_PANE" ]; then
  checklist_file="$HOME/.claude/checklists/${TMUX_PANE#%}.md"
else
  checklist_file="$HOME/.claude/checklists/$session_id.md"
fi
if [ ! -f "$checklist_file" ]; then
  if [ -n "$context_percent" ] && [ "$context_percent" -lt "$compact_threshold" ]; then
    printf '%s · ctx %s%%' "$model_name" "$context_percent"
  else
    printf '%s' "$model_name"
  fi
  compact_warning
  exit 0
fi

total_count=$(grep -cE '^[0-9]+\. (☐|☑)' "$checklist_file")
done_count=$(grep -cE '^[0-9]+\. ☑' "$checklist_file")
next_item=$(grep -m1 -E '^[0-9]+\. ☐' "$checklist_file" | sed -E 's/^[0-9]+\. ☐ //')
if [ -n "$next_item" ]; then
  printf '%s/%s ☑ · next: %s' "$done_count" "$total_count" "$next_item"
else
  printf '%s/%s ☑ · done' "$done_count" "$total_count"
fi
compact_warning
exit 0
