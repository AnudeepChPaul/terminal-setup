source ~/.config/fish/env.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
  bind \cf find_directories
  bind \cg tmux_manager
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

function v -d "Neovim"
  nvim $argv
end

function vi -d "Neovim"
  nvim $argv
end

function find_directories -d "Find directories interactive mode"
  find . -type d -maxdepth 1 -mindepth 1 | fzf --preview "$FZF__SMART__PREVIEW__COMMAND" \
    --prompt "Find Directory> " --ansi \
    --bind 'ctrl-d:reload(find . -type d -maxdepth 1 -mindepth 1)+change-prompt(Find Directory> )' \
    --bind 'ctrl-a:reload(find . -maxdepth 1 -mindepth 1)+change-prompt(Find All> )' \
    --bind 'ctrl-l:reload(ls -alp)+change-prompt(ls mode> )' \
    --bind 'ctrl-f:reload(find . -type f)+change-prompt(Find files> )' \
    --header '/ D: Directory | A: All | L: ls mode | F: Files | O: Execute' | read foo
  
  if test -z "$foo"
    commandline ''
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
  tmux split-window -h -p 40
end

function _tn -d "Create or attach into a tmux session" -a session_name session_dir
  if test -z $session_name
    builtin echo "Session name don't exists"
    return;
  end
  set applied_session_name $session_name

  builtin echo "Trying to handle tmux with $applied_session_name"
  set tmux_running (pgrep tmux)
  
  if test -z "$TMUX"; and test -z "$tmux_running";
    builtin echo "Tmux is running but not within a TMUX session"
    command tmux new-session -s $applied_session_name -c $session_dir
    commandline -f repaint
    return;
  end
  
  if not tmux has-session -t $applied_session_name 2> /dev/null
    builtin echo "Existing tmux session don't exists! Creating a new session"
    command tmux new-session -s $applied_session_name -c $session_dir
    commandline -f repaint
    return;
  end

  builtin echo "TMUX switch a client!"
  command tmux attach -dt $applied_session_name
  commandline -f repaint
  # if not command tmux switch-client -t Main 2> /dev/null
  #   builtin echo "Attaching to client"
  # end
end


function tmux_manager
  if test -z $PROJECTS_DIR
    commandline -f repaint
    return;
  end
  
  find $PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d | fzf --preview "$FZF__DIR__PREVIEW__COMMAND" | read selected_item

  basename "$selected_item" 2> /dev/null | tr . _ | read selected_dir
  
  if test -z "$selected_dir"
    commandline -f repaint
    return;
  end

  builtin cd $selected_item
  builtin echo "Changed Dir"
  commandline "_tn $selected_dir $selected_item" 
  commandline -f execute
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

