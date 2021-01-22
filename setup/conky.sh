#!/bin/bash
BASEDIR=$(dirname $0)
git clone https://gitlab.com/thegreatyellow67/conky-skeleton.git /tmp/conky
cp -r /tmp/conky/Conky-Skeleton ~/.conky
rm -rf /tmp/conky ~/.conky/Conky-Skeleton/*.lua
cp "${BASEDIR}/../dotfiles/conky/Conky-Skeleton/*.lua" ~/.conky/Conky-Skeleton/