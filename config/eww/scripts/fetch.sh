#!/bin/sh

# Here you should theorically only have to change the pkg variable to whatever commando can count your distro's packages, I left two examples there just in case.

os=$(cat "/etc/os-release" | grep -w "ID=" | tr -d '"')
case $1 in
	"os")
		echo ${os#*=} ;;
	"krn")
		krn=$(uname -r)
		echo ${krn%%_*} ;;
	"pkg")
           echo $(xbps-query -l | wc -l) || echo "unset" ;;
           # echo $(pacman -Q | wc -l)
	"sh")
		echo $(basename $(readlink -f /bin/sh)) ;;
	"upt")
		upt=$(uptime -p | tr -d 'poute')
		echo $upt ;;
	"uname")
		echo $(whoami) ;;
	"hname")
		echo $(hostname) ;;
esac
