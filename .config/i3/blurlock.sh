#!/bin/bash

# Take screenshot
# import -window root /tmp/screenshot.png

nitrogen_config_home=~/.config/nitrogen
blurred_prefix=/tmp/nitrogen-wallpaper-blur_

# Get path of currently selected nitrogen wallpaper
wallpaper_path=$(awk -F ' *= *' '/file/ {print $2}' $nitrogen_config_home/bg-saved.cfg) 

# Get only the file's basename
wallpaper_filename=$(basename $wallpaper_path)

# Concatenate to construct the blurred image's path
blurred_path=$blurred_prefix$wallpaper_filename.png

# Don't run if file already exists
if [[ ! -f $blurred_path ]]
then
	# Delete old files
	rm $blurred_prefix*

	convert $wallpaper_path -blur 0x5 $blurred_path
fi

# Lock the screen
i3lock -i $blurred_path

# Sleep adds a small delay to prevent possible race conditions with suspend
sleep 0.25

exit 0
