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

wget https://github.com/joohoi/acme-dns-certbot-joohoi/raw/master/acme-dns-auth.py
chmod +x acme-dns-auth.py
nano acme-dns-auth.py
sudo mv acme-dns-auth.py /etc/letsencrypt/

sudo certbot certonly --manual --manual-auth-hook /etc/letsencrypt/acme-dns-auth.py --preferred-challenges dns --debug-challenges -d 

sudo certbot --nginx


https://dev-sd7ywkn0dv457tf1.jp.auth0.com/authorize?client_id=hdnSeZgmSreZqhf0WxbnrpxdInPyOoES&redirect_uri=http%3A%2F%2Fgrafana.anudeep.pro%3A3000%2Flogin%2Fgeneric_oauth&response_type=code&scope=openid+profile+email+offline_access&state=7_C-KSgmHahpFB0kgvy07KC4d1xJfTBthGNZsBpOsYY%3D
