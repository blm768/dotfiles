HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

#
# Prompt options
#

# Anonymous function to hide temporary variables from global scope
function {
	# TODO: show status of previous command (with color or symbol?)
	# The directory color
	local c_dir='%F{4}'
	# Only show hostname on SSH connections
	if [[ -z "$SSH_CLIENT" ]]; then
		local p_host=''
		local c_accent='%F{1}'
	else
		local p_host='@%m'
		local c_accent='%F{6}'
	fi
	local p_prefix="${c_accent}[%f"
	local p_user='%n'
	local p_dir="${c_dir}%~%f"
	local p_suffix="$c_accent]%(!.#.$)%f "

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

