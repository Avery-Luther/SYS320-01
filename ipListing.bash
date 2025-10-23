#!/bin/bash

[ $# -ne 1 ] && echo "Usage: ipList.bash <prefix>" && exit 1 

prefix=$1

for i in {1..254}
do
	echo $prefix.$i
done
