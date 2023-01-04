if status is-interactive
    # Commands to run in interactive sessions can go here
  bind \cf find_immediate_directories
end

set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar";
set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX";
set -q PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

set -gx TERM xterm-256color

# theme
set -gx theme_color_scheme terminal-dark
set -gx fish_prompt_pwd_dir_length 1
set -gx theme_display_user yes
set -gx theme_hide_hostname no
set -gx theme_hostname always

set -gx GHQ_ROOT "$HOME/Projects"

set -gx FZF_DEFAULT_OPTS "--tac --layout=reverse --info=inline --border --margin=1 --padding=1 --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'"
set -gx FZF_DEFAULT_COMMAND "ls -a"
set -gx FZF__PREVIEW__COMMAND 'bat --style=numbers --color=always --line-range :500 {}'
set -gx FZF__DIR__PREVIEW__COMMAND 'tree -aC -I "$TREE__GLOBAL_IGNORE" {} | head -700'
set -gx TREE__GLOBAL_IGNORE ".git|node_modules|.history|webpack|.next|.idea|.gradle|.vscode|.Trash"
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

function _uninstall_homebrew -d "script to uninstall homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
end

function ll -d "Uses exa to return dirs & files"
  exa --all --long --header $argv
end

function v -d "Neovim"
  nvim $argv
end

function vi -d "Neovim"
  nvim $argv
end

function find_immediate_directories -d "Ls into directories with fuzzy search"
  ls -aA |  egrep -v "$TREE__GLOBAL_IGNORE" | fzf --preview "$FZF__DIR__PREVIEW__COMMAND" | read foo
  
  if test $foo
    builtin cd "$foo"
    commandline -r ''
    commandline -f repaint
  else
    commandline ''
  end
end

function find_directories -d "Find directories" -a input depth
  if test -n "$depth"
    set ndepth "$depth"
  else 
    set ndepth "1"
  end


  if test "$input"
    set keyword "*$input*"
  else 
    set keyword "*"
  end

  find . -type d -maxdepth $ndepth -name $keyword | egrep -v "$TREE__GLOBAL_IGNORE" | fzf --preview "$FZF__DIR__PREVIEW__COMMAND" | read foo

  if test "$foo"
    builtin cd "$foo"
    commandline -r ""
    commandline -f repaint
  else
    commandline ''
  end
end

function _port -d "Find port with lsof & netstat" -a port_id
  echo "LSOF"
  lsof -nP -i:$port_id
  echo "NETSTAT"
  netstat -avn | grep $port_id
end

function _tn -d "Create or attach into a tmux session" -a session_name
  if test "$TMUX"
    tmux switch-client -t $session_name
  else 
    tmux new -s $session_name || tmux attach -t $session_name
  end
end

function _ide
  tmux split-window -v -p 30
  tmux split-window -h -p 40
end


function tmux_session_handler
  find ~/Projects -mindepth 1 -maxdepth 1 -type d | fzf --preview "$FZF__DIR__PREVIEW__COMMAND" | basename | tr . _ | read foo

  if test -n "$foo"
    exit 0
  end
  
  set selected_dir (basename "$foo" | tr . _)
  
  if test -n "$selected_dir"
    exit 0
  end

  if pggrep "tmux" 
    _tn "$selected_dir"
  end
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

