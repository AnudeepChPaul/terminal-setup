#! /bin/bash
echo "==============Starting homebrew==============="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "==============Installing curl=============="
brew install curl

echo "==============Installing git=============="
brew install git
brew install gh

gh auth login

echo "==============Setting up shell utils=============="
brew install fzf tree bat zoxide
brew install tmux neovim ripgrep
brew install lazygit lua-language-server fd exa

. common.utils.sh

./setup.zsh.sh

echo "==============Installing universal ctags=============="
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

echo "==============Starting nvm=============="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "==============Creating custom bin=============="
mkdir $HOME/bin

echo "==============Downloading JDK=============="
curl -o $HOME/bin/jdk.default.tar.gz https://download.java.net/java/GA/jdk18.0.2/f6ad4b4450fd4d298113270ec84f30ee/9/GPL/openjdk-18.0.2_macos-aarch64_bin.tar.gz
tar -xvf jdk.default.tar.gz


brew install scc rm-improved ddgr ripgrep tldr
