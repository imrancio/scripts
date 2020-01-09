# Docker intsall

sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update && apt-cache policy docker-ce
sudo apt install docker-ce docker-compose unzip
# nano syntax highlight
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
sudo systemctl status docker
sudo usermod -aG docker $USER
su - $USER

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
			sed -i 's/^plugins=(git)/plugins=(\n  git\n  virtualenv\n  z\n  history\n  colorize\n  colored-man-pages\n  sublime\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n)/' ~/.zshrc
			# set powerlevel9k mode (nerd-font)
			grep -qF "POWERLEVEL9K_MODE" ~/.zshrc ||
			sed -i "/^ZSH_THEME/i POWERLEVEL9K_MODE='nerdfont-complete'" ~/.zshrc
			# set default user
			grep -qF "DEFAULT_USER" ~/.zshrc || echo "DEFAULT_USER=$USER" >> ~/.zshrc
			# copy custom files
			cp -n *.zsh ~/.oh-my-zsh/custom
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

