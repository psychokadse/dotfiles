## Description:
To be used with GNU Stow.

## Usage: 
1. Clone this repo into your stow directory (the parent directory should be the target directory)
2. Run 'mkdir -p .config Pictures/wallpapers' in the target directory to create the required file structure
3. Install the required packages and other dependencies (see below)
4. Make zsh your default shell
5. Open '.config/nvim/lua/psychokadse/packer.lua' in neovim and source it
6. Run ':PackerSync' in nvim to install the necessary packages
7. Run 'stow .' in the stow directory
8. If you want to stow global configuration files as well, run a separate stow on stow directory 'global' and target directory '/etc'

## Required packages (pacman with arch repos except AUR):
* dex
* flameshot
* i3 (group)
* i3exit (AUR)
* neovim
* network-manager-applet
* nitrogen
* picom
* rofi
* rxvt-unicode
* stow
* tmux
* xss-lock
* zsh

## Other dependencies (in order):
* https://github.com/ohmyzsh/ohmyzsh
* https://github.com/zdharma-continuum/fast-syntax-highlighting
* https://github.com/marlonrichert/zsh-autocomplete
* https://github.com/zsh-users/zsh-autosuggestions
* https://github.com/romkatv/powerlevel10k (the recommended fonts are required!)
* https://github.com/adi1090x/rofi
* https://github.com/wbthomason/packer.nvim

## Notes:
* NetworkManager.service has to be enabled
* 'global/etc/X11/xorg.conf.d/00-keyboard.conf' should be adjusted to fit keyboard layout
* 'theme' variable in .config/rofi/launchers/type-3/launcher.sh should be set to 'style-10'
