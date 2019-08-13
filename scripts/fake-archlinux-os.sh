#!/usr/bin/env bash

# This script fake to be on Archlinux OS for Zoom sharing on GNOME Wayland desktop environment.

# Faking to be on Archlinux for just a moment.sudo cp /usr/lib/os-release.archlinux /usr/lib/os-release
sudo cp /usr/lib/os-release.archlinux /usr/lib/os-release

# Wait a few seconds to let the user the time to start screen sharing
echo ">> Being on Arch for just 30s..."
sleep 30s

# Back to normal folks
sudo cp /usr/lib/os-release.manjaro /usr/lib/os-release

echo ">> Back to Manjaro."
