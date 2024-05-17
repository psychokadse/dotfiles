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
    * apparmor
    * cronie
    * lightdm
    * NetworkManager
    * systemd-homed
    * systemd-resolved
    * systemd-timesyncd

    You can do this using the following the command:
    ```sh
    sudo systemctl enable apparmor cronie lightdm NetworkManager systemd-{homed,resolved,timesyncd}
    ```
6. Enable pulseaudio for your user so it starts automatically when a client attempts to connect:
   ```sh
   systemctl --user enable --now pulseaudio.socket
   ```
7. Set your hardware clock to use UTC rather than localtime:
   ```sh
   timedatectl set-local-rtc 0
   ```
8. Initialize and update the submodules defined in the repository with the most recent commit on the remote tracking branch:
    ```sh
    git submodule update --init --remote
    ```
    This needs to be run in the repository's root directory (`~/.dotfiles`) for git to interpret the submodule paths correctly.
    The required fonts for powerlevel10k still need to be installed manually.
9. Make zsh your default shell:
   ```sh
   chsh -s /usr/bin/zsh
   ```
10. Remove any files that cause a conflict when stow is run (they'll be replaced by symlinks into `.dotfiles`)
11. Create the required directory structure in your home directory to ensure the symlinks are created correctly:
      ```sh
      mkdir -p ~/{.ssh,.config/xfce4,Pictures} && rm -fr ~/.config/{autostart,i3,i3status}
      ```
12. Create symlinks from your home directory to the repository:
    ```sh
    stow -d ~/.dotfiles .
    ```
13. Source `~/.config/nvim/lua/psychokadse/packer.lua` in neovim and run `:PackerSync` to install the required packages.

    This can be done as a shell one-liner:
    ```sh
    nvim -c ':so ~/.config/nvim/lua/psychokadse/packer.lua | :PackerSync'
    ```
14. If you want to stow global configuration files as well, run a separate stow on stow directory `~/.dotfiles/global` and target directory `/etc`
15. If you included step 13, you also have to make the included wallpapers accessible system-wide:
    ```sh
    sudo cp -r ~/Pictures/wallpapers /usr/share/wallpapers
    ```

## Notes:
* copy `global/etc/default/grub` to `/etc/default/grub` and run `grub-mkconfig -o /boot/grub/grub.cfg` to update the grub configuration
* `global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* dunst is configured as a dbus service in `global/usr/share/dbus-1/services/org.freedesktop.Notifications.service`, copy the file to the appropriate location to run it on startup
* Run `xdg-user-dirs-update` to create standard XDG desktop directories below your home directory (this won't overwrite any existing files)
* The kernel module `i2c-dev` needs to be loaded in order to use `ddcutil`
* The identity files required in `.ssh/config` need to be generated using `ssh-keygen -t ed25519 -C <EMAIL_ADDRESS>`, and the public keys subsequently added to the corresponding GitHub accounts
* `global/etc/ld.so.conf` mirrors the necessary configuration to provide `xkb-switch` with the required shared objects created during the system-wide installation
* Run `git submodule update --remote` in the `~/.dotfiles` directory to update all submodules to the most recent commit on the remote tracking branch

## Required packages:
Install these using pacman, ideally from the official Arch repositories.
Get packages from the AUR where noted.
Install the yay AUR helper from https://github.com/Jguer/yay for easier installation of AUR packages.
A complete list of required packages is provided in [dependencies.list](/dependencies.list).
**When you're done installing these, move on to the [other dependencies](#other-dependencies).**

## Other dependencies:
Install these according to the instructions in their respective READMEs on GitHub.
Make sure you installed all of the required packages above.
Install zsh plugins into `.config/zsh/plugins` and zsh themes into `.config/zsh/themes`.
For an ideal installation, follow the list order.
1. https://github.com/Jguer/yay (if not already installed at this point)
2. https://github.com/zdharma-continuum/fast-syntax-highlighting
3. https://github.com/marlonrichert/zsh-autocomplete
4. https://github.com/zsh-users/zsh-autosuggestions
5. https://github.com/zsh-users/zsh-completions
6. https://github.com/romkatv/powerlevel10k (the recommended fonts are required!)
7. https://github.com/adi1090x/rofi
8. https://github.com/wbthomason/packer.nvim
9. https://github.com/grwlf/xkb-switch (use the system-wide install)  
10. https://www.jetbrains.com/toolbox-app
