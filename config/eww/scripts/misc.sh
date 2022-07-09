#!/bin/sh

# This is super specific to my own use case, feel free to edit it or remove it. The "language" bar widget does call it so consider repurposing that as well.

lang=$(setxkbmap -query | grep "layout:")

case $1 in
	"launcher")
		sh $HOME/.local/bin/appmnu ;;
	"lang")
		if [ ${lang##* } = "us" ]; then
			setxkbmap latam
			dunstify -h string:x-dunst-stack-tag:lang -i "~/.local/share/icons/Zafiro-icons/categories/22/applications-office.svg" "Keyboard Layout" "Set to Latinamerican Spanish"
		else
			setxkbmap us
			dunstify -h string:x-dunst-stack-tag:lang -i "~/.local/share/icons/Zafiro-icons/categories/22/applications-office.svg" "Keyboard Layout" "Set to American English"
		fi ;;
	"month")
		a=$(date -u '+%m')
		echo $((a-1)) ;;
esac
