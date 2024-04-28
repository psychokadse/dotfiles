#!/bin/bash

# take screenshot
# import -window root /tmp/screenshot.png

nitrogen_config_home=~/.config/nitrogen
blurred_path=/tmp/nitrogen-wallpaper-blur.png

if [[ ! -f $blurred_path ]]
then
	wallpaper_path=$(awk -F ' *= *' '/file/ {print $2}' $nitrogen_config_home/bg-saved.cfg) 
	
	convert $wallpaper_path -blur 0x5 $blurred_path
fi

# lock the screen
i3lock -i $blurred_path

# sleep adds a small delay to prevent possible race conditions with suspend
sleep 0.25

exit 0
