#!/bin/bash

# Install packet manager.
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# cp -R ./lua_config/nvim ~/.config/
ln -s $PWD/lua_config/nvim $HOME/.config/nvim


# # Tweak operator color to get a pretty blue.
# sed -ie "s\\hi! link Operator Normal\\hi! link Operator GruvboxBlueBold\\g" ~/.local/share/nvim/site/pack/packer/start/gruvbox/colors/gruvbox.vim
# /Users/meidhy/junk/repo/bearded-happiness/neovim/lua_config/nvim/init.lua
