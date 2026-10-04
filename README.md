# terminal-setup

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's inside

| Area | Tools |
| --- | --- |
| Shell | zsh, starship, atuin, fzf, mise |
| Terminal | ghostty, kitty, alacritty, tmux |
| Editor | neovim |
| Files & search | yazi, broot, television |
| Window management | AeroSpace, Karabiner-Elements |
| Text expansion | espanso |
| Git | delta, SSH commit signing |

## Bootstrap a new machine

```sh
brew install chezmoi
chezmoi init --apply AnudeepChPaul/terminal-setup
```

`init` asks for the git signing email, then asks once for the passphrase that unlocks the age key.

## Secrets

- Secrets are encrypted with [age](https://age-encryption.org/) and stored as `encrypted_*.age`.
- The age key lives in `key.txt.age`, protected by a passphrase, and is restored to `~/.config/chezmoi/key.txt` on first apply.
- Add a secret with `chezmoi add --encrypt <file>`.
- A gitleaks pre-commit hook in `.githooks/` scans every commit. If it finds a secret, it encrypts the file, commits the encrypted copy, and pushes.
- Machine-specific settings stay out of the repo in `~/.ssh/config.local` and `~/.config/git/config.local`.

## Keeping in sync

- `chezmoi edit <file>` edits the source and applies it.
- `chezmoi re-add` pulls in changes made directly to live files.
- A launchd agent checks `chezmoi status` every 5 minutes; the starship prompt shows `⟳ N` when N files are out of sync.

## AeroSpace keys

| Keys | Action |
| --- | --- |
| `ctrl-alt-h/j/k/l` | Focus window |
| `ctrl-alt-shift-h/j/k/l` | Move window |
| `alt-1..9`, `alt-t` | Switch workspace |
| `ctrl-alt-shift-1..9` | Move window to workspace |
| `ctrl-alt-/` | Toggle tiles horizontal/vertical |
| `ctrl-alt-,` | Toggle accordion |
| `ctrl-alt-shift-space` | Toggle floating |
| `ctrl-alt-shift-f` | Fullscreen |
| `ctrl-alt-esc` | Reload config |
| `ctrl-alt-shift-;` | Service mode |
