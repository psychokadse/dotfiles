/usr/lib/at-spi-bus-launcher --launch-immediately &
lxpolkit &
flameshot &
jetbrains-toolbox --minimize &
nm-applet &

# Start X11-specific applications
if [[ -z $WAYLAND_DISPLAY ]]; then
	feh --bg-fill $WM_WALLPAPER &
	picom &
	start-pulseaudio-x11 &
else
	# Wayland-specific applications
	swaybg -i $WM_WALLPAPER -m fill &
fi
