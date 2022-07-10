#!/bin/sh	

player=$(playerctl -p %any,firefox status)
title=$(playerctl metadata --format '{{ title }}')
artist=$(playerctl metadata --format '{{ artist }}')
album=$(playerctl metadata --format '{{ album }}')

position=$(playerctl position)
position=${position%%.*}
duration=$(playerctl metadata mpris:length)
duration=${duration%000000*}

case $1 in
	"status")
	    [ "$player" = "Playing" ] && status="You're listening to:" || status="Not playing media"
            echo $status ;;
	"statusbut")
	    [ "$player" = "Playing" ] && icon="" || icon=""
            echo $icon ;;
	"title")
            [ -z "$title" ] && title="Nothing Playing"
            echo $title ;;
	"artist")
            [ -z "$artist" ] && artist="Unknown"
            echo $artist ;;
	"album")
            [ -z "$album" ] && album=""
            echo $album ;;
	"dispprog")
	    [ $(playerctl metadata mpris:length | wc -c) -gt 0 ] && printf "%02d:%02d" $((position%3600/60)) $((position%60)) && printf " / " && printf "%02d:%02d" $((duration%3600/60)) $((duration%60)) || printf "00:00 / 00:00" ;;
	"progress")
	    echo $((position*100/duration)) ;;
	"duration")
	    echo $duration ;;
esac
