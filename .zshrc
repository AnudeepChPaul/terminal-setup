#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  zsh-nvm
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  fast-syntax-highlighting 
  dotbare
)

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true

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

eval "$(zoxide init zsh)"
source ~/.zprofile

# _dotbare_completion_cmd

zle -N _tmux_manager
zle -N h
zle -N _tmux_smart_attach_

bindkey -s "^y" '_tmux_manager^M'
bindkey -s "^h" 'h^M'
bindkey -s "^t" '_tmux_smart_attach_^M'
bindkey '^[OM' accept-line
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey -M menuselect '\r' .accept-line


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


