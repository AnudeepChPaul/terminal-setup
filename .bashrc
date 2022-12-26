-------- Colors  --------#
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
green='\e[0;32m'
GREEN='\e[1;32m'
black='\e[0;30m'
BLACK='\e[1;30m'
WHITE='\e[0;37m'
NC='\e[0m' # no color

BG_MAGENTA="\e[45m"
BG_BLUE="\e[44m"
BG_GREEN="\e[42m"
BG_WHITE="\e[47m"
BG_BLACK="\e[40m"
BG_GRAY="\e[100m"

#-------- Shell Prompt --------#
A=${CYAN}
B=${PURPLE}
C=${RED}
D=${GREEN}
E=${BLUE}
F=${BLUE}

X="\e[45m"
Y="\e[44m"
Z="\e[42m"
#source /usr/local/git/contrib/completion/git-completion.zsh
# TODO fix line below for zsh

git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
node_version () { node -v; }

# PS1="\n╭  ⌐ $BG_BLACK$WHITE\h@$BLUE\u $BG_BLACK$RED\W $BG_BLACK$CYAN[\$(node_version)] $GREEN\$(git_branch)$NC\n╰▶"
PS1="\n╭╴( $BG_BLACK$WHITE\h@$BLUE\u $WHITE) $BG_BLACK$RED\W $BG_BLACK$CYAN[\$(node_version)] $GREEN\$(git_branch)$NC\n╰▶"


function _setup_shorts {
    # bind F12
    bind '"\e[24~":"ls -a | fzf\n"'
    # bind F9
    bind '"\e[20~":"`__fzf_select__`\n"'
}

function _init_tmux_session {
    # 1. First you check if a tmux session exists with a given name.
    tmux has-session -t=$1 2> /dev/null

    # 2. Create the session if it doesn't exists.
    if [[ $? -ne 0 ]]; then
    TMUX='' tmux new-session -d -s "$1"
    fi

    # 3. Attach if outside of tmux, switch if you're in tmux.
    if [[ -z "$TMUX" ]]; then
    tmux attach -t "$1"
    else
    tmux switch-client -t "$1"
    fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

_init_tmux_session master
