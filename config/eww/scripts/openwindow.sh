#!/bin/sh

eww="/usr/bin/eww"
case $1 in
	"bar")
		lock="$HOME/.cache/bar.lck"
		if [ ! -f "$lock" ]; then
			touch "$lock"
			$eww close bar; sleep 0.4
			bspc config left_padding 0
		else
			rm "$lock"
			bspc config left_padding 41
			sleep 0.4; $eww open bar && xdo lower -N eww-bar
		fi ;;
	"calendar")
		lock="$HOME/.cache/cal.lck"
		if [ ! -f "$lock" ]; then
			touch "$lock"
			$eww open calendar
			$eww update call=true
		else
			$eww update call=false
			sleep 0.075
			$eww close calendar
			rm "$lock"
		fi ;;
	"syspanel")
		lock="$HOME/.cache/sysp.lck"
		if [ ! -f "$lock" ]; then
			touch "$lock"
			$eww open systempanel
			$eww update sysp=true
		else
			$eww update call=false && $eww update sysp=false && $eww update power=false && $eww update ftch=false
			sleep 0.075
			$eww close calendar systempanel powermenu fetch
			rm "$lock" && rm "$HOME/.cache/ftch.lck" && rm "$HOME/.cache/cal.lck" && rm "$HOME/.cache/power.lck"
		fi ;;
	"fetch")
		lock="$HOME/.cache/ftch.lck"
		if [ ! -f "$lock" ]; then
			touch "$lock"
			$eww open fetch
			$eww update ftch=true
		else
			$eww update ftch=false
			sleep 0.075
			$eww close fetch
			rm "$lock"
		fi ;;
	"power")
		lock="$HOME/.cache/power.lck"
		if [ ! -f "$lock" ]; then
			touch "$lock"
			$eww open powermenu
			$eww update power=true
		else
			$eww update power=false
			sleep 0.075
			$eww close powermenu
			rm "$lock"
		fi ;;
esac
