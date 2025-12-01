#!/bin/bash

function Help(){
	echo "Useage: iocFinder.bash [access log file] [IoC list File]"
}

if [ ${#} -ne 2 ]; then
	Help
elif [ ${#} -eq 2 ]; then
	cat $1 | grep -f $2 | cut -d ' ' -f1,4,7 | tr -d '[' > report.txt
fi
