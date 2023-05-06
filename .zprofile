export BASH_SILENCE_DEPRECATION_WARNING=1

# setting up PATH variables
export GO_PATH=$HOME/go
export MAVEN_PATH=$HOME/bin/apache-maven-3.8.6/
export PYTHON_PATH=/usr/local/bin/python
export PLATFORM_TOOLS_PATH="$HOME/bin/platform-tools"
export ROVER_HOME_PATH="$HOME/.rover"

export PATH=$PATH:$GO_PATH/bin:$HOME/bin:/usr/local/bin:$HOME/bin/redis-6.2.6/src:$PYTHON_PATH:$MAVEN_PATH/bin:$PLATFORM_TOOLS_PATH
export PATH="$PATH:$ROVER_HOME_PATH/bin:$HOME/__bin__/apache-maven-3.9.1/apache-maven/src/bin"

export GHQ_ROOT="$HOME/Projects"

# Homebrew setup
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/opt/local/share/man:$MANPATH"

which brew &> /dev/null && eval "$(`which brew` shellenv)"

export NVM_DIR="$HOME/.nvm";
export DOTBARE_DIR=$HOME/.cfg;
export DOTBARE_TREE=$HOME;

CUSTOM_FILE="$HOME/.custom_env";

if [[ -f "$CUSTOM_FILE" ]]; then
    source "$CUSTOM_FILE";
fi

# Setting up nvm
export NVM_DIR="$HOME/.nvm";
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; # This loads nvm

export FZF_DEFAULT_OPTS="--tac --layout=reverse --info=inline --border --margin=1 --padding=1 --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'";
export FZF_DEFAULT_COMMAND="ls -a";
export FZF__PREVIEW__COMMAND='bat --style=numbers --color=always --line-range :500 {}';
export FZF__DIR__PREVIEW__COMMAND='tree -aC -I "${TREE__GLOBAL_IGNORE}" {} | head -700';
export TREE__GLOBAL_IGNORE=".git|node_modules|.history|webpack|.next|.idea|.gradle|.vscode";
export FZF__SMART__PREVIEW__COMMAND="[ -d {} ] && $FZF__DIR__PREVIEW__COMMAND || $FZF__PREVIEW__COMMAND";
export HISTCONTROL=ignorespace:erasedups;

export EDITOR="nvim";

# Setting up aliases
alias c="clear";
alias ..="cd ..";
alias sc="code";
alias s="sudo";
alias sn="sudo nano";
alias sv="sudo nvim";
alias v="nvim";
alias gc="git clone";
alias d3="cd $HOME/Projects";
alias conf="sv -O ~/.zprofile ~/.zshrc";
alias de="docker exec -u root -it";
alias dils="docker image ls";
alias dvls="docker volume ls";
alias dcls="docker container ls";
alias dnls="docker network ls";
alias dirm="docker image rm";
alias dvrm="docker volume rm";
alias dcrm="docker container rm";
alias dnrm="docker network rm";
alias dira='docker image rm $(docker image ls -q)';
alias dvra='docker volume rm $(docker volume ls -q)';
alias dcra='docker container rm $(docker container ls -q)';
alias dnra='docker network rm $(docker network ls -q)';
alias o="ack --sort-files --color";
alias l="ls -alp";
alias vg='lazygit';
alias ll='exa --all --long --icons --header';
alias db="dotbare";
alias vi="nvim";
alias vim="nvim";

_uninstall_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)";
}

# Setting up shorthands for big boys
_r() {
    source ~/.zshrc;
    tmux source ~/.config/tmux/tmux.conf;
    echo "Reloaded!";
}

_f() {
    depth=$1;

    if [[ -z "$depth" ]]; then
         depth=1;
    fi

    dir=$(find . -type f -maxdepth $depth | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf --preview "${FZF__PREVIEW__COMMAND}");

    if [[ -f "$dir" ]]; then
        eval "v $dir";
    fi
}

_d() {
    input="$1";
    depth="$2";

    if [ -z "$depth" ]; then
        depth=1;
    fi

    dir=$(find . -type d -maxdepth $depth -name "*$input*" | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf --preview "$FZF__DIR__PREVIEW__COMMAND");
    cd "$dir";
}

_a() {
    input="$1";
    depth="$2";

    if [ -z "$depth" ]; then
        depth=2;
    fi

    dir=$(find . -maxdepth $depth -name "*$input*" | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf --preview "$FZF__SMART__PREVIEW__COMMAND");

    echo "$dir";

    if [[ -d $dir ]]; then
        eval "cd $dir";
    elif [[ -f $1 ]]; then
        eval "v $dir";
    else
        echo "$1 is not valid";
    fi
}


h() {
    cmd=$(history | fzf +s --tac | sed 's/ *[0-9]* *//');
    history $cmd;
    eval $cmd;
}

_i() {
    stat -f "%N -%z -%R" $1;
}

_port() {
    echo "LSOF";
    lsof -nP -i:$1;
    echo "NETSTAT";
    netstat -avn | grep $1;
}

_pid() {
   ps -ef | grep -v grep | grep -i "$1" | awk '{print $2}';
}


_cleanup_dc() {
    docker info;
    _dc down;
    docker container prune --force;
    docker image prune --all --force;
    # docker rm -f $(docker ps -a -q);
    docker volume prune --force;
}

_run_nginx() {
    nginx -s stop;
    nginx -c ~/Desktop/nginx_config/nginx.conf;
}

_tn() {
    session_name=$1;
    session_dir=$2;
    
    tmux new-session -s $session_name -c $session_dir -d 2> /dev/null; tmux attach -t $session_name 2> /dev/null || tmux switchc -t $session_name 2> /dev/null;
}

_ide () {
  tmux split-window -v -p 30;
  tmux split-window -h -p 40;
}

function zz () {
  dir_full_path=`z -l $1`;

  if [[ -z "$dir_full_path" ]]; then
   return;
  fi


  basename "$dir_full_path" 2> /dev/null | tr . _ | read dir_name;

  if [[ -z "$dir_name" ]]; then
    return;
  fi

  tmux new-session -s $dir_name -c $dir_full_path -d 2> /dev/null;
  sleep 1;
  tmux attach -t $dir_name 2> /dev/null || tmux switchc -t $dir_name 2> /dev/null;
}


function _tmux_manager() {
  if [[ -z "$PROJECTS_DIR" ]]; then
   return;
  fi
  ghq list -p | fzf-tmux -p -h 50% -w 70% | read dir_full_path

  basename "$dir_full_path" 2> /dev/null | tr . _ | read dir_name

  if [[ -z "$dir_name" ]]; then
    return;
  fi

  _tn $dir_name $dir_full_path
}

function aws-login() {  eval $( $OWL/bin/owl aws-login $@ ) ; };
function change-realm() {  eval $( $OWL/bin/owl change-realm $@ ) ; };
function aws-ec2() {
  LINES=${LINES} COLUMNS=${COLUMNS} ${OWL}/command/pellets/ec2/scripts/login-wrapper "${@}"
}


eval "$(pyenv init --path)"
source ~/.dotbare/dotbare.plugin.bash
