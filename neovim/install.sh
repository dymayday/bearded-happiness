#!/bin/bash

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p "$HOME/.config/nvim/"
cp init.vim "$HOME/.config/nvim/init.vim"

nvim +PlugClean +qa && nvim +PlugInstall +UpdateRemotePlugins +qa && nvim +PlugUpdate +UpdateRemotePlugins +qa

# Tweak operator color to get a pretty blue
sed -ie "s\\hi! link Operator Normal\\hi! link Operator GruvboxBlueBold\\g" ~/.config/nvim/plugged/gruvbox/colors/gruvbox.vim

cp ctags ~/.ctags
