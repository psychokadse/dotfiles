## Description:
To be used with GNU Stow.

## Usage: 
1. Clone this repo into your stow directory (the parent directory should be the target directory)
2. Run 'mkdir -p .config' in the target directory to create the required file structure
3. Install packer for neovim according to the instructions on GitHub
4. Open '.config/nvim/lua/psychokadse/packer.lua' in neovim and source it
5. Run ':PackerSync' in nvim to install the necessary packages
6. Run 'stow .' in the stow directory
7. If you want to stow global configuration files as well, run a separate stow on stow directory 'global' and target directory '/etc'
8. 'wallpapers' is not intended to be stowed, just copy the desired images to a directory of your choice

## Notes:
* 'global/etc/X11/xorg.conf.d/00-keyboard.conf' should be adjusted to fit keyboard layout
* 'theme' variable in .config/rofi/launchers/type-3/launcher.sh should be changed to 'style-10'

## Required packages:
* flameshot
* i3
* i3exit (AUR)
* neovim
* nitrogen
* picom
* rofi
* rxvt-unicode
* stow
* tmux
* zsh

## Other dependencies (in order):
* https://github.com/ohmyzsh/ohmyzsh
* https://github.com/zdharma-continuum/fast-syntax-highlighting
* https://github.com/marlonrichert/zsh-autocomplete
* https://github.com/zsh-users/zsh-autosuggestions
* https://github.com/romkatv/powerlevel10k (the recommended fonts are required!)
* https://github.com/adi1090x/rofi
* https://github.com/wbthomason/packer.nvim
