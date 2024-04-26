# About .dotfiles
## Description:
This repo synchronizes my personal dotfiles and provides a reference for configuring my desktop according to my home machine.
To be used with GNU Stow on Arch Linux or distros based on Arch that provide pacman.

## Usage: 
1. Clone this repo into your target directory so it can act as the stow directory
2. Install the [required packages](#required-packages) and afterwards the [other dependencies](#other-dependencies)
3. Make Zsh your default shell
4. Remove any files that cause a conflict when stow is run (they'll be replaced by symlinks into .dotfiles)
5. Run `mkdir -p .config/i3status .config/xfce4/xfconf Pictures/wallpapers` in the target directory to create the required file structure
6. Run `stow .` in the stow directory
7. Open `.config/nvim/lua/psychokadse/packer.lua` in Neovim and source it
8. Run `:PackerSync` in Neovim to install the necessary packages
9. If you want to stow global configuration files as well, run a separate stow on stow directory `.dotfiles/global` and target directory `/etc`
10. If you included step 9, run `cp -r Pictures/wallpapers /usr/share/wallpapers` as root in the stow directory to make the included wallpapers globally accessible

## Notes:
* `NetworkManager.service`, `apparmor.service` and `lightdm.service` have to be enabled in systemd
* copy `global/etc/default/grub` to `/etc/default/grub` and run `grub-mkconfig -o /boot/grub/grub.cfg` to update the grub configuration
* `global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* The `path` in `cpu_temperature 0` inside `.config/i3status/config` may need to be adjusted to your system's temperature input
* dunst is configured as a dbus service in `global/usr/share/dbus-1/services/org.freedesktop.Notifications.service`, copy the file to the appropriate location to run it on startup
* Run `xdg-user-dirs-update` to create standard XDG desktop directories below your home directory (this won't overwrite any existing files)
* The kernel module `i2c-dev` needs to be loaded in order to use ddcutil

## Required packages:
Install these using pacman, ideally from the official Arch repositories.
Get packages from the AUR where noted.
Install the yay AUR helper from https://github.com/Jguer/yay for easier installation of AUR packages.
**When you're done installing these, move on to the [other dependencies](#other-dependencies).**
* apparmor
* arc-gtk-theme
* base
* base-devel
* bitwarden
* ddcutil
* dex
* discord
* docker
* docker-buildx
* docker-compose
* dunst
* firefox
* firefox-profile-switcher-connector-bin (AUR)
* flameshot
* fuse2
* gedit
* gimp
* git
* gparted
* graphviz
* gvfs
* htop
* i3 (group)
* i3exit (AUR)
* lightdm
* lightdm-gtk-greeter
* linux
* linux-firmware
* lxsession
* man-db
* man-pages
* neovim
* network-manager-applet
* nitrogen
* nmap
* ntp
* nvidia
* nvidia-settings
* openresolv
* os-prober
* pavucontrol
* picom
* plantuml
* polkit
* pulseaudio-alsa
* rofi
* rxvt-unicode-truecolor-wide-glyphs (AUR)
* sof-firmware
* stow
* strace
* thunar
* tmux
* tree
* valgrind
* virtualbox
* virtualbox-host-modules-arch
* wireguard-tools
* xdg-user-dirs
* xorg-xprop
* xorg-xrandr
* xss-lock
* zsh

## Other dependencies:
Install these according to the instructions in their respective READMEs on GitHub.
Make sure you installed all of the required packages above.
For an ideal installation, follow the list order.
1. https://github.com/Jguer/yay (if not already installed at this point)
2. https://github.com/ohmyzsh/ohmyzsh
3. https://github.com/zdharma-continuum/fast-syntax-highlighting
4. https://github.com/marlonrichert/zsh-autocomplete
5. https://github.com/zsh-users/zsh-autosuggestions
6. https://github.com/romkatv/powerlevel10k (the recommended fonts are required!)
7. https://github.com/adi1090x/rofi
8. https://github.com/wbthomason/packer.nvim
9. https://www.jetbrains.com/toolbox-app
