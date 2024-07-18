#!/bin/bash

# dependencies check
deps=(code install jq make ruby svn tar unzip wget zsh)
not_installed=$(command -V ${deps[@]} 2>&1 | awk -F': +' '$NF == "not found" {printf "%s ", $(NF-1)}')

[[ -n ${not_installed} ]] && echo "Please install missing dependencies: ${not_installed}" 1>&2 && exit 1

# backup any existing zsh configuration files
[[ -d ~/.zinit ]] && mv ~/.zinit ~/.zinit.$(date +%s).bak
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.$(date +%s).bak

# download zsh configuration files (from github.com/imrancio/.cfg)
z_tmp=/tmp/zinit
mkdir -p $z_tmp &&
  wget -O /tmp/z.$$ https://github.com/imrancio/.cfg/archive/refs/heads/master.zip &&
  unzip -d $z_tmp /tmp/z.$$ &&
  rm /tmp/z.$$ &&
  mv $z_tmp/.zshrc $z_tmp/.zinit $z_tmp/.aliases.zsh $z_tmp/.functions.zsh ~ &&
  rm -rf $z_tmp

# print info and exit
echo -e "Start a new zsh session to finish configuration\n"

echo "'aliasrc' to set aliases"
echo "'funcrc' to set functions"
echo "'zshconf' to edit ~/.zshrc"
echo -e "'p10k configure' to setup theme\n"

echo "- => cd -"
echo "... => ../.. => cd ../.."
echo "Ctrl + G to toggle per directory history"
echo "Double Esc for 'sudo !!'"
echo -e "'rm' will move to trash by default for non-root users; 'sudo rm' to delete permanently\n"

echo "Install nerd font for icons"
echo "Install GitLens extension for VSCode to use as git editor"
exit 0
