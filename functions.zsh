####################
# Custom functions #
####################

# Networking

# get public facing IP
whereami()
{
	command -v dig >/dev/null 2>&1 || { 
		curl https://ipinfo.io/ip; 
		echo "Install 'bind-tools' or 'dnsutils' for faster results!"; 
		return }
	# faster dig ip from DNS (if exists)
	dig +short myip.opendns.com @resolver1.opendns.com
}

# private IPv4 address
ipv4()
{
	if [ $# -eq 1 ]; then
		ip addr show $1 | grep "inet\b" | awk '{print $2}'
	else
		echo "Usage: ipv4 <net interface>"
	fi
}

# private IPv6 address
ipv6()
{
	if [ $# -eq 1 ]; then
		ip addr show $1 | grep "inet6\b" | awk '{print $2}'
	else
		echo "Usage: ipv4 <net interface>"
	fi
}

# show MAC address of net interface
mac()
{
	if [ $# -eq 1 ]; then
		ip link show $1 | grep ether | awk '{print toupper($2)}'
	else
		echo "Usage: mac <net interface>"
	fi
}

# list net interfaces
interfaces()
{
	ip a | grep -P "^[\d]+:" | awk '{print $2}' | tr -d ":$"
}

# update git fork from upstream
gitfu()
{
	git fetch upstream
	git checkout master
	git merge upstream/master
}

# Dirs / Files

# search in files
in()
{
	if [ $# -eq 1  ]; then
		grep --exclude=*.o 
--exclude-dir={/boot,/dev,/initrd,/proc} -rnw '/' -e $1
	elif [ $# -eq 2 ]; then
		grep -rnw $1 -e $2
	else
		echo 'Usage: in <optional: dir/to/search> "<regexp>"'
	fi
}

# search in PDFs (requires pdfgrep)
inpdf()
{
	if [ $(command -v pdfgrep) ]; then
		if [ $# -eq 1  ]; then
	        find ./ -name '*.pdf' -exec pdfgrep $1 "{}" +;
	    elif [ $# -eq 2 ]; then
	        find $1 -name '*.pdf' -exec pdfgrep $2 "{}" +;
	    else
	        echo 'Usage: inpdf <optional: dir/to/search> "<regexp>"'
	    fi
	else
		echo "Install pdfgrep first!"
	fi
}

# list biggest n files in current directory; defaults to 10
biggest()
{
	if [ $# -eq 0 ] || [ $1 -lt 1 ]; then
		du | sort -hr | head
	else
		du | sort -hr | head -n $1
	fi
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