#!/bin/bash
kernel=$(uname -r | sed -r 's/^([0-9]+)\.([0-9]+).*$/\1\2/')
# for auto-resize, shared-clipboard, drag-and-drop, etc
# guest modules for arch kernel:
pacman -Ss virtualbox-guest-modules-arch &&
sudo pacman -Sy --needed virtualbox-guest-modules-arch
# guest modules for manjaro kernel:
pacman -Ss linux$kernel-virtualbox-guest-modules
sudo pacman -Sy --needed linux$kernel-virtualbox-guest-modules
# for auto mounting shared folders to /media
groups | grep -qF "vboxsf" || sudo groupadd vboxsf
sudo usermod -G vboxsf -a $USER
sudo mkdir -p /media