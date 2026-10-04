#!/usr/bin/env bash
#
# Reproduce lazy.nvim's plugin tree, pinned to the commits in
# ~/.config/nvim/lazy-lock.json. zsh plugins come from .chezmoiexternal.toml.
#
#   bootstrap-plugins.sh            clean/install/restore
#   bootstrap-plugins.sh --fresh    delete the lazy dir first, then reinstall
#   bootstrap-plugins.sh --check    verify only; non-zero if anything drifts
#
# nvim uses `Lazy! restore`, not `sync`. restore checks out the commits in
# lazy-lock.json; sync would update to upstream HEAD and rewrite the lock, which
# is the opposite of reproducing a known state.
#
set -euo pipefail

NVIM_LAZY_DIR="${NVIM_LAZY_DIR:-$HOME/.local/share/nvim/lazy}"
NVIM_LOCK="${NVIM_LOCK:-$HOME/.config/nvim/lazy-lock.json}"

# name<TAB>commit for every entry in lazy-lock.json
nvim_lock_entries() {
  python3 -c '
import json, sys
for name, spec in sorted(json.load(open(sys.argv[1])).items()):
    print("%s\t%s" % (name, spec.get("commit", "")))
' "$NVIM_LOCK"
}

bootstrap_nvim() {
  command -v nvim >/dev/null || { echo "  nvim not found, skipping" >&2; return 0; }
  [[ -f "$NVIM_LOCK" ]] || { echo "  nvim lock not found: $NVIM_LOCK" >&2; return 1; }

  if [[ $fresh == 1 ]]; then
    printf '  %-26s removing %s\n' "nvim" "$NVIM_LAZY_DIR"
    rm -rf "$NVIM_LAZY_DIR"
  fi

  # clean drops plugins no longer in the spec. install clones what is missing,
  # which restore cannot do on its own — it skips anything not already installed.
  # restore then pins every plugin to the commit in lazy-lock.json.
  local cmd
  for cmd in clean install restore; do
    printf '  %-26s Lazy! %s\n' "nvim" "$cmd"
    nvim --headless "+Lazy! $cmd" +qa 2>&1 | grep -vE '^\s*$' | sed 's/^/      /' || true
  done
}

check_nvim() {
  [[ -f "$NVIM_LOCK" ]] || { echo "  nvim lock not found: $NVIM_LOCK" >&2; return 1; }
  local rc=0 name want dir have short
  while IFS=$'\t' read -r name want; do
    dir="$NVIM_LAZY_DIR/$name"
    have="$( [[ -d "$dir/.git" ]] && git -C "$dir" rev-parse HEAD 2>/dev/null || true )"
    if [[ "$have" != "$want" ]]; then
      short="<absent>"; [[ -n "$have" ]] && short="${have:0:7}"
      printf '  %-26s DRIFT: at %s, pinned %s\n' "$name" "$short" "${want:0:7}"
      rc=1
    else
      printf '  %-26s ok  %s\n' "$name" "${want:0:7}"
    fi
  done < <(nvim_lock_entries)
  return $rc
}

mode="install"
fresh=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check)  mode="check" ;;
    --nvim)   ;;
    --fresh)  fresh=1 ;;
    --help|-h) sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $1 (try --help)" >&2; exit 1 ;;
  esac
  shift
done

failed=0

echo "neovim plugins"
if [[ $mode == check ]]; then
  check_nvim || failed=1
else
  bootstrap_nvim || failed=1
fi

exit $failed
