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
