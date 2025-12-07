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

source_zsh_plugin() {
	if [[ -n $1 ]]; then
		local current_plugin=$ZSH_PLUGINS/$1/$1.plugin.zsh
		source $current_plugin
	fi
}

source_zsh_theme() {
	if [[ -n $1 ]]; then
		local current_theme=$ZSH_THEMES/$1/$1.zsh-theme
		source $current_theme
	fi
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
bindkey '^R' history-incremental-search-backward # This also exits the search

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

# Use fd instead of find for fzf completions
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Source completions for fzf
# This is preferable to invoking fzf --zsh on systems with outdated packages
[[ ! -f ${ZDOTDIR}/fzf/completion.zsh ]] || source ${ZDOTDIR}/fzf/completion.zsh

# Source keybindings for fzf
# This has to be included in addition to completion.zsh,
# as these files are separate outside of tmux's builtin shell integration via tmux --zsh
[[ ! -f ${ZDOTDIR}/fzf/key-bindings.zsh ]] || source ${ZDOTDIR}/fzf/key-bindings.zsh

# Overwrite '**' completion functions to use fd instead of find
_fzf_compgen_path() {
	fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git . "$1"
}

# Use zoxide configuration for zsh
eval "$(zoxide init zsh)"

# Set up nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Load Angular CLI autocompletion if available
npm list -g --depth=0 | grep -q '@angular/cli' && source <(ng completion script)

# Automatically export SSH_AUTH_SOCK if using systemd user ssh-agent
if [[ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Set zsh environment variables
# Configure history file
export HISTFILE=~/.zsh_history
export HISTSIZE=20000
export SAVEHIST=$HISTSIZE

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
[[ -f ${ZDOTDIR}/.p10k.zsh ]] && source ${ZDOTDIR}/.p10k.zsh

# Source ghcup environment
[[ -f ${HOME}/.ghcup/env ]] && source ${HOME}/.ghcup/env
