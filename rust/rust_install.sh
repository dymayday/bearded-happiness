#!/bin/bash
#curl https://sh.rustup.rs -sSf | sh

echo '[build]
rustflags = "-C target-cpu=native"' >> $HOME/.cargo/config

declare -a toolchain_arr=("stable" "beta" "nightly")

curl https://sh.rustup.rs -sSf > /tmp/rustup-init.sh
sh /tmp/rustup-init.sh -y
rm /tmp/rustup-init.sh

source $HOME/.cargo/env

#if [[ ! -s $HOME/.zfunc ]]; then mkdir $HOME/.zfunc fi
[ ! -s $HOME/.zfunc ] && mkdir $HOME/.zfunc
rustup completions zsh > ~/.zfunc/_rustup


for toolchain in "${toolchain_arr[@]}"; do
    rustup install $toolchain
    rustup component add rust-src --toolchain $toolchain
    rustup component add rust-analysis --toolchain $toolchain
    rustup component add rls-preview --toolchain $toolchain
    rustup component add rust-analysis --toolchain $toolchain
    rustup component add rust-src --toolchain $toolchain
    rustup component add rustfmt-preview --toolchain $toolchain
    rustup component add clippy-preview --toolchain $toolchain
    rustup target add wasm32-unknown-unknown --toolchain $toolchain
done

rustup default nightly
rustup target add wasm32-unknown-unknown


cargo install --force racer rusty-tags cargo-update mdbook fd-find exa tealdeer skim bat #clippy rustfmt-nightly \
    systemfd cargo-watch cargo-tree cargo-updated cargo-edit hyperfine
RUSTFLAGS="-C target-cpu=native" cargo install --force ripgrep --features 'simd-accel pcre2'
tldr -u
