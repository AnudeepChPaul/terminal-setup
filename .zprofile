export BASH_SILENCE_DEPRECATION_WARNING=1

# Prezto Dir
# export ZDOTDIR=$HOME/.config/zsh;

# setting up PATH variables
export GO_PATH=$HOME/go
export MAVEN_PATH=$HOME/bin/apache-maven-3.8.8/
export PYTHON_PATH=/usr/local/bin/python
export PLATFORM_TOOLS_PATH="$HOME/bin/platform-tools"
export ROVER_HOME_PATH="$HOME/.rover"

export PATH=$PATH:$GO_PATH/bin:$HOME/bin:/usr/local/bin:$HOME/bin/redis-6.2.6/src:$PYTHON_PATH:$MAVEN_PATH/bin:$PLATFORM_TOOLS_PATH
export PATH="$PATH:$ROVER_HOME_PATH/bin:$HOME/__bin__/apache-maven-3.9.3/apache-maven/src/bin"

export GHQ_ROOT="$HOME/Projects"
export PNPM_HOME="/Users/anudeepchandrapaul/Library/pnpm"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Homebrew setup
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export MANPATH="/opt/local/share/man:$MANPATH"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Users/achandrapaul/.jenv/shims:${PATH}"
export PATH="${HOME}/.dotbare:${PATH}"
export PATH="$PNPM_HOME:${PATH}"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$HOME/Projects/github.com/mawww/kakoune/src"


export PYENV_ROOT="$HOME/.pyenv";
export NVM_DIR="$HOME/.nvm";
export DOTBARE_DIR=$HOME/.cfg;
export DOTBARE_TREE=$HOME;

CUSTOM_FILE="$HOME/.custom_env";

if [[ -f "$CUSTOM_FILE" ]]; then
    source "$CUSTOM_FILE";
fi

export FZF_DEFAULT_OPTS="--height=81% --tac --layout=reverse --info=inline --border --margin=0 --padding=1 --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'";
export FZF_DEFAULT_COMMAND="ls -a";
export FZF__PREVIEW__COMMAND='bat --style=numbers --color=always --line-range :500 {}';
export FZF__DIR__PREVIEW__COMMAND='tree -aC -I "${TREE__GLOBAL_IGNORE}" {} | head -700';
export TREE__GLOBAL_IGNORE="node_modules|.history|webpack|.next|.idea|.gradle|.vscode";
export FZF__SMART__PREVIEW__COMMAND="[ -d {} ] && $FZF__DIR__PREVIEW__COMMAND || $FZF__PREVIEW__COMMAND";
export HISTCONTROL=ignorespace:erasedups;

export TWILIO_API_DEFINITIONS_ROOT="${GHQ_ROOT}"/code.hq.twilio.com/twilio/api-definitions

#### ------------------------------
#### exa - Color Scheme Definitions
#### ------------------------------
export EXA_COLORS="\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:"

# Setting up aliases
alias al='alias | less' # List all aliases
alias as='alias | grep' # Search aliases

alias _pv='python3 -m venv ./venv'

alias l='eza -1 --long --icons --classify --git-ignore --group-directories-first --git --git-repos-no-status --header'
alias la='eza -1 --long --icons --classify --git-ignore --group-directories-first --git --git-repos-no-status --all -T --header'
alias lg='eza -1 --long --icons --classify --git-ignore --group-directories-first --git --git-repos --all --header'

alias c='clear'
alias ..="cd ..";
alias ...="cd ../../";
alias ....="cd ../../../";
alias .....="cd ../../../../";
alias ......="cd ../../../../../";

alias d3="cd $HOME/Projects";

alias sc="code";
alias _s="sudo";
alias _sn="sudo nano";
alias _sv="sudo nvim";
alias v="nvim";
# alias vi="nvim";
# alias vim="nvim";

# git shortcuts
alias gc="git clone";
alias gs="git status";
alias gsw="git switch";
alias gfp="git fetch; git pull"
alias glsm="git ls-files --modified --others --exclude-standard"
alias gdf="git diff --staged --name-status"
alias gdf="git diff --staged"

alias conf="sv -O ~/.zprofile ~/.zshrc";
alias o="ack --sort-files --color";
alias vg='lazygit';
alias db="dotbare";
alias p="pnpm";
alias plz="fc -l -1 | cut -d' ' -f2- | xargs sudo"
alias cpwd='pwd | pbcopy'
alias pa='pbpaste'
alias rn='ranger'


# tmux shortcuts
alias tka='tmux kill-server';
alias tks='tmux kill-session -t';

