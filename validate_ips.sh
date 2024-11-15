#!/bin/bash
while read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	host=$(echo "$line" | awk '{print $2}')

	if [["$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1-3}$ ]]; then
		echo "Valid IP: $ip for host $host"
	else
		echo "Invalid IP: $ip for gost $host"
	fi
done < /etc/hosts
