#!/bin/sh

# I avoid using AWK.
device=$(iwctl device list)
device=${device##*-}
device=${device#* }

network=$(iwctl station ${device%% 2*} show | grep "Connected network")
status=$(iwctl station ${device%% 2*} show | grep "State")

case $1 in
	"status")
		if [ "${status##* }" = "connected" ]; then
			echo ""
		else
			echo ""
		fi ;;
	"network")
		if [ "${status##* }" = "connected" ]; then
			echo ${network##*network  }
		else
			echo "No connection"
		fi ;;
	"toggle")
		if [ -z "${status##* }" ]; then
			iwctl device ${device%% 2*} set-property Powered on
		else
			iwctl device ${device%% 2*} set-property Powered off
		fi ;;
esac
