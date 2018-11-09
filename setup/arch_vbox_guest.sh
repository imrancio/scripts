#!/bin/bash

# for auto-resize, shared-clipboard, drag-and-drop, etc
sudo pacman -Sy --needed virtualbox-guest-utils
# for auto mounting shared folders to /media
groups | grep -qF "vboxsf" || sudo groupadd vboxsf
sudo usermod -G vboxsf -a $USER
sudo mkdir -p /media