#!/bin/bash

while true; do
	read -p $'\033[32m[1]\033[1m '"Install core packages from pacman? [y/N] "$'\e[0m' yn
	case $yn in
	    [Yy]* )
			# pacman config
			sudo sed -i.bak 's/^#Color/Color/' /etc/pacman.conf
			sudo sed -i 's/^#TotalDownload/TotalDownload/' /etc/pacman.conf

			sudo pacman -Sy --needed --noconfirm \
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
	read -p $'\033[32m[2]\033[1m '"Install core packages from AUR? "$'\e[0m' yn
	case $yn in
	    [Yy]* )
            sudo pacman -Sy --needed --noconfirm yay
			yay -S --needed --noconfirm \
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
	read -p $'\033[32m[3]\033[1m '"Install core packages from Snap? [y/N] "$'\e[0m' yn
	case $yn in
	    [Yy]* )
            sudo pacman -Sy --needed --noconfirm yay
			yay -S --needed --noconfirm snapd
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