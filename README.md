To be used with GNU Stow. Usage: * Clone this repo into your stow directory (the parent directory should be the target directory)
* Run 'mkdir -p .config .local/share' in the target directory to create the required file structure
* Install packer for neovim according to the instructions on GitHub
* Open '.config/nvim/lua/psychokadse/packer.lua' in neovim and source it
* Run ':PackerSync' in nvim to install the necessary packages
* Run 'stow .' in the stow directory
* If you want to stow global configuration files as well, run a separate stow on stow directory 'global' and target directory '/etc'
* 'wallpapers' is not intended to be stowed, just copy the desired images to a directory of your choice

Notes:
* 'global/etc/X11/xorg.conf.d/00-keyboard.conf' should be adjusted to fit keyboard layout
* 'theme' variable in .config/rofi/launchers/type-3/launcher.sh should be changed to 'style-10'

Also install:
* Flameshot
* Discord
* Thunderbird
* Htop
* GIMP

Uninstall:
* rxvt-unicode-truecolor, it's no good, use standard rxvt-unicode instead
