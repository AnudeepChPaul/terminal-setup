#!/usr/bin/env bash
selected=`cat ~/.config/custom_scripts/.tmux-cht-languages | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/custom_scripts/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux popup -h 70% -w 70% bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux popup -h 70% -w 70% bash -c "curl -s cht.sh/$selected~$query | less"
fi
