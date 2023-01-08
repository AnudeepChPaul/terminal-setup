#!/bin/bash

os_type=$(uname)
os_distribution="opensuse"

case $os_type in 
  Linux) echo "OS Type: Linux"
    os_distribution="opensuse"
    ;;
  Darwin) echo "OS Type: Mac OS"
    os_distribution="macos"
    ;;
esac


__copy() {
  case $os_distribution in
    opensuse) wl-copy $1 ;;
    macos) echo $1 | pbcopy ;;
  esac
}


