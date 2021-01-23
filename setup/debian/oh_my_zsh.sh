#!/bin/bash
BASEDIR=$(dirname $0)

# Set up oh-my-zsh with Powerlevel9k theme
while true; do
	read -p $'\033[32m[1]\e[0m '"Set up oh-my-zsh with Powerlevel9k theme and custom plugins? [y/N] " yn
	case $yn in
		[Yy]* )
			read -p $'\033[31m[WARNING]\e[0m '"Must run 'exit' after switching to oh-my-zsh shell [ok] "
			# zsh
			sudo apt update && sudo apt install -y zsh
			# oh-my-zsh
			sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
			# copy custom zsh files
			cp -n "${BASEDIR}/../zsh/*.zsh" ~/.oh-my-zsh/custom
			# install powerlevel9k theme
			git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
			# set theme in .zshrc
			grep -qF "powerlevel9k" ~/.zshrc ||
			sed -i.bak 's/^\(ZSH_THEME="\).*/\1powerlevel9k\/powerlevel9k"/' ~/.zshrc
			# set powerlevel9k mode (nerd-font)
			grep -qF "POWERLEVEL9K_MODE" ~/.zshrc ||
			sed -i "/^ZSH_THEME/i POWERLEVEL9K_MODE='nerdfont-complete'" ~/.zshrc
			# set default user
			grep -qF "DEFAULT_USER" ~/.zshrc || echo "DEFAULT_USER=$USER" >> ~/.zshrc
			# install custom plugins
			git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
			# add to plugins() in .zshrc
			grep -qF "zsh-autosuggestions" ~/.zshrc ||
			cat >> "~/.zshrc" <<-END
				# add preferred zsh plugins
				plugins+=(
				  virtualenv
				  z
				  history
				  colorize
				  colored-man-pages
				  sublime
				  asdf
				  yarn
				  pip
				  vscode
				  zsh-autosuggestions
				  zsh-completions
				  zsh-syntax-highlighting
				)
			END
			# Terminator config with nerdfonts
			if [[ -d "~/.config/terminator" ]]; then
				# Terminator themes plugin
				mkdir -p ~/.config/terminator/plugins
				wget https://git.io/v5Zww -O "~/.config/terminator/plugins/terminator-themes.py"
				# Set default theme and font
				cp "${BASEDIR}/../../dotfiles/config/terminator" ~/.config/terminator/config
			fi
			# fzf keybindings
			[[ -f /usr/share/fzf/key-bindings.zsh ]] && cp /usr/share/fzf/key-bindings.zsh ~/.oh-my-zsh/custom/fzf-key-bindings.zsh
			echo -e "\033[32m[*]\e[0m Restart terminal or run 'zsh' to see new shell"
			echo -e "\033[32m[*]\e[0m Run 'setalias' on zsh shell to set custom aliases"
			echo -e "\033[32m[*]\e[0m Run 'setfunc' on zsh shell to set custom functions"
			echo -e "\033[32m[*]\e[0m Run 'zshrc' on zsh shell to edit zshrc"
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
