#!/bin/bash

# Setting up desktop
sudo pacman -Syyu
sudo pacman -S --needed base-devel
sudo pacman -Syyu deepin deepin-extra gnome gnome-extra pamac

# Signed AUR handler
## disastrousaur
sudo pacman-key --recv-keys CBAE582A876533FD
pacman-key --finger CBAE582A876533FD
sudo pacman-key --lsign-key CBAE582A876533FD
sudo echo "
[andontie-aur]
Server = https://aur.andontie.net/$arch
" >> /etc/pacman.conf

## andontie-aur
sudo pacman-key --recv-keys EA50C866329648EE
pacman-key --finger EA50C866329648EE
sudo pacman-key --lsign-key EA50C866329648EE
sudo echo "
[disastrousaur]
Server = https://mirror.repohost.de/$repo
" >> /etc/pacman.conf

# Setting up AUR manager
sudo pamac install pacaur yaourt

yaourt --noconfirm -Syy qogir-gtk-theme-git osx-arc-darker chromium
pacaur --noconfirm -Syyu firefox-nightly neovim

# Theme install
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# zsh
chsh -s /usr/bin/zsh
