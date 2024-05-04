# About .dotfiles
## Description:
This repository synchronizes my personal dotfiles and provides a reference for configuring my desktop based on my home machine.
To be used with GNU Stow on Arch Linux or distros based on Arch that provide pacman and systemd.

## Usage:
1. Clone this repository into your stow directory (`~/.dotfiles`):

   ```sh
   git clone https://github.com/psychokadse/.dotfiles.git ~/.dotfiles
   ```
2. Update your pacman mirrors and enable all servers:

   ```sh
   curl 'https://archlinux.org/mirrorlist/?country=DE&protocol=https&ip_version=4' | sed '/^#Server/s/^#//' | sudo tee /etc/pacman.d/mirrorlist > /dev/null
   ```
3. Force pacman to refresh its database:

   ```sh
   sudo pacman -Syy
   ```
4. Install the [required packages](#required-packages) and afterwards the [other dependencies](#other-dependencies)
5. Enable the following services using `systemctl` (requires a reboot):
    * `apparmor.service`
    * `lightdm.service`
    * `NetworkManager.service`
    * `systemd-homed.service`
    * `systemd-resolved.service`
    * `systemd-timesyncd.service`
    
    ```sh
    sudo systemctl enable apparmor lightdm NetworkManager systemd-{homed,resolved,timesyncd}
    ```
6. Set your hardware clock to use UTC rather than localtime:

   ```sh
   timedatectl set-local-rtc 0
   ```
7. Make zsh your default shell
8. Remove any files that cause a conflict when stow is run (they'll be replaced by symlinks into `.dotfiles`)
9. Create the required directory structure in your home directory to ensure the symlinks are created correctly:

   ```sh
   mkdir -p ~/{.ssh,.config/xfce4,Pictures/wallpapers} && rm -fr ~/.config/{autostart,i3,i3status}
   ```
10. Create symlinks from your home directory to the repository:
      ```sh
      stow -d ~/.dotfiles .
      ```
11. Open `~/.config/nvim/lua/psychokadse/packer.lua` in Neovim and source it
12. Run `:PackerSync` in Neovim to install the necessary packages
13. If you want to stow global configuration files as well, run a separate stow on stow directory `~/.dotfiles/global` and target directory `/etc`
14. If you included step 13, you also have to make the included wallpapers accessible system-wide:

      ```sh
      sudo cp -r ~/Pictures/wallpapers /usr/share/wallpapers
      ```

## Notes:
* copy `global/etc/default/grub` to `/etc/default/grub` and run `grub-mkconfig -o /boot/grub/grub.cfg` to update the grub configuration
* `global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* The `path` in `cpu_temperature 0` inside `.config/i3status/config` may need to be adjusted to your system's temperature input
* dunst is configured as a dbus service in `global/usr/share/dbus-1/services/org.freedesktop.Notifications.service`, copy the file to the appropriate location to run it on startup
* Run `xdg-user-dirs-update` to create standard XDG desktop directories below your home directory (this won't overwrite any existing files)
* The kernel module `i2c-dev` needs to be loaded in order to use `ddcutil`
* The identity files required in `.ssh/config` need to be generated using `ssh-keygen -t ed25519 -C '<EMAIL_ADDRESS>'`, and the public keys subsequently added to the corresponding GitHub accounts
* `global/etc/ld.so.conf` mirrors the necessary configuration to provide `xkb-switch` with the required shared objects created during the system-wide installation

## Required packages:
Install these using pacman, ideally from the official Arch repositories.
Get packages from the AUR where noted.
Install the yay AUR helper from https://github.com/Jguer/yay for easier installation of AUR packages.
**When you're done installing these, move on to the [other dependencies](#other-dependencies).**
* accountsservice
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
* fastfetch
* firefox
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
* imagemagick
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
* nvidia
* nvidia-settings
* openresolv
* os-prober
* pavucontrol
* picom
* plantuml
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
* xorg-xinit
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
9. https://github.com/grwlf/xkb-switch (use the system-wide install)  
10. https://www.jetbrains.com/toolbox-app
