#!/bin/bash

while true; do
	read -p $'\033[32m[1]\e[0m '"Install core packages from pacman? [y/N] " yn
	case $yn in
	    [Yy]* )
			# pacman config
			sudo sed -i.bak 's/^#Color/Color/' /etc/pacman.conf
			sudo sed -i 's/^#TotalDownload/TotalDownload/' /etc/pacman.conf

			sudo pacman -Sy --needed \
			adapta-maia-theme \
			adapta-manjaro-themes \
			bind-tools \
			conky-lua-nv \
			conky-manager \
			copyq \
			deluge \
            fzf \
			gdb \
			gnu-netcat \
			go \
			grsync \
			jq \
			mongodb \
			muparser \
			neofetch \
			pdfgrep \
			python-virtualenv \
			python2-pip \
			python2-requests \
			s-nail \
			seahorse \
			terminator \
			ttf-roboto \
			tree \
			units \
			vim \
			yay
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

while true; do
	read -p $'\033[32m[2]\e[0m '"Install core packages from AUR? " yn
	case $yn in
	    [Yy]* )
            sudo pacman -Sy --needed yay
			yay -S --needed \
			albert \
            asdf-vm \
			atom-editor-bin \
            caprine \
			dropbox \
			font-manager \
            google-chat-linux-bin \
			google-chrome \
			nerd-fonts-terminus \
            postman-bin \
            screen-desktop-bin \
            snapd \
			spotify \
			sublime-text-3-imfix \
			ttf-ms-fonts \
            visual-studio-code-bin
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

while true; do
	read -p $'\033[32m[2]\e[0m '"Install core packages from Snap? [y/N] " yn
	case $yn in
	    [Yy]* )
            sudo pacman -Sy --needed yay
			yay -S --needed snapd
			sudo snap install miro --edge
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