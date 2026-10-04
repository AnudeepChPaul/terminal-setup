#!/usr/bin/env bash
# curl -fsSL https://anudeepchpaul.github.io/kickstart.sh | bash
set -euo pipefail

readonly dotfiles_remote="git@github.com:AnudeepChPaul/terminal-setup.git"
readonly dotfiles_source_dir="$HOME/.local/share/chezmoi"
readonly mise_key_fingerprint="24853EC9F655CE80B48E6C3A8B81C9D17413A06D"
readonly mise_docs_url="https://raw.githubusercontent.com/jdx/mise/main/docs/installing-mise.md"
readonly mise_bin="$HOME/.local/bin/mise"

platform=""
gh_freshly_authenticated=0

log() { printf '\033[36m▸\033[0m %s\n' "$*"; }
die() { printf '\033[31m✗\033[0m %s\n' "$*" >&2; exit 1; }

detect_platform() {
  case "$(uname -s)" in
    Darwin)
      [ "$(uname -m)" = "arm64" ] || die "only Apple Silicon Macs are supported"
      platform="macos" ;;
    Linux)
      if command -v apt-get >/dev/null; then platform="apt"
      elif command -v zypper >/dev/null; then platform="zypper"
      elif command -v pacman >/dev/null; then platform="pacman"
      else die "unsupported Linux distro (need apt, zypper or pacman)"; fi ;;
    *) die "unsupported OS: $(uname -s)" ;;
  esac
  log "platform: $platform"
}

install_prereqs() {
  local missing_commands=()
  local required_command
  for required_command in curl git gpg ssh-keygen; do
    command -v "$required_command" >/dev/null || missing_commands+=("$required_command")
  done
  if [ ${#missing_commands[@]} -eq 0 ]; then
    log "prerequisites already installed"
    return
  fi
  log "installing missing prerequisites: ${missing_commands[*]}"
  local package_names=()
  for required_command in "${missing_commands[@]}"; do
    case "$platform:$required_command" in
      macos:gpg) package_names+=(gnupg) ;;
      macos:curl|macos:ssh-keygen) die "$required_command missing from macOS base system" ;;
      apt:gpg) package_names+=(gnupg) ;;
      apt:ssh-keygen) package_names+=(openssh-client) ;;
      zypper:gpg) package_names+=(gpg2) ;;
      zypper:ssh-keygen) package_names+=(openssh-clients) ;;
      pacman:gpg) package_names+=(gnupg) ;;
      pacman:ssh-keygen) package_names+=(openssh) ;;
      *) package_names+=("$required_command") ;;
    esac
  done
  case "$platform" in
    macos)
      if [ ! -x /opt/homebrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      eval "$(/opt/homebrew/bin/brew shellenv)"
      brew install "${package_names[@]}" ;;
    apt) sudo apt-get update && sudo apt-get install -y "${package_names[@]}" ;;
    zypper) sudo zypper --non-interactive install "${package_names[@]}" ;;
    pacman) sudo pacman -Sy --needed --noconfirm "${package_names[@]}" ;;
  esac
}

verify_mise_installer() {
  local fingerprint="$1" work_dir="$2" gpg_status
  rm -f "$work_dir/install.sh"
  GNUPGHOME="$work_dir/gnupg" gpg --batch --quiet --keyserver hkps://keys.openpgp.org --recv-keys "$fingerprint" 2>/dev/null || return 1
  gpg_status="$(GNUPGHOME="$work_dir/gnupg" gpg --batch --status-fd 1 --output "$work_dir/install.sh" --decrypt "$work_dir/install.sh.sig" 2>/dev/null)" || return 1
  grep -q "^\[GNUPG:\] VALIDSIG $fingerprint " <<<"$gpg_status"
}

fetch_mise_fingerprint() {
  curl -fsSL --retry 3 --retry-all-errors --max-time 20 "$mise_docs_url" 2>/dev/null | grep -oE -- '--recv-keys [0-9A-F]{40}' | head -1 | awk '{print $2}' || true
}

install_mise_verified() {
  if [ -x "$mise_bin" ]; then
    log "mise already installed: $("$mise_bin" --version)"
    return
  fi
  log "installing mise (gpg verified)"
  local work_dir
  work_dir="$(mktemp -d)"
  mkdir -m 700 "$work_dir/gnupg"
  curl -fsSL -o "$work_dir/install.sh.sig" https://mise.jdx.dev/install.sh.sig
  if ! verify_mise_installer "$mise_key_fingerprint" "$work_dir"; then
    local fresh_fingerprint
    fresh_fingerprint="$(fetch_mise_fingerprint)"
    [ -n "$fresh_fingerprint" ] && [ "$fresh_fingerprint" != "$mise_key_fingerprint" ] \
      || die "mise installer not signed by $mise_key_fingerprint and no new key found"
    log "mise signing key changed: $fresh_fingerprint"
    verify_mise_installer "$fresh_fingerprint" "$work_dir" \
      || die "mise installer not signed by $fresh_fingerprint either"
  fi
  sh "$work_dir/install.sh"
  rm -rf "$work_dir"
}

gh() { "$mise_bin" x gh@latest -- gh "$@"; }

