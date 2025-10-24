#!/bin/bash

[ $# -ne 1 ] && echo "Usage: ipList.bash <prefix>" && exit 1 

prefix=$1

[ ${#prefix} -lt 5 ] && printf "Prefix length is too short \nPrefix example: 10.0.17\n" && exit 1

for i in {1..254}
do
	ping -W 1 -c 1 "$prefix.$i" | grep "64 bytes from" | grep -o -E \
		"[1-2]*[0-9]{1,2}.[1-2]*[0-9]{1,2}.[1-2]*[0-9]{1,2}.[1-2]*[0-9]{1,2}"
done
 
