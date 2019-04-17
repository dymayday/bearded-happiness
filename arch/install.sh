#!/bin/bash

# Setting up desktop
sudo pacman -Syyu
sudo pacman -S --needed base-devel
sudo pacman -Syyu deepin deepin-extra gnome gnome-extra pamac vim

# Nvidia Bumblebee setup
echo ">> WARN - You're supposed to have install proprietary driver."
sudo gpasswd -a $USER bumblebee

# Swapping management
echo "vm.swappiness=100" | sudo tee -a /etc/sysctl.d/99-sysctl.conf

# Signed AUR handler
## disastrousaur
sudo pacman-key --recv-keys CBAE582A876533FD
pacman-key --finger CBAE582A876533FD
sudo pacman-key --lsign-key CBAE582A876533FD
echo "
[andontie-aur]
Server = https://aur.andontie.net/$arch
" | sudo tee -a /etc/pacman.conf

## andontie-aur
sudo pacman-key --recv-keys EA50C866329648EE
pacman-key --finger EA50C866329648EE
sudo pacman-key --lsign-key EA50C866329648EE
echo "
[disastrousaur]
Server = https://mirror.repohost.de/$repo
" | sudo tee -a /etc/pacman.conf

# Setting up AUR manager
sudo pamac -Syy pacaur yaourt

yaourt --noconfirm -Syyu qogir-gtk-theme-git osx-arc-darker chromium firefox-nightly neovim nerd-fonts-complete nerd-fonts-source-code-pro 

# Theme install
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# zsh
chsh -s /usr/bin/zsh
cp ../term/zsh/zshrc2 $HOME/.zshrc
cp ../term/zsh/zsh_theme $HOME/.zsh_theme
cp ../term/bash/bashrc2 $HOME/.bashrc
