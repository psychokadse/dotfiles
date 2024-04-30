#!/bin/bash

# Exit status codes:
# 0 - All okay, no errors
# 1 - Executable dependency not found
# 2 - Required script not found
# 3 - Script error, script function misused
# 4 - User error, run as root

# Record the exit status
errno=0

# Notify and exit if dependency isn't found
function ensure-installed {
	if [[ $# -ne 1 ]]
	then
		echo -e "Function ensure-installed takes exactly one argument, $# given.\nAborting." 1>&2
		errno=3
		exit $errno
	fi

	# Dependency must be found and executable
	if [[ ! -x $(which $1) ]]
	then
		echo "Executable dependency $1 could not be found. Make sure it is installed correctly." 1>&2
		errno=1
		return $(false)
	else
		return $(true)
	fi
}

# Notify about excess arguments
if [[ $# -ne 0 ]]
then
	echo "Script takes no arguments, $# given. Excess arguments are ignored." 1>&2
fi

# Prohibit running script as root
if [[ $(id -u) -eq 0 ]]
then
	echo -e "Script must not be run as root.\nAborting." 1>&2
	errno=4
	exit $errno
fi

# Upgrade all installed pacman packages
ensure-installed pacman && sudo pacman -Syu

# Upgrade all remaining packages from the AUR
ensure-installed yay && yay -Syu

OMZ_HOME=~/.oh-my-zsh
OMZ_UPGRADE_TOOL=$OMZ_HOME/tools/upgrade.sh

# Upgrade oh-my-zsh and zsh plugins
if ensure-installed zsh && [[ -x $OMZ_UPGRADE_TOOL ]]
then
	# Upgrade oh-my-zsh using the included tool
	zsh -c "$OMZ_UPGRADE_TOOL"

	OMZ_CUSTOM=${ZSH_CUSTOM:-$OMZ_HOME/custom}

	# Upgrade custom zsh plugins
	# Do for all subdirectories in directory (except example)
	find $OMZ_CUSTOM/plugins \
		-mindepth 1 -maxdepth 1 -type d -not -name example \
		| while read -r dir
	do
		# Upgrade via git pull if directory is a git repository
		git -C $dir rev-parse --is-inside-work-tree 1>/dev/null 2>&1 && git -C $dir pull
	done
else
	echo "oh-my-zsh upgrade tool could not be found at path $OMZ_UPGRADE_TOOL. Make sure it is installed correctly." 1>&2
	errno=2
fi

exit $errno
