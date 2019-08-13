#!/bin/bash

# Auto select the current proper timezone
sudo tzupdate

# Synchronize the system date with ntp servers
sudo ntpd -qdg

# Update the hardware clock (bios)
sudo hwclock -w
