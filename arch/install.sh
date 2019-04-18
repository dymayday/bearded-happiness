#!/bin/bash

# szh
chsh -s /usr/bin/zsh

# Setting up desktop
#sudo pacman --noconfirm -Syyu
sudo pacman -S --needed base-devel
sudo pacman --noconfirm -Syyu deepin deepin-extra gnome gnome-extra pamac vim

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

yaourt --noconfirm -Syyua qogir-gtk-theme-git osx-arc-darker firefox-nightly neovim python-neovim nerd-fonts-complete nerd-fonts-source-code-pro chromium chrome-gnome-shell-git xclip zsh-syntax-highlighting tmux visual-studio-code-insiders fzf

# Theme install
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
base16_monokai

# zsh
chsh -s /usr/bin/zsh
echo "Sould be launched from root repository."
cp term/zsh/zshrc2 $HOME/.zshrc
cp term/zsh/zsh_theme $HOME/.zsh_theme
cp term/bash/bashrc $HOME/.bashrc
cp term/bash/bash_aliases2 $HOME/.bash_aliases

# SSH key
ssh-keygen -t rsa -b 4096

# Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ignite_node
nvm i v8 && nvm i v10 && nvm i v11
nvm alias default v11
npm i -g diff-so-fancy gitmoji-cli neon-cli eslint tap-spec
