# About .dotfiles
## Description:
This repository synchronizes my personal dotfiles and provides a reference for configuring my desktop based on my home machine.
To be used with GNU Stow on Arch Linux or distros based on Arch that provide pacman and systemd.

The actual configuration files are located in the `src` directory at the root of the repository's working tree.
All files outside this directory are related to the repository itself and should not be copied or symlinked into the user's environment.

## Usage:
1. Clone this repository into `~/.dotfiles`:
   ```sh
   git clone --recursive https://github.com/psychokadse/.dotfiles.git ~/.dotfiles
   ```

   This repository currently includes submodules for the plugins and themes required by the `.zshrc`, which should be synchronized regularly from the remote using:
   ```sh
   git submodule update --remote
   ```

   This is a list of the included submodules:
   * https://github.com/zdharma-continuum/fast-syntax-highlighting
   * https://github.com/marlonrichert/zsh-autocomplete
   * https://github.com/zsh-users/zsh-autosuggestions
   * https://github.com/zsh-users/zsh-completions
   * https://github.com/romkatv/powerlevel10k

2. Update your pacman mirrors and enable all servers:
   ```sh
   curl 'https://archlinux.org/mirrorlist/?country=DE&protocol=https&ip_version=4' | sed '/^#Server/s/^#//' | sudo tee /etc/pacman.d/mirrorlist > /dev/null
   ```
3. Force pacman to refresh its database:
   ```sh
   sudo pacman -Syy
   ```
4. Install the [required packages](#required-packages) and afterwards the [other dependencies](#other-dependencies).
5. Enable the following services using `systemctl` (requires a reboot):
    * apparmor
    * cronie
    * NetworkManager
    * systemd-resolved
    * systemd-timesyncd

    You can do this using the following the command:
    ```sh
    sudo systemctl enable apparmor cronie lightdm NetworkManager systemd-{resolved,timesyncd}
    ```
6. Enable pulseaudio for your user so it starts automatically when a client attempts to connect:
   ```sh
   systemctl --user enable --now pulseaudio.socket
   ```
7. Set your hardware clock to use UTC rather than localtime:
   ```sh
   timedatectl set-local-rtc 0
   ```
8. Make zsh your default shell:
   ```sh
   chsh -s /usr/bin/zsh
   ```
9. Run `xdg-user-dirs-update` to create the standard XDG desktop directories below your home directory. This won't overwrite any existing files.
10. Create the required directory structure in your home directory to ensure the symlinks are created correctly:
      ```sh
      mkdir -p ~/{.ssh,.config/xfce4}
      ```
11. Remove any files that cause a conflict when stow is run. They'll be replaced by symlinks into `.dotfiles/src`.
12. Create symlinks from your home directory to the repository:
    ```sh
    stow -d ~/.dotfiles src
    ```
13. Open `nvim` to install https://github.com/folke/lazy.nvim and the plugins in the plugin specification. `.config/nvim/init.lua` should source `.config/nvim/lua/psychokadse/lazy.lua` automatically, which installs lazy.nvim using `git clone` if it isn't present.
14. Recursively copy (using prompts to avoid accidental overwrites) the global configuration files under `~/.dotfiles/src/global/etc` and `~/.dotfiles/src/global/usr` into `/etc` and `/usr` respectively:
    ```sh
    sudo cp -ir ~/.dotfiles/src/global/{etc,usr} /
    ```
15. Finally, the included wallpapers have to be made accessible system-wide:
    ```sh
    sudo cp -r ~/Pictures/wallpapers /usr/share/wallpapers
    ```

## Notes:
* Copy `src/global/etc/default/grub` to `/etc/default/grub` and run `grub-mkconfig -o /boot/grub/grub.cfg` to update the grub configuration
* `src/global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* dunst is configured as a dbus service in `src/global/usr/share/dbus-1/services/org.freedesktop.Notifications.service`, copy the file to the appropriate location to run it on startup
* The kernel module `i2c-dev` needs to be loaded in order to use `ddcutil`
* The identity files required in `src/.ssh/config` need to be generated using `ssh-keygen -t ed25519 -C <EMAIL_ADDRESS>`, and the public keys subsequently added to the corresponding GitHub accounts
* `src/global/etc/ld.so.conf` mirrors the necessary configuration to provide `xkb-switch` with the required shared objects created during the system-wide installation
* If you need to move `.config/autostart` because it would be deleted, run `stow -d ~/.dotfiles -D src && mv -i ~/.dotfiles/src/.config/autostart ~/.config` to remove the symlinks created by stow and move the autostart directory to its proper location. Restow afterwards according to step 12 above.

## Required packages:
Install these using pacman, ideally from the official Arch repositories.
Get packages from the AUR where noted.
Install the yay AUR helper from https://github.com/Jguer/yay for easier installation of AUR packages.
A complete list of required packages is provided in [requirements.list](/requirements.list).
**When you're done installing these, move on to the [other dependencies](#other-dependencies).**

## Other dependencies:
Install these according to the instructions in their respective READMEs on GitHub.
Make sure you installed all of the required packages above.
Install zsh plugins into `.config/zsh/plugins` and zsh themes into `.config/zsh/themes`.
The recommended fonts for https://github.com/romkatv/powerlevel10k are required by a number of applications in this repository and included in their appropriate location in the `src/global` directory.
For an ideal installation, follow the list order.
1. https://github.com/Jguer/yay (if not already installed at this point)
2. https://github.com/adi1090x/rofi
3. https://github.com/grwlf/xkb-switch (use the system-wide install)
4. https://github.com/nvm-sh/nvm
5. https://www.jetbrains.com/toolbox-app
