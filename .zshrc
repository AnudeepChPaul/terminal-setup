#!/bin/zsh

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="dracula-pro"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  # zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  fast-syntax-highlighting
  dotbare
  zsh-nvm
)

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
export NVM_NO_USE=false

source $ZSH/oh-my-zsh.sh

# Sets cursor to blinking block
echo '\e[5 q'

zstyle ':completion:*' file-sort modification
zstyle :compinstall filename '/Users/anudeepchandrapaul/.zshrc'
zstyle '*:compinit' arguments -D -i -u -C -w
autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=16000
setopt autocd extendedglob

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

source ~/.zprofile
eval "$(zoxide init zsh)"

_dotbare_completion_cmd

zle -N _tmux_manager
zle -N h
zle -N _tmux_smart_attach_

bindkey -s "^y" '_tmux_manager^M'
bindkey -s "^h" 'h^M'
bindkey -s "^t" '_tmux_smart_attach_^M'
bindkey '^[OM' accept-line
# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# bindkey -M menuselect '\r' .accept-line

eval "$(starship init zsh)"
# nvm use default

alias node="$HOME/.nvm/versions/node/v18.17.1/bin/node"
