#!/bin/bash

project_dir="$1"
echo "$1"

TIMESTAMP=`date "+%Y.%m.%d-%H:%M:%S"`
files=(".zshrc" ".zprofile" ".config/nvim" ".config/tmux")

___git_ac="git --git-dir=$project_dir/.git --work-tree=$project_dir"

for file in ${files[@]}; do
    cp -fr "$HOME/${file}" "$project_dir/${file}" && echo "${file} copied"
    eval $___git_ac add "$project_dir/${file}"
done

eval $___git_ac add "$project_dir/auto_checkin.sh"

eval "$___git_ac commit -m '[$TIMESTAMP] [Backup] Auto backing up changes' &> /dev/null"
eval "$___git_ac pull --rebase"
eval "$___git_ac push"

unset ___git_ac

