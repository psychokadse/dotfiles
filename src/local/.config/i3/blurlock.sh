#!/bin/bash

# Take screenshot
# import -window root /tmp/screenshot.png

waypaper_config_home=~/.config/waypaper
blurred_prefix=/tmp/wallpaper-blur_

# Get path of currently selected waypaper wallpaper
wallpaper_path_relative=$(eval echo $(awk -F ' *= *' '/^wallpaper/ {print $2}' "$waypaper_config_home/config.ini"))
wallpaper_path_absolute=$(realpath "$wallpaper_path_relative")

# Get only the file's basename
wallpaper_filename=$(basename $wallpaper_path_absolute)

# Concatenate to construct the blurred image's path
blurred_path=$blurred_prefix$wallpaper_filename.png

# Don't run if file already exists
if [[ ! -f $blurred_path ]]
then
	# Delete old files
	rm $blurred_prefix*

	magick $wallpaper_path_absolute -blur 0x5 $blurred_path
fi

update_keyboard_block='pkill -SIGRTMIN+10 i3blocks'

if [[ -v WAYLAND_DISPLAY ]]; then
	# Set keyboard layout to us before locking
	swaymsg 'input type:keyboard xkb_switch_layout 0' && $update_keyboard_block

	# Lock the screen
	swaylock -i $blurred_path
else
	# Set keyboard layout to us before locking
	xkb-switch -s us && $update_keyboard_block

	# Lock the screen
	i3lock -i $blurred_path
fi

# Sleep adds a small delay to prevent possible race conditions with suspend
sleep 0.25

exit 0
