#!/bin/bash

project_dir="$1"
echo "$1"

TIMESTAMP=`date "+%Y.%m.%d-%H:%M:%S"`
files=(".zshrc" ".zprofile")

___git_ac="git --git-dir=$project_dir/.git --work-tree=$project_dir"

for file in ${files[@]}; do
    cp -fr "$HOME/${file}" "$project_dir/${file}" && echo "${file} copied"
    eval $___git_ac add "$project_dir/${file}"
done

cp -aR ~/.config/nvim $project_dir/.config
cp -aR ~/.config/tmux/tmux.conf $project_dir/.config/tmux/

cp -aR ~/.config/fish/config.fish $project_dir/.config/fish/
cp -aR ~/.config/fish/functions/nvm.fish $project_dir/.config/fish/functions/
cp -aR ~/.config/fish/functions/load_nvm.fish $project_dir/.config/fish/functions/
cp -aR ~/.config/fish/functions/nvm_find_nvmrc.fish $project_dir/.config/fish/functions/
# cp -aR ~/.config/fish/functions/fish_user_key_bindings.fish $project_dir/.config/fish/functions/

eval $___git_ac add "$project_dir"

eval "$___git_ac commit -m '[$TIMESTAMP] [Backup] Auto backing up changes' &> /dev/null"
eval "$___git_ac pull --rebase"
eval "$___git_ac push"

unset ___git_ac

