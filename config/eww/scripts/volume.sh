#!/bin/sh

device=$(amixer | grep -w "Simple mixer control" | tr -d ''\')
device=${device%%,*}
device=${device##*control }

case $1 in
	"audevice")
		echo $device ;;
	"sysvol")
		echo $(amixer sget $device | grep "Left:" | awk -F '[][%]' '{print $2}') ;;
	"sysmute")
		vol=$(amixer sget $device | grep "Left:")
		if [ "${vol##* }" = "[off]" ]; then
			echo ""
		else
			echo ""
		fi ;;
	"micvol")
		echo $(amixer sget Capture | grep "Mono:" | awk -F '[][%]' '{print $2}') ;; 
	"micmute")
		vol=$(amixer sget Capture | grep "Mono:")
		if [ "${vol##* }" = "[off]" ]; then
			echo ""
		else
			echo ""	
		fi ;;
	"musvol")
		vol=$(playerctl -p %any,firefox volume)
		vol=${vol##*.}
		echo ${vol%0000*} ;;
esac
