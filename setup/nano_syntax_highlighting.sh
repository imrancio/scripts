#!/bin/bash

# nano syntax highlight
git clone --single-branch --branch=v2.9 https://github.com/scopatz/nanorc.git ~/.nano
cat ~/.nano/nanorc >> ~/.nanorc
echo "include $install_path/*.nanorc" >> ~/.nanorc
