#!/bin/bash

rustup update
cargo install-update cargo-update fd-find exa tealdeer skim bat cargo-benchcmp 
# RUSTFLAGS="-C target-cpu=native" cargo install -j7 --force ripgrep --features 'simd-accel avx-accel pcre2'
tldr -u
