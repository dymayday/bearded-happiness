#!/bin/bash
#curl https://sh.rustup.rs -sSf | sh

echo '[build]
rustflags = "-C target-cpu=native"' >>$HOME/.cargo/config

declare -a toolchain_arr=("stable" "beta" "nightly")

curl https://sh.rustup.rs -sSf >/tmp/rustup-init.sh
sh /tmp/rustup-init.sh -y
rm /tmp/rustup-init.sh

source $HOME/.cargo/env

#if [[ ! -s $HOME/.zfunc ]]; then mkdir $HOME/.zfunc fi
[ ! -s $HOME/.zfunc ] && mkdir $HOME/.zfunc
rustup completions zsh >~/.zfunc/_rustup

for toolchain in "${toolchain_arr[@]}"; do
  rustup install $toolchain
  rustup component add rust-src --toolchain $toolchain
  rustup component add rust-analyzer --toolchain $toolchain
  rustup component add rustfmt --toolchain $toolchain
  rustup component add clippy --toolchain $toolchain
  rustup target add wasm32-unknown-unknown --toolchain $toolchain
done

rustup default nightly

# Get the directory path of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

# Get the list of rust crate to install
packages=($(cat ${DIR}/packages.txt))
elements=$(
  IFS=$'\n'
  echo "${packages[*]}"
)

cargo install --force $elements
RUSTFLAGS="-C target-cpu=native" cargo install --force ripgrep --features 'simd-accel pcre2'
tldr -u
