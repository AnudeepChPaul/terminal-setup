if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar";
set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX";
set -q PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set -gx FZF_DEFAULT_OPTS "--tac --layout=reverse --info=inline --border --margin=1 --padding=1 --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'"
set -gx FZF_DEFAULT_COMMAND "ls -a"
set -gx FZF__PREVIEW__COMMAND 'bat --style=numbers --color=always --line-range :500 {}'
set -gx FZF__DIR__PREVIEW__COMMAND 'tree -aC -I "$TREE__GLOBAL_IGNORE" {} | head -700'
set -gx TREE__GLOBAL_IGNORE ".git|node_modules|.history|webpack|.next|.idea|.gradle|.vscode"
set -gx FZF__SMART__PREVIEW__COMMAND "[ -d {} ] && $FZF__DIR__PREVIEW__COMMAND || $FZF__PREVIEW__COMMAND"

# aliases
alias g git
command -qv nvim && alias vim nvim
alias c "clear"
alias .. "cd .."
alias sc "code"
alias s "sudo"
alias sn "sudo nano"
alias sv "sudo nvim"
alias v "nvim"
alias g "git"
alias gc "git clone"
alias d3 "cd $HOME/Projects"
alias conf "sv -O ~/.zprofile ~/.zshrc"
alias de "docker exec -u root -it"
alias dils "docker image ls"
alias dvls "docker volume ls"
alias dcls "docker container ls"
alias dnls "docker network ls"
alias dirm "docker image rm"
alias dvrm "docker volume rm"
alias dcrm "docker container rm"
alias dnrm "docker network rm"
alias dira 'docker image rm $(docker image ls -q)'
alias dvra 'docker volume rm $(docker volume ls -q)'
alias dcra 'docker container rm $(docker container ls -q)'
alias dnra 'docker network rm $(docker network ls -q)'
alias o "ack --sort-files --color"
alias l "ls -alp"
alias vg 'lazygit'



function ll -d "Uses exa to return dirs & files"
  exa --all --long --header $argv
end

function v -d "Neovim"
  nvim $argv
end

function vi -d "Neovim"
  nvim $argv
end

function find_directories -d "Find directories" 
  set depth 1
  set found_directory (find . -type d -maxdepth $depth -name '*'| fzf --preview "$FZF__DIR__PREVIEW__COMMAND")

  if test -n "$found_directory"
    cd "$found_directory"
  end
end

load_nvm > /dev/stderr
