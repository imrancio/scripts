#!/bin/bash

# NOTE: atom and apm must be installed

# Packages for Atom editor
while true; do
	read -p $'\033[32m[3]\e[0m '"Install packages for Atom editor? [y/N] " yn
	case $yn in
		[Yy]* )
			type apm > /dev/null 2>&1 || echo -e "\033[0;31mAtom editor not installed!"
			type apm > /dev/null 2>&1 && apm install \
			atom-beautify \
			atom-live-server \
			autoclose-html \
			emmet \
			file-icons \
			highlight-selected \
			minimap \
			minimap-git-diff \
			minimap-highlight-selected \
			minimap-pigments \
			pigments \
			platformio-ide-terminal
			break
			;;
		[Nn]* )
			break
			;;
		* )
			echo "Please answer yes or no"
			;;
	esac
done