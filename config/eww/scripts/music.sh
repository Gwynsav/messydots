#!/bin/sh	

# As is, this configuration does not support Spotify. Adding "spotify," to the beginning of the $player variable should technically work, but I haven't tested this since I don't use Spotify.

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
	    if [ "$player" = "Playing" ]; then
	       echo "You're listening to:"
	    else	
	       echo "Not playing media"
	    fi ;;
	"statusbut")
	    if [ "$player" = "Playing" ]; then
               echo ""
	    else	
	       echo ""
	    fi ;;
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
	    if [ $(playerctl metadata mpris:length | wc -c) -gt 0 ]; then
	       printf "%02d:%02d" $((position%3600/60)) $((position%60))
	       printf " / "
	       printf "%02d:%02d" $((duration%3600/60)) $((duration%60))
	    else
	       printf "00:00 / 00:00"
	    fi ;;
	"progress")
	    echo $((position*100/duration)) ;;
	"duration")
	    echo $duration ;;
esac
