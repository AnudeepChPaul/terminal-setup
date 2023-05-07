#!/bin/bash

zypper addrepo https://download.opensuse.org/repositories/openSUSE:Factory/standard/openSUSE:Factory.repo
sudo zypper -y update
sudo zypper install --no-confirm git 
sudo zypper install --no-confirm zsh
sudo zypper install --no-confirm neovim wl-clipboard fzf

. ./common.utils.sh
./setup.zsh.sh

sudo zypper install --no-confirm \
  nginx docker tailscale \
  telegraf python-certbot \
  python-certbot-nginx
  
# apt install python3-certbot python3-certbot-nginx

wget https://github.com/joohoi/acme-dns-certbot-joohoi/raw/master/acme-dns-auth.py
chmod +x acme-dns-auth.py
nano acme-dns-auth.py
sudo mv acme-dns-auth.py /etc/letsencrypt/

sudo certbot certonly --manual --manual-auth-hook /etc/letsencrypt/acme-dns-auth.py --preferred-challenges dns --debug-challenges -d 

sudo certbot --nginx
