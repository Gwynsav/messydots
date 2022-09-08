#!/bin/sh
# IMPORTANT NOTE.
# For me in specific, trying to use my city code from OpenWeatherMap has never worked so I mainly rely on using my latitude and longitude instead, if using your city id doesn't work I recommend you try the same.
# Your City code, latitude and longitude can all be found in https://openweathermap.org/. Your key is unique to your account so go there and get one.

KEY="YOURKEYHERE"
CITY="YOURCITYCODEHERE"
LAT=""
LON=""
weather=$(curl -sf "api.openweathermap.org/data/2.5/weather?id=$CITY&appid=$KEY&units=metric")
# weather=$(curl -sf "api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$KEY&units=metric")

weather_desc=$(echo $weather | jq -r ".weather[0].main")
weather_temp=$(echo $weather | jq ".main.temp") && weather_temp=${weather_temp%%.*}
feels_like=$(echo $weather | jq ".main.feels_like") && feels_like=${feels_like%%.*}
humidity=$(echo $weather | jq ".main.humidity")

case $1 in
	current_temp)
		[ -z "$weather_temp" ] && weather_temp="n/a"
		echo "$weather_temp°C" ;;
	feels_like)
		[ -z "$feels_like" 	 ] && feels_like="n/a"
		echo "$feels_like°C" 	 ;;
	humidity)
		[ -z "$humidity" 		 ] || humidity="n/a"
		echo $humidity 				 ;;
	weather_desc)
		text="Disconnected"
		[ "$weather_desc" = "Clouds" ] && text="It's Cloudy"
		[ "$weather_desc" = "Clear"  ] && text="It's Clear"
		[ "$weather_desc" = "Rain" 	 ] && text="It's Rainy"
		echo $text ;;
	weather_desc_icon)
		time=$(date '+%H')
		icon=""
		if [ "$weather_desc" = "Clouds" ]; then
			[ $time -gt 20 -o $time -lt 08 ] && icon="" || icon=""
		elif [ "$weather_desc" = "Clear" ]; then
			[ $time -gt 20 -o $time -lt 08 ] && icon="" || icon=""
		elif [ "$weather_desc" = "Rain" ]; then
			[ $time -gt 20 -o $time -lt 08 ] && icon="" || icon=""
		fi
		echo $icon ;;
esac
