#!/bin/bash

# Get the directory path of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Get the list of rust crate to install
packages=(`cat ${DIR}/packages.txt`)
elements=$( IFS=$'\n'; echo "${packages[*]}" )

rustup update
cargo install-update $elements
# RUSTFLAGS="-C target-cpu=native" cargo install -j7 --force ripgrep --features 'simd-accel avx-accel pcre2'
# tldr -u