install_gh() {
  if "$mise_bin" where gh@latest >/dev/null 2>&1; then
    log "gh already installed via mise"
    return
  fi
  log "installing gh via mise"
  "$mise_bin" install gh@latest
}

ensure_gh_scopes() {
  local granted_scopes missing_scopes=() required_scope
  granted_scopes="$(gh auth status --hostname github.com 2>&1 | grep -i 'token scopes' || true)"
  for required_scope in admin:public_key admin:ssh_signing_key; do
    grep -q "'$required_scope'" <<<"$granted_scopes" || missing_scopes+=("$required_scope")
  done
  if [ ${#missing_scopes[@]} -gt 0 ]; then
    log "requesting missing gh scopes: ${missing_scopes[*]}"
    gh auth refresh --hostname github.com --scopes "$(IFS=,; echo "${missing_scopes[*]}")" </dev/tty
  fi
}

github_has_key() {
  local key_body="$1" key_type="$2"
  gh ssh-key list 2>/dev/null | awk -v body="$key_body" -v type="$key_type" 'index($0, body) && $NF == type {found=1} END {exit !found}'
}

setup_git_auth() {
  local ssh_key="$HOME/.ssh/id_ed25519"
  if [ ! -f "$ssh_key" ]; then
    log "generating ssh key"
    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$(whoami)@$(hostname -s)" -f "$ssh_key" -N ""
  fi
  if ! gh auth status --hostname github.com >/dev/null 2>&1; then
    log "authenticating with GitHub"
    gh auth login --hostname github.com --git-protocol ssh --web \
      --scopes admin:public_key,admin:ssh_signing_key,gist </dev/tty
    gh_freshly_authenticated=1
    ensure_gh_scopes
    local public_key_body
    public_key_body="$(awk '{print $2}' "$ssh_key.pub")"
    if ! github_has_key "$public_key_body" authentication; then
      log "uploading ssh authentication key to GitHub"
      gh ssh-key add "$ssh_key.pub" --type authentication --title "$(hostname -s)"
    fi
  else
    log "gh already authenticated, skipping GitHub key setup"
  fi
  ssh-keygen -F github.com >/dev/null 2>&1 || ssh-keyscan github.com >>"$HOME/.ssh/known_hosts" 2>/dev/null
}

setup_signing() {
  local ssh_public_key="$HOME/.ssh/id_ed25519.pub"
  if [ "$gh_freshly_authenticated" -eq 1 ]; then
    local public_key_body
    public_key_body="$(awk '{print $2}' "$ssh_public_key")"
    if ! github_has_key "$public_key_body" signing; then
      log "registering ssh signing key on GitHub"
      gh ssh-key add "$ssh_public_key" --type signing --title "$(hostname -s) signing"
    fi
  fi
  local local_git_config="$HOME/.config/git/config.local"
  local git_name git_email git_signing_key
  git_name="$(git config --global --includes user.name || true)"
  git_email="$(git config --global --includes user.email || true)"
  git_signing_key="$(git config --global --includes user.signingkey || true)"
  if [ -n "$git_name" ] && [ -n "$git_email" ] && [ -n "$git_signing_key" ]; then
    log "git identity already configured"
    return
  fi
  mkdir -p "$(dirname "$local_git_config")"
  if [ -z "$git_name" ]; then
    read -r -p "git user.name: " git_name </dev/tty
    git config --file "$local_git_config" user.name "$git_name"
  fi
  if [ -z "$git_email" ]; then
    read -r -p "git user.email: " git_email </dev/tty
    git config --file "$local_git_config" user.email "$git_email"
  fi
  [ -n "$git_signing_key" ] || git config --file "$local_git_config" user.signingkey "$ssh_public_key"
}

chezmoi() { "$mise_bin" x chezmoi@latest -- chezmoi "$@"; }

clone_dotfiles() {
  if [ -d "$dotfiles_source_dir/.git" ]; then
    log "dotfiles already cloned at $dotfiles_source_dir"
    return
  fi
  log "cloning dotfiles into $dotfiles_source_dir"
  chezmoi init "$dotfiles_remote" </dev/tty
  local backup_dir
  backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
  chezmoi managed --include=files,symlinks | while read -r managed_path; do
    if [ -e "$HOME/$managed_path" ] || [ -L "$HOME/$managed_path" ]; then
      mkdir -p "$backup_dir/$(dirname "$managed_path")"
      mv "$HOME/$managed_path" "$backup_dir/$managed_path"
    fi
  done
  [ -d "$backup_dir" ] && log "backed up conflicting files to $backup_dir"
  chezmoi apply --force
}

run_bootstrap() {
  log "running mise bootstrap"
  cd "$HOME"
  "$mise_bin" trust "$HOME/mise.bootstrap.toml"
  GITHUB_TOKEN="$(gh auth token --hostname github.com)"
  export GITHUB_TOKEN
  MISE_ENV=bootstrap "$mise_bin" bootstrap --yes
}

main() {
  detect_platform
  install_prereqs
  install_mise_verified
  install_gh
  setup_git_auth
  setup_signing
  clone_dotfiles
  run_bootstrap
  printf '\033[32m✓\033[0m done, open a new shell\n'
}

main "$@"
