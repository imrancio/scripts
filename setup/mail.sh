#!/bin/bash

if test ! -t 0; then
	# Setup mail account for system (cron job reports / no-replies)
	while true; do
		read -p $'\033[32m[1]\033[1m '"Configure SMTP mail account? [y/N] "$'\e[0m' <&1 yn
		case $yn in
			[Yy]* )
				account="$(hostname)"
				read -ei "$account" -p $'\033[32m[a]\e[0m\033[1m '"Enter SMTP account name: "$'\e[0m' <&1 input
				account="${input:-$account}"
				smtp_host=smtp.gmail.com:587
				read -ei "$smtp_host" -p $'\033[32m[b]\e[0m\033[1m '"Enter SMTP host/port: "$'\e[0m' <&1 input
				smtp_host="${input:-$smtp_host}"
				smtp_email=$(hostname)@gmail.com
				read -ei "$smtp_email" -p $'\033[32m[c]\e[0m\033[1m '"Enter SMTP email address: "$'\e[0m' <&1 input
				smtp_email="${input:-$smtp_email}"
				smtp_from="$account <$smtp_email>"
				read -ei "$smtp_from" -p $'\033[32m[d]\e[0m\033[1m '"Enter FROM email address: "$'\e[0m' <&1 input
				smtp_from="${input:-$smtp_from}"

				cat >> ~/.mailrc <<- EOL
					account ${account} {
					    set smtp-use-starttls
						set ssl-verify=ignore
					    set smtp=${smtp_host}
					    set smtp-auth=login
					    set smtp-auth-user=${smtp_email}
					    set smtp-auth-password=$(cat)
					    set from="${smtp_from}"
					}

				EOL
				chmod 600 ~/.mailrc
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
else
	# app password must be passed through stdin
	echo -e $(
		cat <<- END
			Generate an App Password for your email first:\n
			https://support.google.com/accounts/answer/185833
		END
	)
	echo 'Usage: echo "password" | ./mail.sh'
fi