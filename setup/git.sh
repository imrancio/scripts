#!/bin/bash

# Git config
while true; do
	read -p $'\033[32m[1]\e[0m '"Configure Git? [y/N] " yn
	case $yn in
		[Yy]* )
			read -p $'\033[32m[*]\e[0m '"Personal Email? " email
			git config --global user.email "$email"
			read -p $'\033[32m[*]\e[0m '"Full Name? " name
			git config --global user.name "$name"
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

# GitHub SSH config
while true; do
	read -p $'\033[32m[2]\e[0m '"Configure work/email GitHub ssh keys? [y/N] " yn
	case $yn in
		[Yy]* )
			read -p $'\033[32m[*]\e[0m '"Work Email? " email_work
			# generate private github account keypair (if not exist)
			[[ -f ~/.ssh/id_rsa ]] || ssh-keygen -t rsa -b 4096 -C "$email"
			# generate work github account keypair (if not exist)
			[[ -f ~/.ssh/work_rsa ]] || ssh-keygen -t rsa -b 4096 -C "$email_work" -f ~/.ssh/work_rsa
			cat >> ~/.ssh/config <<-END
				# Personal GitHub account
				Host github.com
				 HostName github.com
				 User git
				 AddKeysToAgent yes
				 UseKeychain yes
				 IdentityFile ~/.ssh/id_rsa

				# Work GitHub account
				Host github.com-work
				 HostName github.com
				 User git
				 AddKeysToAgent yes
				 UseKeychain yes
				 IdentityFile ~/.ssh/work_rsa
			END
			echo $(
				cat <<-END
					# Paste the following SSH key into personal GitHub account for $HOST:
					$(cat ~/.ssh/id_rsa.pub)

					# Paste the following SSH key into work GitHub account for $HOST:
					$(cat ~/.ssh/work_rsa.pub)

					# Read more
					https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

					# Access work repos using:
					git clone git@github.com-work:path/to/work/repo.git
					
					# Access personal repos using:
					git clone git@github.com:path/to/personal/repo.git
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