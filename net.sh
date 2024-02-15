#!/bin/bash

# IPs
## find available render machines at subnet
subnet="10.6.14"
## expected range of host machines
hosts=$(seq 51 60)

# declare an empty array of reachble IPs
declare -a reachable=()

for host in $hosts; do
	ip="${subnet}.${host}"
	# count 1, wait 2
	if ping -c 1 -W 2 "$ip" > /dev/null; then
		echo "[OK] Host $ip is reachable."
		# add to array
		reachable+=("$ip")
	else
		echo "[  ] Host $ip is unreachable!"
	fi
done

# print all reachable IPs from array
#echo "List of reachable IPs:"
#for ip in ${reachable[@]}; do
#	echo "	> $ip"
#done
