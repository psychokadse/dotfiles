#!/bin/env bash

_tmux_command='tmux -u2'
_default_session=$(basename $PWD)

if [[ $# == 0 ]]; then
	# Invoke default command if no other arguments are specified
	if tmux run &>/dev/null; then
		if tmux has-session -t "$_default_session" &>/dev/null; then
			# Attach to last session if default session exists
			$_tmux_command attach
		else
			# Create default session and attach to it if it doesn't exist
			$_tmux_command new -s "$_default_session"
		fi
	else
		$_tmux_command new -ds dotfiles -c ~/.dotfiles
		$_tmux_command new -ds home -c ~
		$_tmux_command new -s "$_default_session"
	fi
else
	# Invoke original command if other arguments are specified
	$_tmux_command $@
fi
