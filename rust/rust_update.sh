#!/bin/bash

rustup update
cargo install-update racer rusty-tags cargo-update mdbook fd-find \
    exa tealdeer skim bat cargo-benchcmp tokei amethyst_tools \
    systemfd cargo-watch ripgrep
# RUSTFLAGS="-C target-cpu=native" cargo install -j7 --force ripgrep --features 'simd-accel avx-accel pcre2'
tldr -u