# docker shorthands
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

# kitty specific
alias k="kitty";
alias kk="kitty +kitten"
alias icat="kitty +kitten icat"

alias pnpx="pnpm dlx"

# Don't google
alias myip="curl ifconfig.me"
alias whatismyip="curl ifconfig.me"
alias ws="curl wttr.in"
alias wss="curl 'wttr.in?format=3'"
alias dadjoke='curl -H "Accept: text/plain" https://icanhazdadjoke.com/; echo'
alias news='curl hkkr.in'
alias ask='$HOME/bin/cht.sh'
alias otr='owl tubes --backend envoy render'
alias ots='owl tubes --backend envoy stop'

# sencha
alias saw="sencha app watch"
alias sag="sencha app generate"

# pomodoro
alias work="timer 60m && terminal-notifier -message 'Drink a lot of water! 🧉💧'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal"

alias rest="timer 10m && terminal-notifier -message 'Just check your slack once!'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal"

alias flextest="npx nx run console:test --watchAll=false --coverage --coverageReporters=text '--collectCoverageFrom=./{src/app/icons,src/app/shell,src/app/shared,src/app/applications/Flex}/**' --testPathPattern=apps/console/src/app/shell --testPathPattern=apps/console/src/app/shared  --testPathPattern=apps/console/src/app/applications/Flex"

alias flextest_html="npx nx run console:test --watchAll=false --coverage --coverageReporters=html '--collectCoverageFrom=./{src/app/icons,src/app/shell,src/app/shared,src/app/applications/Flex}/**' --testPathPattern=apps/console/src/app/shell --testPathPattern=apps/console/src/app/shared  --testPathPattern=apps/console/src/app/applications/Flex"

alias flextest_html_p='npx nx run console:test --watchAll=false --coverage --coverageReporters=html "--collectCoverageFrom=./{src/app/icons,src/app/shell,src/app/shared,src/app/applications/Flex}/**" --testPathPattern=apps/console/src/app/shell --testPathPattern=apps/console/src/app/shared  --testPathPattern="${TEST_RUN_PATH}"'

alias flextest_html_n='npx nx run console:test --watchAll=false --coverage --coverageReporters=html "--collectCoverageFrom=./{src/app/icons,src/app/shell,src/app/shared,src/app/applications/Flex}/**" --testPathPattern="${TEST_RUN_PATH}"'

function trw {
  tmux rename-window "${1:-zsh|exec}";
}

function tree {
  exa -aF --tree -L="${1:-2}" --icons;
}

_uninstall_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)";
}

# Setting up shorthands for big boys
_r() {
    exec zsh
    # source ~/.zshrc;
    tmux source ~/.config/tmux/tmux.conf;
    echo "Reloaded!";
}

_f() {
    depth=$1;

    if [[ -z "$depth" ]]; then
         depth=1;
    fi

    dir=$(find . -type f -maxdepth $depth | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf-tmux -p --preview "${FZF__PREVIEW__COMMAND}");

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

    dir=$(find . -type d -maxdepth $depth -name "*$input*" | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf-tmux -p --preview "$FZF__DIR__PREVIEW__COMMAND");
    cd "$dir";
}

_a() {
    input="$1";
    depth="$2";

    if [ -z "$depth" ]; then
        depth=2;
    fi

    dir=$(find . -maxdepth $depth -name "*$input*" | egrep -v "${TREE__GLOBAL_IGNORE}" | fzf-tmux -p --preview "$FZF__SMART__PREVIEW__COMMAND");

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
    session_dir=`zoxide query ${session_name}`

    tmux new-session -s $session_name -n "main:${session_name}" -c "${session_dir}" -d 2> /dev/null; tmux attach -t $session_name 2> /dev/null || tmux switchc -t $session_name 2> /dev/null;
}

_ide () {
  tmux split-window -v -p 30;
  tmux split-window -h -p 40;
}

function _tmux_manager() {
  if [[ -z "$GHQ_ROOT" ]]; then
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

_tmux_smart_attach_ () {
  session=`tmux list-sessions | fzf-tmux -p +s --tac | cut -d ':' -f1`

  if [[ -z "$session" ]]; then
    echo "aborting";
    return
  fi

  tmux attach -t $session || tmux switch-client -t $session
}


eval "$(pyenv init --path)"
# source ~/.dotbare/dotbare.plugin.zsh

# source '/opt/homebrew/Cellar/jenv/0.5.6/libexec/libexec/../completions/jenv.zsh' &> /dev/null
#
