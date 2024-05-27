# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_PLUGINS=$ZDOTDIR/plugins
ZSH_THEMES=$ZDOTDIR/themes

# Set zsh internal options
setopt SHARE_HISTORY # Share history between sessions, don't overwrite history
setopt BANG_HIST
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_GLOB # Set temporarily for compiling completions

# Load functions necessary for compdump
autoload -Uz zrecompile
autoload -Uz compinit

DUMP_FILE=$ZSH_COMPDUMP

# Compile completions into compdump
if [[ -s $DUMP_FILE(#qN.mh+24) && (! -s "$DUMP_FILE.zwc" || "$DUMP_FILE" -nt "$DUMP_FILE.zwc") ]]; then
	compinit -i -d $ZSH_COMPDUMP
	zrecompile $ZSH_COMPDUMP
fi

compinit -C

unsetopt EXTENDED_GLOB

function source_zsh_plugin () {
	[[ -n $1 ]] \
		&& local CURRENT_PLUGIN=$ZSH_PLUGINS/$1/$1.plugin.zsh \
		&& source $CURRENT_PLUGIN
}

function source_zsh_theme () {
	[[ -n $1 ]] \
		&& local CURRENT_THEME=$ZSH_THEMES/$1/$1.zsh-theme \
		&& source $CURRENT_THEME
}

# Add zsh-completions by adding it to the $fpath
fpath=("${ZSH_PLUGINS}/zsh-completions/src" $fpath)

# Load zsh plugins
source_zsh_plugin fast-syntax-highlighting
source_zsh_plugin zsh-autocomplete
source_zsh_plugin zsh-autosuggestions

# Set zsh prompt theme
source_zsh_theme powerlevel10k

# Default coloring for GNU-based ls
# Define LS_COLORS via dircolors if available. Otherwise, set a default
# equivalent to LSCOLORS (generated via https://geoff.greer.fm/lscolors)
if (( $+commands[dircolors] )); then
	[[ -f "$HOME/.dircolors" ]] \
	&& source <(dircolors -b "$HOME/.dircolors") \
	|| source <(dircolors -b)
else
	export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

# Set menuselect as completion keymap
zstyle ':completion:*' menu select

# Enable menu selecction dircolors using $LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Set vi insert mode key bindings for command line editing
bindkey -v

# Disable entering vicmd mode using `alt`
bindkey -r '^['

# Set useful custom key bindings
bindkey '\e' vi-cmd-mode
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^[f' forward-word
bindkey '^[b' backward-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '\t' menu-select # Enter menu selection

# Set key bindings for vicmd (vi normal) mode
bindkey -M vicmd '^U' backward-kill-line
bindkey -M vicmd '^K' kill-line
bindkey -M vicmd '\e' vi-insert

# Set vi key bindings for completion selection
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Enable editing of command line in standard editor
# Load the edit-command-line widget and bind it to a key sequence
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Set zsh environment variables
# Configure history file
export HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=$HISTSIZE

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Source custom aliases
[[ -f ${ZDOTDIR}/aliases.zsh ]] && source ${ZDOTDIR}/aliases.zsh

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh
