#!/bin/bash

# Launch all the install scripts.
# This script is meant to be run from the root of the dotfiles directory.

cd neovim && bash ./install.sh && cd -
cd term && bash ./install.sh && cd -
cd rust && bash ./rust_install.sh && cd -
cd tmux && bash ./install.sh && cd -
cd neovim && bash ./install-neovim.sh && cd -
