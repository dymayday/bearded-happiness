#!/bin/bash

rm -rf ~/.cargo/* ~/.rustup/* ~/.multirust/*
bash ./rust_install.sh
nvim +PlugClean +qa && nvim +PlugInstall +UpdateRemotePlugins +qa && nvim +PlugUpdate +UpdateRemotePlugins +qa
