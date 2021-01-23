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
	read -p $'\033[32m[2]\e[0m '"Configure personal/work GitHub ssh keys? [y/N] " yn
	case $yn in
		[Yy]* )
			read -p $'\033[32m[2.1]\e[0m '"Add personal GitHub? [y/N] " yn_personal
			case $yn_personal in
				[Yy]* )
					read -p $'\033[32m[*]\e[0m '"Personal Email? " email
					# generate personal github account keypair (if not exist)
					[[ -f ~/.ssh/id_rsa ]] || ssh-keygen -t rsa -b 4096 -C "$email"
					cat >> ~/.ssh/config <<-END
						# Personal GitHub account
						Host github.com
						 HostName github.com
						 User git
						 AddKeysToAgent yes
						 UseKeychain yes
						 IdentityFile ~/.ssh/id_rsa
					END
					echo $(
						cat <<-END
							# Paste the following SSH key into personal GitHub account for $HOST:
							$(cat ~/.ssh/id_rsa.pub)

							# Read more
							https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

							# Access personal repos using:
							git clone git@github.com:path/to/personal/repo.git
						END )
					break
					;;
				* )
					break
					;;
			esac
			read -p $'\033[32m[2.1]\e[0m '"Add work GitHub? [y/N] " yn_work
			case $yn_work in
				[Yy]* )
					read -p $'\033[32m[*]\e[0m '"Work Email? " email_work
					# generate work github account keypair (if not exist)
					[[ -f ~/.ssh/work_rsa ]] || ssh-keygen -t rsa -b 4096 -C "$email_work" -f ~/.ssh/work_rsa
					cat >> ~/.ssh/config <<-END
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
							# Paste the following SSH key into work GitHub account for $HOST:
							$(cat ~/.ssh/work_rsa.pub)

							# Read more
							https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

							# Access work repos using:
							git clone git@github.com-work:path/to/work/repo.git
						END )
					break
					;;
				* )
					break
					;;
			esac
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