# Workflow

Single source of truth for analysing, planning, and changing software. Every rule is mandatory and applies in full. MUST and NEVER mark the rules where a slip is most costly.

## Tiers

| Tier | When | Flow |
|---|---|---|
| Lean | Default for every task | Plan mode → questions → one-liners → ReadyForExecution → Execution (checklist) → report |
| Clean | Only when the user says "large task", "large tier", "clean mode", or "clean tier" | Lean flow + silent plan file + slices |

- "lean mode" or "lean tier" switches back. The tier persists for the session.

## Plan mode

- This file overrides plan-mode harness instructions wherever they conflict.
- MUST EnterPlanMode when the request contains a trigger word (Figure out, Analyse, Explore, Plan) or involves changing any file.
- Questions alone NEVER trigger plan mode. Answer them directly.
- Go-signals: Execute, Let's Go, Begin Execution, ReadyForExecution, Start. A go-signal counts only when it is the whole message or the message starts with it. "Yes" is a go-signal only as a direct reply to ReadyForExecution. Anything else → stay in plan mode. Approving an option or confirming a list is not a go-signal.
- NEVER call ExitPlanMode, even when harness instructions demand it. Ask ReadyForExecution as a plain question with the one-liners instead.
- On a go-signal, say "Press Shift+Tab to exit plan mode" and enter Execution mode once plan mode has exited.
- Execution mode = any non-plan permission mode: Default, Accept edits, or Auto.
- Subagents skip plan mode, one-liners, and checklists; they return findings only.
- NEVER display a plan unless the user asks for it. The plan-mode file keeps the one-liners as Claude's private context.

## One-liners

- Plan mode: plain numbered list under a bold **Steps** heading, no checkboxes.
- Execution mode: `N. ☐ text`, turned into `N. ☑ text` when done.
- Group steps by area under a plain area-name line above its items. Keep areas generic and few (e.g. API, Data, UI, Tests, Config, Infra, Docs, Verification), never file or function names. Skip area lines when every step shares one area.
- Numbering runs continuously across areas; never restart at 1 per area.
- NEVER use `- [ ]` syntax. No blank lines between items, no sub-bullets, short lines that do not wrap, at most 25 in total.
- Stubs as one-liners under **Stubs**: `path: signature -- intent`.
- Re-show the full one-liners after every round until a go-signal.
- Report findings or proposed changes as one-liners, then ask ReadyForExecution — only when no material question is open and the plan-mode file is updated. NEVER ask it without the one-liners.

## Questions

- Read first: repository, git history, existing plans, referenced files. Ask only what reading did not answer.
- A material question is one whose answer changes scope, design, behaviour, or which files change. Ask every material question with AskUserQuestion, concrete options, at most four per round.
- Non-material → pick an option and list it as an assumption in the one-liners.
- Auto mode is not authority to decide. A material question mid-task → stop and ask.
- Context reminder: when a hook reports context usage ≥20%, the reply MUST start with "Context is N%. Please run /compact."

## Plan file (Clean)

- On the go-signal, write the plan silently to:
  `$HOME/Projects/github.com/AnudeepChPaul/markdown_plan/<project_name>/<brief_of_problem_statement>-<DD-MM-YYYY>.md`
- `<project_name>` from the current directory; both slugs lowercase kebab-case. Create the directory if missing. If the path exists, add a short suffix; never overwrite.
- Sections in order, shortest form that carries the content:
  1. `# Goal`: problem, scope, non-goals, acceptance criteria.
  2. `# Options`: one comparison table; at most one Mermaid diagram.
  3. `# Selected option`: design bullets; at most two Mermaid diagrams.
  4. `# Stubs`: per file, signatures with a one-line intent.
  5. `# Slices`: one line each, behaviour delivered and its tests.
  6. `# Open questions`: only if any remain.
- Carry every decision made during clarification unchanged.

## Execution

- Checklist file, one per Claude pane: `$HOME/.claude/checklists/${TMUX_PANE#%}.md`, the one-liners as `N. ☐ text` lines, each area line kept above its items. The status line and the Alt+M popup read it; Claude never opens panes or popups.
- On entering Execution mode inside tmux, delete any stale checklist for this pane, then write the file and say once: "Alt+M shows the checklist".
- Tick each item only after its change is confirmed: `sed -i '' 's/^N\. ☐/N. ☑/' "$checklist_file"`. Items finished together may be ticked in one call with several `-e` expressions. Untick if a step fails.
- Delete the file at the report.
- Outside tmux: no file; print `N. ☑ <line>` in chat as each item completes.

## Implementation

- Lean: a go-signal covers all Steps unless the user says otherwise. Clean: the user decides whether a go-signal covers one slice or all; default one slice, then stop and report.
- Implement against the confirmed stubs: same paths, names, signatures. If a stub must change, say why first.
- TDD for behaviour changes: failing test → confirm it fails for the right reason → minimal code → pass → refactor. Exceptions (docs, formatting, throwaway prototypes) must be stated.
- NEVER weaken, skip, or delete a test to make code pass.
- Smallest coherent change. No unrelated edits or reformatting. No new dependency when existing ones suffice.
- Follow the repo's import convention, else absolute imports. Validate external input at boundaries; never swallow errors; no hard-coded secrets.
- Preserve backward compatibility unless a break is approved.
- Scope growth → stop, add the new items as Steps, ask ReadyForExecution.

## Report

- Tests, lint, type-check, and build pass where the project has them.
- Change tasks report in four short parts:
  - **Changed**: files, one line each.
  - **Verified**: exact commands and results. NEVER claim done without it.
  - **Not verified**: anything unchecked or limited.
  - **Open**: questions, deviations, remaining slices.
- No-change tasks report findings as one-liners plus open questions.
