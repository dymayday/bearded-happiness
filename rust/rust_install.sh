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
    rustup component add rustfmt-preview --toolchain $toolchain
    rustup component add clippy-preview --toolchain $toolchain
    rustup target add wasm32-unknown-unknown --toolchain $toolchain
done

rustup default nightly
rustup target add wasm32-unknown-unknown

# Get the directory path of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Get the list of rust crate to install
packages=(`cat ${DIR}/packages.txt`)
elements=$( IFS=$'\n'; echo "${packages[*]}" )

cargo install $elements
# RUSTFLAGS="-C target-cpu=native" cargo install --force ripgrep --features 'simd-accel pcre2'
tldr -u
