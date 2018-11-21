####################
# Custom functions #
####################

# list biggest n files; defaults to 10
biggest()
{
	if [ $# -eq 0 ] || [ $1 -lt 1 ]; then
		du | sort -hr | head
	else
		du | sort -hr | head -n $1
	fi
}

# private IPs
ipv4()
{
	if [ $# -eq 1 ]; then
		ip addr show "$1" | grep "inet\b" | awk '{print $2}'
	else
		echo "Usage: ipv4 <net interface>"
	fi
}
ipv6()
{
	if [ $# -eq 1 ]; then
		ip addr show "$1" | grep "inet6\b" | awk '{print $2}'
	else
		echo "Usage: ipv4 <net interface>"
	fi
}

# get public facing ip
whereami()
{
	command -v dig >/dev/null 2>&1 || { curl https://ipinfo.io/ip; return }
	# faster dig ip from bind-tools (if exists)
	dig +short myip.opendns.com @resolver1.opendns.com
}

# more efficient removal of directory with many folders/files
rmfast()
{
	if [ -d "$1" ]; then
		command -v rsync >/dev/null 2>&1 || { "Install rsync package first!"; return }
		vared -p $'\033[31m[WARNING]\e[0m '"Permanently remove '$1' ? [y/N] " -c yn
		case $yn in
		    [Yy]* )
				mkdir -p empty_dir
				rsync -av --stats --delete empty_dir/ "$1"
				rmdir empty_dir "$1"
				;;
			* )
				;;
		esac
	else
		echo "Usage: rmfast dir/to/delete"
	fi
}