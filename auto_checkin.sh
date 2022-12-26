#!/bin/bash

CWD="$1"
echo "$1"

TIMESTAMP=`date "+%Y.%m.%d-%H:%M:%S"` #add %3N as we want millisecond too
files=(".zshrc" ".zprofile" ".config/nvim" ".config/tmux")

___git_ac="git --git-dir=$CWD/.git --work-tree=$CWD"

for file in ${files[@]}; do
    cp -fr "$HOME/${file}" "$CWD/${file}" && echo "${file} copied"
    eval $___git_ac add "$CWD/${file}"
done

eval $___git_ac add "$CWD/auto_checkin.sh"

eval "$___git_ac commit -m '[$TIMESTAMP] [Backup] Auto backing up changes' &> /dev/null"
eval "$___git_ac pull --rebase"
eval "$___git_ac push"

unset ___git_ac

