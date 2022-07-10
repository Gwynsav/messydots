#!/bin/sh

device=$(amixer | grep -w "Simple mixer control" | tr -d ''\')
device=${device%%,*}
device=${device##*control }

case $1 in
	"audevice")
		echo $device ;;
	"sysvol")
		vol=$(amixer sget $device | grep "Left:")
                vol=${vol#*[}
                echo ${vol%%%*};;
	"sysmute")
		vol=$(amixer sget $device | grep "Left:")
                vol=${vol##*[}
		[ "${vol%%]*}" = "off" ] && icon="" || icon=""
                echo $icon ;;
	"micvol")
		mic=$(amixer sget Capture | grep "Mono:")
                mic=${mic#*[}
                echo ${mic%%%*};; 
	"micmute")
		mic=$(amixer sget Capture | grep "Mono:")
                mic=${mic##*[}
		[ "${mic%%]*}" = "off" ] && icon="" || icon=""
                echo $icon ;;
	"musvol")
		vol=$(playerctl volume)
		vol=${vol%0000*}
		[ "$vol" = "1.00" ] && vol=100 || vol=${vol##*.}
                echo $vol

esac
