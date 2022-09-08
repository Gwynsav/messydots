#!/bin/sh
dvc="wlan0" # change this to your device's name
net=$(iwctl station $dvc show)
ntnm=${net##*Connected network     } && ntnm=${ntnm%% *}
ntst=${net##*State                 } && ntst=${ntst%% *}

case $1 in
	"status")
		[ "$ntst" = "connected" ] && ico="" || ico=""
		echo $ico ;;
	"network")
		[ "$ntst" = "connected" ] || ntnm="No connection"
		echo $ntnm ;;
	"toggle")
		[ -z "$ntst" ] && pwr="on" || pwr="off"
		iwctl device $dvc set-property Powered $pwr ;;
esac
