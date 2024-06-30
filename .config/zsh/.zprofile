if [[ -o interactive ]]; then
	return
fi

/usr/lib/at-spi-bus-launcher --launch-immediately &
lxpolkit &
gammastep -P &
flameshot &
jetbrains-toolbox --minimize &
nm-applet &

# Start X11-specific applications
if [[ ! -v WAYLAND_DISPLAY ]]; then
	WAYPAPER_BACKEND=feh
	picom &
	start-pulseaudio-x11 &
else
	# Wayland-specific applications
	WAYPAPER_BACKEND=swaybg
fi

waypaper --backend $WAYPAPER_BACKEND --fill fill --restore &
