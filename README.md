# About .dotfiles
## Description:
Synchronizing my personal dotfiles and providing a reference for configuring my desktop according to my home machine.
To be used with GNU Stow on Arch Linux or distros based on Arch that provide pacman.

## Usage: 
1. Clone this repo into your stow directory (the parent directory should be the target directory)
2. Run `mkdir -p .config Pictures/wallpapers` in the target directory to create the required file structure
3. Install the required packages and other dependencies (see below)
4. Make Zsh your default shell
5. Remove any files that cause a conflict when stow is run (they'll be replaced by symlinks into .dotfiles)
6. Run `stow .` in the stow directory
7. Open `.config/nvim/lua/psychokadse/packer.lua` in Neovim and source it
8. Run `:PackerSync` in Neovim to install the necessary packages
9. If you want to stow global configuration files as well, run a separate stow on stow directory `.dotfiles/global` and target directory `/etc`
10. If you included step 9, run `cp -r Pictures/wallpapers /usr/share/wallpapers` as root in the stow directory to make the included wallpapers globally accessible

## Required packages (pacman with arch repos except AUR):
* dex
* firefox
* flameshot
* i3 (group)
* i3exit (AUR)
* neovim
* network-manager-applet
* nitrogen
* pavucontrol
* picom
* pulseaudio-alsa
* rofi
* rxvt-unicode
* stow
* tmux
* xss-lock
* zsh

## Other dependencies (Install these after required packages, follow order of list for ideal installation):
1. https://github.com/ohmyzsh/ohmyzsh
2. https://github.com/zdharma-continuum/fast-syntax-highlighting
3. https://github.com/marlonrichert/zsh-autocomplete
4. https://github.com/zsh-users/zsh-autosuggestions
5. https://github.com/romkatv/powerlevel10k (the recommended fonts are required!)
6. https://github.com/adi1090x/rofi
7. https://github.com/wbthomason/packer.nvim

## Notes:
* `NetworkManager.service` has to be enabled (systemd)
* `.dotfiles/global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* `theme` variable in `.config/rofi/launchers/type-3/launcher.sh` should be set to `'style-10'`
