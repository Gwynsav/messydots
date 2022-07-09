#!/bin/sh

status=$(bluetoothctl show | grep "Powered:")

case $1 in
	"status")
		if [ "${status##* }" = "yes" ]; then
			echo ""
		else
			echo ""
		fi ;;
	"device")
		if [ "${status##* }" = "yes" ]; then
			echo "Bluetooth is ON"
		else
			echo "Bluetooth is OFF"
		fi ;;
	"power")
		if [ "${status##* }" = "yes" ]; then
			bluetoothctl power off
		else
			bluetoothctl power on
		fi ;;
esac
