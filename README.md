# About this repository
## Description
This repository synchronizes my personal dotfiles and provides a reference for configuring my desktop based on my home machine.
Most of the configuration is written with Linux in mind, but I am gradually improving cross-platform support for the tools that support it.

The actual configuration files are located in the `src` directory at the root of the repository's working tree.
All files outside this directory are related to the repository itself and should not be copied or symlinked into the user's environment.

## Installation
This repository uses chezmoi to sychronize the state between the source and the user's home directory.

chezmoi is also used to manage some external dependencies:
* https://github.com/zdharma-continuum/fast-syntax-highlighting
* https://github.com/marlonrichert/zsh-autocomplete
* https://github.com/zsh-users/zsh-autosuggestions
* https://github.com/zsh-users/zsh-completions
* https://github.com/romkatv/powerlevel10k
* https://github.com/ThePrimeagen/tmux-sessionizer
* https://github.com/tmux-plugins/tpm

These will be installed when first applying the target state using chezmoi and do not need to be managed manually.

Install and initialize the repository using chezmoi:
```sh
chezmoi init --branch cross-platform https://github.com/psychokadse/dotfiles.git
````

Bring the home directory into the target state:
```sh
chezmoi apply
```

To subsequently pull any changes and synchronize the home directory, run:
```sh
chezmoi update
```

## Required dependencies
**⚠️This section is incomplete⚠️**

These are used in the configuration and need to be installed manually for the it to work correctly.

## System configuration on Arch
This is the Linux setup these dotfiles are primarily used and developed on.
You can use this step-by-step guide to set up the system as originally intended.

1. Update your pacman mirrors and enable all servers:
   ```sh
   curl 'https://archlinux.org/mirrorlist/?country=DE&protocol=https&ip_version=4' | sed '/^#Server/s/^#//' | sudo tee /etc/pacman.d/mirrorlist > /dev/null
   ```
2. Force pacman to refresh its database:
   ```sh
   sudo pacman -Syy
   ```
3. Install the [required packages](#required-packages) and afterwards the [other dependencies](#other-dependencies).
4. Enable the following services using `systemctl` (requires a reboot):
    * apparmor
    * cronie
    * NetworkManager
    * systemd-resolved
    * systemd-timesyncd

    You can do this using the following the command:
    ```sh
    sudo systemctl enable apparmor cronie lightdm NetworkManager systemd-{resolved,timesyncd}
    ```
5. Enable pulseaudio for your user so it starts automatically when a client attempts to connect:
   ```sh
   systemctl --user enable --now pulseaudio.socket
   ```
6. Set your hardware clock to use UTC rather than localtime:
   ```sh
   timedatectl set-local-rtc 0
   ```
7. Make zsh your default shell:
   ```sh
   chsh -s /usr/bin/zsh
   ```
8. Run `xdg-user-dirs-update` to create the standard XDG desktop directories below your home directory. This won't overwrite any existing files.
9. Open `nvim` to install https://github.com/folke/lazy.nvim and the plugins in the plugin specification. `~/.config/nvim/init.lua` should source `~/.config/nvim/lua/psychokadse/lazy.lua` automatically, which installs lazy.nvim using `git clone` if it isn't present.
10. Recursively copy (using prompts to avoid accidental overwrites) the global configuration files under `~/.dotfiles/src/global/etc` and `~/.dotfiles/src/global/usr` into `/etc` and `/usr` respectively:
    ```sh
    sudo cp -ir ~/.dotfiles/src/global/{etc,usr} /
    ```
11. Finally, the included wallpapers have to be made accessible system-wide:
    ```sh
    sudo cp -r ~/Pictures/wallpapers /usr/share/wallpapers
    ```

### Notes
* Copy `~/.dotfiles/src/global/etc/default/grub` to `/etc/default/grub` and run `grub-mkconfig -o /boot/grub/grub.cfg` to update the grub configuration
* `~/.dotfiles/src/global/etc/X11/xorg.conf.d/00-keyboard.conf` should be adjusted to fit keyboard layout (`Option "XkbModel"` set to `"pc104"` for US, and `"pc105"` for German keyboard)
* dunst is configured as a dbus service in `~/.dotfiles/src/global/usr/share/dbus-1/services/org.freedesktop.Notifications.service`, copy the file to the appropriate location to run it on startup
* The kernel module `i2c-dev` needs to be loaded in order to use `ddcutil`
* Any ssh keys need to be generated using `ssh-keygen -t ed25519 -C <EMAIL_ADDRESS>`, and the public keys subsequently added to the corresponding GitHub accounts
* `~/.dotfiles/src/global/etc/ld.so.conf` mirrors the necessary configuration to provide `xkb-switch` with the required shared objects created during the system-wide installation

### Required packages
Install these using pacman, ideally from the official Arch repositories.
Get packages from the AUR where noted.
Install the yay AUR helper from https://github.com/Jguer/yay for easier installation of AUR packages.
A complete list of required packages is provided in [requirements.toml](/requirements.toml).
**When you're done installing these, move on to the [other dependencies](#other-dependencies).**

### Other dependencies
Install these according to the instructions in their respective READMEs on GitHub.
Make sure you installed all of the required packages above.
Install zsh plugins into `~/.config/zsh/plugins` and zsh themes into `~/.config/zsh/themes`.
The recommended fonts for https://github.com/romkatv/powerlevel10k are required by a number of applications in this repository and included in their appropriate location in the `src/global` directory.
For an ideal installation, follow the list order.
1. https://github.com/Jguer/yay (if not already installed at this point)
2. https://github.com/adi1090x/rofi
3. https://github.com/grwlf/xkb-switch (use the system-wide install)
4. https://github.com/nvm-sh/nvm
5. https://www.jetbrains.com/toolbox-app
