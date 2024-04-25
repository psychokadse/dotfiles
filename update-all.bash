#!/bin/bash

TRUE=0
FALSE=1

function ensure-installed {
	if [[ $# != 1 ]]
	then
		echo "ensure-installed takes exactly one argument, $# given"
		return $FALSE
	fi

	if [[ ! -x $(which $1) ]]
	then
		echo "Executable $1 could not be found. Make sure it is installed correctly" 
		return $FALSE
	else
		return $TRUE
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
	echo "$OMZ_UPGRADE_TOOL" | zsh

	OMZ_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

	# Upgrade custom Zsh plugins
	find $ZSH_CUSTOM_DIR -mindepth 1 -maxdepth 1 -type d -not -name example |\
	while IFS= read -r dir
	do
		[[ -d $dir/.git ]] && git -C $dir pull && echo "Updated $dir"
	done
fi

exit 0
