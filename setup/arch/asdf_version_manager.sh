#!/bin/bash
BASEDIR=$(dirname $0)

NODEJS_LTS_VERSION=14.5.4
PYTHON2_VERSION=2.7.18

while true; do
	read -p $'\033[32m[1]\e[0m '"Setup asdf version manager? [y/N] " yn
	case $yn in
		[Yy]* )
			# Install asdf
			sudo pacman -Sy --needed yay
			yay -S --needed asdf-vm
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
	read -p $'\033[32m[1]\e[0m '"Setup asdf direnv plugin? [y/N] " yn
	case $yn in
		[Yy]* )
			asdf plugin-add direnv
			DIRENV_VERSION=$(asdf latest direnv)
			asdf install direnv $DIRENV_VERSION 
			asdf global direnv $DIRENV_VERSION
			# hook into shells
			[[ -f ~/.zshrc ]] && echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
			[[ -f ~/.bashrc ]] && echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
			# use asdf feature for direnv
			[[ -d ~/.config/direnv ]] && cat >> "~/.config/direnv/direnvrc" <<-END
				# File: ~/.config/direnv/direnvrc
				source "$(asdf direnv hook asdf)"

				# Uncomment the following line to make direnv silent by default.
				# export DIRENV_LOG_FORMAT=""
			END
			# save shortcut method
			cat >> "${BASEDIR}/../zsh/functions.zsh" <<-END
			# A shortcut for asdf managed direnv.
			direnv(){	asdf exec direnv "$@";	}
			END
			echo $(
				cat <<-END
					# sample .envrc
					use asdf
					set -a; source .env; set +a
					# sameple .env
					KEY1=VALUE1
					KEY2=VALUE2
				END )
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
	read -p $'\033[32m[1]\e[0m '"Setup asdf node plugin? [y/N] " yn
	case $yn in
		[Yy]* )
			asdf plugin-add nodejs
			bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
			asdf install nodejs $NODEJS_LTS_VERSION
			asdf global nodejs $NODEJS_LTS_VERSION
			sudo npm i -g yarn
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
	read -p $'\033[32m[1]\e[0m '"Setup asdf python plugin? [y/N] " yn
	case $yn in
		[Yy]* )
			asdf plugin-add python
			PYTHON3_VERSION=$(asdf latest python)
			asdf install python "$PYTHON3_VERSION $PYTHON2_VERSION"
			asdf global python "$PYTHON3_VERSION $PYTHON2_VERSION"
			sudo pacman -Rsn python python2
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