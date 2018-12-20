#!/bin/bash

while true; do
	read -p $'\033[32m[1]\e[0m '"Install core packages? [y/N] " yn
	case $yn in
	    [Yy]* )
			# Upgrade system
			sudo pacman -Syu
			# Install Manjaro packages
			sudo pacman -S --needed \
			adapta-maia-theme \
			adapta-manjaro-themes \
			bind-tools \
			clisp \
			code \
			conky-lua-nv \
			conky-manager \
			copyq \
			deluge \
			gdb \
			ghc \
			gnu-netcat \
			go \
			grsync \
			keepassxc \
			mongodb \
			muparser \
			neofetch \
			nodejs-lts-dubnium \
			npm \
			pdfgrep \
			python-virtualenv \
			python2-pip \
			python2-requests \
			s-nail \
			seahorse \
			swi-prolog \
			terminator \
			ttf-roboto \
			units \
			valgrind \
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

# Install AUR packages
while true; do
	read -p $'\033[32m[2]\e[0m '"Install AUR packages? Must be enabled in pamac! [y/N] " yn
	case $yn in
	    [Yy]* )
			pamac build \
			albert \
			atom-editor-bin \
			dropbox \
			font-manager \
			google-chrome \
			nerd-fonts-terminus \
			spotify \
			sublime-text-3-imfix \
			ttf-ms-fonts
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

# Git config
while true; do
	read -p $'\033[32m[3]\e[0m '"Configure Git? [y/N] " yn
	case $yn in
	    [Yy]* )
			read -p $'\033[32m[*]\e[0m '"Email? " email
			git config --global user.email $email
			read -p $'\033[32m[*]\e[0m '"Name? " name
			git config --global user.name $name
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

# Install pentesting tools from BlackArch
while true; do
	read -p $'\033[32m[4]\e[0m '"Install BlackArch repo and tools? [y/N] " yn
	case $yn in
		[Yy]* )
			# check if repo not installed
			cat /etc/pacman.conf | grep -qF "[blackarch]"
			if [ $? -ne 0 ]; then
				# get BlackArch script
				wget https://blackarch.org/strap.sh
				# check shasum (current as of 22/11/18)
				diff <(sha1sum strap.sh) <(echo "9f770789df3b7803105e5fbc19212889674cd503  strap.sh")
				if [ $? -eq 0 ]; then
					# install BlackArch repo
					chmod +x strap.sh
					sudo ./strap.sh
					# upgrade new repo
					sudo pacman -Syyu
					# cleanup
					rm -f strap.sh
				else
					echo "SHA1 sum does not match or needs to be updated from https://blackarch.org/downloads.html#install-repo"
				fi
			fi

			# install blackarch pentesting tools
			sudo pacman -S --needed \
			blackarch/hashcat \
			blackarch/hashcat-utils \
			blackarch/john \
			blackarch/nmap \
			blackarch/sqlmap \
			blackarch/xsser \
			blackarch/rkhunter \
			blackarch/hydra \
			blackarch/burpsuite \
			blackarch-config-gtk

			# Add/update blackarch menus using 'blackmate' command
			if [ ! -d "/usr/share/blackmate" ]; then
				git clone https://github.com/imrancio/blackmate.git
				sudo mv blackmate /usr/share

				grep -qF "alias blackmate='sudo sh /usr/share/blackmate/blackmate.sh'" ~/.bashrc ||
				echo "alias blackmate='sudo sh /usr/share/blackmate/blackmate.sh'" >> ~/.bashrc
			fi

			sudo sh /usr/share/blackmate/blackmate.sh
			echo -e "\033[32m[*]\e[0m Run 'blackmate' to update BlackArch menus"
			break
			;;
		[Nn]* )
			break
			;;
		* )
			echo "Please answer yes or no "
			;;
	esac
done

# Fix Windows/Linux dual-boot time issues
while true; do
	read -p $'\033[32m[5]\e[0m '"Fix Windows/Linux dual-boot time issue? [y/N] " yn
	case $yn in
	    [Yy]* )
			timedatectl set-local-rtc 1 --adjust-system-clock
			break
			;;
	    [Nn]* )
			break
			;;
		* )
			echo "Please answer yes or no "
			;;
	esac
done

# Set up oh-my-zsh with Powerlevel9k theme
while true; do
	read -p $'\033[32m[6]\e[0m '"Set up oh-my-zsh with Powerlevel9k theme? [y/N] " yn
	case $yn in
	    [Yy]* )
			read -p $'\033[31m[WARNING]\e[0m '"Must run 'exit' after switching to oh-my-zsh shell [ok] "
			# oh-my-zsh
			sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
			# install custom plugins
			git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
			# install powerlevel9k theme
			git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
			# set theme in .zshrc
			grep -qF "powerlevel9k" ~/.zshrc ||
			sed -i.bak 's/^\(ZSH_THEME="\).*/\1powerlevel9k\/powerlevel9k"/' ~/.zshrc
			# add to plugins() in .zshrc
			grep -qF "zsh-autosuggestions" ~/.zshrc ||
			sed -i 's/^  git/  git\n  virtualenv\n  z\n  history\n  colorize\n  colored-man-pages\n  sublime\n  zsh-autosuggestions\n  zsh-syntax-highlighting/' ~/.zshrc
			# set powerlevel9k mode (nerd-font)
			grep -qF "POWERLEVEL9K_MODE" ~/.zshrc ||
			sed -i "/^ZSH_THEME/i POWERLEVEL9K_MODE='nerdfont-complete'" ~/.zshrc
			# set default user
			grep -qF "DEFAULT_USER" ~/.zshrc || echo "DEFAULT_USER=$USER" >> ~/.zshrc
			# copy custom files
			cp -n *.zsh ~/.oh-my-zsh/custom
			# Terminator config
			if [ -d "~/.config/terminator" ]; then
				# Check font
				pacman -Qe | grep -q nerd-fonts-terminus || pamac build nerd-fonts-terminus
				# Terminator themes plugin
				mkdir -p ~/.config/terminator/plugins
				wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"
				# Set default theme and font
				cp config/terminator ~/.config/terminator/config
			fi
			# blackmate alias
			if [ -d "/usr/share/blackmate" ] && [ -f ~/.oh-my-zsh/custom/aliases.zsh ]; then
				grep -qF "alias blackmate=" ~/.oh-my-zsh/custom/aliases.zsh ||
				echo "alias blackmate='sudo sh /usr/share/blackmate/blackmate.sh'" >> ~/.oh-my-zsh/custom/aliases.zsh
			fi

			echo -e "\033[32m[*]\e[0m Restart terminal or run 'zsh' to see new shell"
			echo -e "\033[32m[*]\e[0m Run 'setalias' on zsh shell to set custom aliases"
			echo -e "\033[32m[*]\e[0m Run 'setfunc' on zsh shell to set custom functions"
			break
			;;
	    [Nn]* )
			break
			;;
		* )
			echo "Please answer yes or no "
			;;
	esac
done
