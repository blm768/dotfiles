HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

#
# Prompt options
#

# Anonymous function to hide temporary variables from global scope
function {
	# TODO: show status of previous command (with color or symbol?
	local p_prefix='%F{1}[%f'
	local p_user='%n'
	# Only show hostname on SSH connections
	if [[ -z "$SSH_CLIENT" ]]; then
		local p_host=''
	else
		local p_host='@%m'
	fi
	local p_dir='%F{4}%~%f'
	local p_suffix='%F{1}]%(!.#.$)%f '

	PS1="${p_prefix}${p_user}${p_host} ${p_dir}${p_suffix}"
}

unsetopt beep
bindkey -v

autoload -Uz compinit
compinit

# Used on Arch with the zsh-syntax-highlighting package
function {
	local syntax_plugin=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	if [ -f "$syntax_plugin" ]; then
		source "$syntax_plugin"
	fi
}

#
# Aliases
#

alias ls='ls --color=auto'

#
# Get config options common to all (sh-like) shells
#

source ~/.profile

