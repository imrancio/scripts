#!/bin/bash

# Fix Windows/Linux dual-boot time issues
while true; do
	read -p $'\033[32m[1]\e[0m '"Fix Windows/Linux dual-boot time issue? [y/N] " yn
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