#!/bin/sh

status=$(bluetoothctl show | grep "Powered:")

case $1 in
	"status")
		[ "${status##* }" = "yes" ] && icon="" || icon=""
                echo $icon ;;
	"device")
		[ "${status##* }" = "yes" ] && text="Bluetooth is ON" || text="Bluetooth is OFF"
		echo $text ;;
	"power")
		[ "${status##* }" = "yes" ] && bluetoothctl power off || bluetoothctl power on ;;
esac
