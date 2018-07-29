#!/bin/bash

rustup update
cargo install-update racer rusty-tags cargo-update mdbook fd-find exa tealdeer skim bat
# RUSTFLAGS="-C target-cpu=native" cargo install -j7 --force ripgrep --features 'simd-accel avx-accel'
tldr -u
