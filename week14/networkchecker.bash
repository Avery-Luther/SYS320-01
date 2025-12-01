#!/bin/bash

myIP=$(bash ../week9/ipAddress.bash)


# Todo-1: Create a helpmenu function that prints help for the script
function Help(){
	echo -e "\tHELP MENU"
	echo -e "-------------------------"
	echo -e "-n: nmap scan"
	echo -e "\t-n external: External nmap scan"
	echo -e "\t-n internal: Internal nmap scan"
	echo -e "-s: ss scan"
	echo -e "\t-s external: External ss scan"
	echo -e "\t-s internal: Internal ss scan"
	echo -e "Usage: bash networkchecker.bash -n/-s external/internal"
	echo -e "-------------------------"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){

# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
	elpo=$(ss -ltpn | awk -F"[[:space:]:(),]+" '!/127.0.0./ && !/\[/ && !/Address/ {print $5,$9}' | tr -d "\"")
}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)

if [ ${#} -ne 2 ]; then
	Help
fi

while getopts "ns" option
do
	case $option in 
	n)
		if [[ $2 == "internal" ]]; then
			InternalNmap
			echo "$rin"
		elif [[ $2 == "external" ]]; then
			ExternalNmap
			echo "$rex"
		fi
	;;	
	s)
		if [[ $2 == "internal" ]]; then
			InternalListeningPorts
			echo "$ilpo"
		elif [[ $2 == "external" ]]; then
			ExternalListeningPorts
			echo "$elpo"
		fi
	;;
	?)
		Help
	esac
done 
