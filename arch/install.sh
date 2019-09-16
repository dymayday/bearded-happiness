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
sudo pamac update
sudo pamac install yay pacaur

yay --noconfirm -Syyu qogir-gtk-theme-git osx-arc-darker firefox-nightly \
    neovim python-neovim nerd-fonts-complete nerd-fonts-source-code-pro tig \
    chromium chrome-gnome-shell-git xclip zsh-syntax-highlighting tmux fzf \
    visual-studio-code-insiders vscodium-bin engrampa unrar otf-fira-code gparted \
    youtube-dl nmap meld

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
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )
mv ~/.purepower ~/.config/purepower

# SSH key
ssh-keygen -t rsa -b 4096

# Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ignite_node
nvm i v8 && nvm i v10 && nvm i v11
nvm alias default v11
npm i -g diff-so-fancy gitmoji-cli neon-cli eslint tap-spec

# GPU part
echo "Dell XPS 15 - 9570 please see: https://wiki.archlinux.org/index.php/Dell_XPS_15_9570"
## Suspend
echo deep|sudo tee /sys/power/mem_sleep
## dGPU
echo "blacklist nouveau
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
blacklist nv" | sudo tee /etc/modprobe.d/blacklist.conf
echo "w /sys/bus/pci/devices/0000:01:00.0/power/control - - - - auto" | sudo tee /etc/tmpfiles.d/nvidia_pm.conf
# And a few more on wiki link
