#!/bin/bash

mv ~/wallpapers/active/* ~/wallpapers/
entries=("$(ls -p ~/wallpapers/ | grep -v /)")

while true
do
	pkill hyprpaper

	wallpaper=''
	wp=''
	path=$(shuf -en1 '$HOME/wallpapers/active/')

	wallpaper=(${entries[0]})

	entries=${entries[@]/$wallpaper}
	entries=("${entries[@]}")
	entries+=" $wallpaper"


#	exec ~/paper.sh $wallpaper &

	mv ~/wallpapers/active/* ~/wallpapers/
	mv ~/wallpapers/$wallpaper ~/wallpapers/active/

	wp=$(shuf -en1 ~/wallpapers/active/$(ls ~/wallpapers/active/) | cut -d'/' -f6)
	echo -e "preload = $path$wp\nwallpaper = eDP-1,$path$wp" > ~/.config/hypr/hyprpaper.conf


	pkill hyprpaper
	hyprpaper &


	sleep 300
done

