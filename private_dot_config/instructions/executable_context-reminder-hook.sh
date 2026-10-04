#!/bin/sh
compact_threshold=20
session_id=$(jq -r '.session_id // empty' 2>/dev/null)
[ -n "$session_id" ] || exit 0
context_file="$HOME/.claude/context/$session_id.pct"
[ -f "$context_file" ] || exit 0
context_percent=$(cat "$context_file")
[ "$context_percent" -ge "$compact_threshold" ] 2>/dev/null || exit 0
jq -n --arg percent "$context_percent" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    additionalContext: ("Context usage is " + $percent + "%. Start your reply with: \"Context is " + $percent + "%. Please run /compact.\"")
  }
}'
