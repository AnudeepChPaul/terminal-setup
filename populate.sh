#!/bin/bash

cp -f -r ./.config/nvim/* ~/.config/nvim
cp -f -r ./.config/tmux/* ~/.config/tmux

cp -f -r .zprofile ~
cp -f -r .zshrc ~

cp -aR .config/fish/config.fish ~/.config/fish/
cp -aR .config/fish/functions/nvm.fish ~/.config/fish/functions/
cp -aR .config/fish/functions/load_nvm.fish ~/.config/fish/functions/
cp -aR .config/fish/functions/nvm_find_nvmrc.fish ~/.config/fish/functions/
# cp -aR .config/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/

