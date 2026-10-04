# ---------------------------------------------------------------------------
# Standalone zsh setup (oh-my-zsh removed 2026-09-02).
# Reproduces the parts of omz that were actually in use: completion bootstrap,
# completion styles, ls/LS_COLORS, the directory + grep aliases, and the four
# plugins. Plugins now live in ~/.zsh/plugins, not ~/.oh-my-zsh/custom.
# ---------------------------------------------------------------------------
ZSH_PLUGINS="$HOME/.zsh/plugins"

# --- completion system -----------------------------------------------------
# fpath must include plugin completion dirs BEFORE compinit. zsh-completions is
# a pure fpath contributor: miss this and it silently does nothing.
fpath=(
  "$ZSH_PLUGINS/zsh-completions/src"
  $fpath
)

autoload -Uz compinit
# -C skips the security audit and the per-file recompile check. The dump is
# rebuilt once a day, which is when new completions actually appear.
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_zcompdump:h}"
_zcompdump_stale=( ${_zcompdump}(N.mh+24) )
if (( $#_zcompdump_stale )) || [[ ! -s $_zcompdump ]]; then
  compinit -d "$_zcompdump"
  touch "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump _zcompdump_stale

# Ported verbatim from oh-my-zsh/lib/completion.zsh — this is the behaviour
# that makes tab completion feel the way it does, and fzf-tab depends on it.
zmodload -i zsh/complist
WORDCHARS=''
unsetopt menu_complete flowcontrol
setopt auto_menu complete_in_word always_to_end
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select
# case-insensitive matching: `cd doc<tab>` still finds Documents
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# hide system accounts from user completion
zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache at avahi avahi-autoipd beaglidx bin \
  cacti canna clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm gkrellmd gopher hacluster \
  haldaemon halt hsqldb ident junkbust kdm ldap lp mail mailman mailnull man messagebus mldonkey mysql \
  nagios named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn operator pcap polkitd postfix \
  postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync \
  tftp usbmux uucp vcsa wwwrun xfs '_*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
zstyle '*' single-ignored show

# --- appearance (was lib/theme-and-appearance.zsh) --------------------------
autoload -U colors && colors
setopt prompt_subst
function diff { command diff --color "$@" }
export LSCOLORS="Gxfxcxdxbxegedabagacad"
: ${LS_COLORS:="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"}
export LS_COLORS
alias ls='ls -G'

# --- aliases that were in use from omz libs ---------------------------------
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
for i in {1..9}; do alias "$i"="cd -$i"; done; unset i
alias md='mkdir -p'
alias rd=rmdir
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'
alias _='sudo '
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias egrep='grep -E'
alias fgrep='grep -F'
(( $+commands[ack] )) && alias afind='ack -il'

# --- options that came from omz libs ---------------------------------------
# directories.zsh: autopushd is what makes the 1..9 and `-` aliases work at all.
setopt autopushd pushdignoredups pushdminus
# history.zsh (share_history is unset further down, as before)
setopt extendedhistory histexpiredupsfirst histignoredups histverify
# misc.zsh
setopt interactivecomments longlistjobs

# --- widgets + keys that came from omz/lib/key-bindings.zsh -----------------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
autoload -Uz bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

bindkey "^?" backward-delete-char          # backspace
bindkey "^[[Z" reverse-menu-complete       # shift-tab
bindkey "^[[1;5C" forward-word             # ctrl-right
bindkey "^[[1;5D" backward-word            # ctrl-left
bindkey "^[[3;5~" kill-word                # ctrl-delete
bindkey "^[[5~" up-line-or-history         # page up
bindkey "^[[6~" down-line-or-history       # page down
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# --- the few omz helper functions worth keeping ----------------------------
# `take` = mkdir -p + cd; `d` lists the dir stack the 1..9 aliases index into.
function take { mkdir -p "$@" && builtin cd "${@:$#}" }
function d { builtin dirs -v | head -10 }
alias mkcd=take
if (( $+commands[pbcopy] )); then
  function clipcopy { pbcopy < "${1:-/dev/stdin}" }
  function clippaste { pbpaste }
fi

# --- plugins ---------------------------------------------------------------
# Order matters: autosuggestions before syntax-highlighting, and
# syntax-highlighting last because it wraps ZLE widgets.
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh"
