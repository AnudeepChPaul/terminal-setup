#!/bin/bash

. common.utils.sh

zsh --version
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/AnudeepChPaul/terminal-setup.git ${HOME}/terminal-setup

cp -r ${HOME}/terminal-setup/.config/* ${HOME}/.config
cp ${HOME}/terminal-setup/.config/tmux/tmux.conf ${HOME}/.config/tmux.conf
rm -rf ${HOME}/.config/nvim/plugin/packer_compiled.lua
cp ${HOME}/terminal-setup/.zshrc ${HOME}/.zshrc
cp ${HOME}/terminal-setup/.zprofile ${HOME}/.zprofile

nvim .

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


nvim ~/.zshrc && source ~/.zshrc
