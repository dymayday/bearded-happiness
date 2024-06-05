#!/bin/bash

ln -s $PWD/zsh/zshrc.macos $HOME/.zshrc
ln -s $PWD/zsh/zsh_theme $HOME/.zsh_theme

# ln -s ./zsh/profile $HOME/.profile
# ln -s ./bash/bash_profileprofile $HOME/.bash_profile

# Create alacritty directory if it doesn't exist and test if it exists before creating symlink
# This is to avoid creating a symlink to a file that already exists
[ ! -d $HOME/.config/alacritty ] && mkdir -p $HOME/.config/alacritty
ln -s $PWD/alacritty-macos.toml $HOME/.config/alacritty/alacritty.toml
