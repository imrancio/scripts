#!/bin/bash

# Git config
while true; do
	read -p $'\033[32m[1]\033[1m '"Configure Git? [y/N] "$'\e[0m' yn
	case $yn in
		[Yy]* )
			read -p $'\033[32m[a]\e[0m\033[1m '"Personal Email? "$'\e[0m' email
			git config --global user.email "$email"
			read -p $'\033[32m[a]\e[0m\033[1m '"Full Name? "$'\e[0m' name
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
	read -p $'\033[32m[2]\033[1m '"Configure personal/work GitHub ssh keys? [y/N] "$'\e[0m' yn
	case $yn in
		[Yy]* )
			read -p $'\033[32m[a]\e[0m\033[1m '"Add personal GitHub? [y/N] "$'\e[0m' yn_personal
			case $yn_personal in
				[Yy]* )
					read -p $'\033[32m[*]\e[0m\033[1m '"Personal Email? "$'\e[0m' email
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
			read -p $'\033[32m[b]\e[0m\033[1m '"Add work GitHub? [y/N] "$'\e[0m' yn_work
			case $yn_work in
				[Yy]* )
					read -p $'\033[32m[*]\e[0m\033[1m '"Work Email? "$'\e[0m' email_work
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