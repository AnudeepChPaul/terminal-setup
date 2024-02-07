#! /bin/bash
echo "==============Starting homebrew==============="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==============Installing curl=============="
brew install curl

echo "==============Installing git=============="
gh auth login

echo "==============Setting up dotfiles=============="
git clone https://github.com/kazhala/dotbare.git ~/.dotbare
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"
dotbare finit -u git@github.com:AnudeepChPaul/terminal-setup.git

echo "==============Installing Brewfile=============="
brew bundle install

echo "==============Setting up shell utils=============="
. common.utils.sh

./setup.zsh.sh

echo "==============Starting nvm=============="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "==============Creating custom bin=============="
mkdir $HOME/bin

echo "==============Downloading JDK=============="
curl -o $HOME/bin/jdk.default.tar.gz https://download.java.net/java/GA/jdk18.0.2/f6ad4b4450fd4d298113270ec84f30ee/9/GPL/openjdk-18.0.2_macos-aarch64_bin.tar.gz
tar -xvf jdk.default.tar.gz
