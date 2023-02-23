source ~/.config/fish/env.fish

if status is-interactive
  # Commands to run in interactive sessions can go here
  bind --erase --preset \cd
  bind \cf find_directories
  bind \cg tmux_manager
  bind \cs cheat.sh
  bind \cw h__
end


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
alias d3 "cd $GHQ_ROOT"
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

function h__ -d "History with fuzzy finder"
  commandline (history | fzf-tmux -p -h 40% -w 60%)
end

function v -d "Neovim"
  nvim $argv
end

function vi -d "Neovim"
  nvim $argv
end

function find_directories -d "Find directories interactive mode"
  find . -type d -maxdepth 1 -mindepth 1 | fzf-tmux -p --preview $FZF__SMART__PREVIEW__COMMAND \
    --prompt "Find Directory> " --ansi \
    --bind 'ctrl-d:reload(find . -type d -maxdepth 1 -mindepth 1)+change-prompt(Find Directory> )' \
    --bind 'ctrl-a:reload(find . -maxdepth 1 -mindepth 1)+change-prompt(Find All> )' \
    --bind 'ctrl-l:reload(ls -alp)+change-prompt(ls mode> )' \
    --bind 'ctrl-f:reload(find . -type f)+change-prompt(Find files> )' \
    --header '/ D: Directory | A: All | L: ls mode | F: Files' | read foo
  
  if test -z "$foo"
    commandline ''
    commandline -f repaint
    return
  else
    builtin cd "$foo"
    commandline -r ""
    commandline -f repaint
  end

  find_directories
end

function _port -d "Find port with lsof & netstat" -a port_id
  echo "LSOF"
  lsof -nP -i:$port_id
  echo "NETSTAT"
  netstat -avn | grep $port_id
end

function _ide
  tmux split-window -v -p 30
  tmux send-keys -t 1 'clear' Enter
  tmux split-window -h -p 50
  tmux send-keys -t 2 'clear' Enter
end

function _tn -d "Create or attach into a tmux session" -a session_name session_dir
  if test -z $session_name
    builtin echo "Session name don't exists"
    return;
  end
  set applied_session_name $session_name

  set tmux_running (pgrep tmux)
  
  if test -z "$TMUX"; and test -z "$tmux_running";
    command tmux new-session -s $applied_session_name -c $session_dir
    commandline -f repaint
    return;
  end
  
  if not tmux has-session -t $applied_session_name 2> /dev/null
    command tmux new-session -s $applied_session_name -c $session_dir -d
  end

  command tmux attach -t $applied_session_name || tmux switchc -t $applied_session_name;
  commandline -f repaint;
end


function tmux_manager
  if test -z "$PROJECTS_DIR"
    commandline -f repaint
    return;
  end
  
  ghq list -p | fzf-tmux -p -h 50% -w 70% | read selected_

  basename "$selected_" 2> /dev/null | tr . _ | read selected_dir
  
  if test -z "$selected_dir"
    commandline -f repaint
    return;
  end

  commandline "_tn $selected_dir $selected_" 
  commandline -f execute
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

