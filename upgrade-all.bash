#!/bin/bash

function ensure-installed {
	if [[ $# -ne 1 ]]
	then
		echo -e "Function ensure-installed takes exactly one argument, $# given.\nAborting."
		exit $(false)
	fi

	if [[ ! -x $(which $1) ]]
	then
		echo -e "Executable $1 could not be found. Make sure it is installed correctly.\nAborting." 
		exit $(false)
	else
		return $(true)
	fi
}

# Upgrade all pacman packages
ensure-installed pacman && sudo pacman -Syu

# Upgrade all remaining packages from the AUR
ensure-installed yay && yay -Syu

OMZ_HOME=~/.oh-my-zsh
OMZ_UPGRADE_TOOL=$OMZ_HOME/tools/upgrade.sh

# Update Oh My Zsh
if ensure-installed zsh && [[ -x $OMZ_UPGRADE_TOOL ]]
then
	zsh -c "$OMZ_UPGRADE_TOOL"

	OMZ_CUSTOM=${ZSH_CUSTOM:-$OMZ_HOME/custom}

	# Upgrade custom Zsh plugins
	find $OMZ_CUSTOM/plugins \
		-mindepth 1 -maxdepth 1 -type d -not -name example \
		| while read -r dir
	do
		git -C $dir rev-parse --is-inside-work-tree 1>/dev/null 2>&1 && git -C $dir pull
	done
fi

exit 0
