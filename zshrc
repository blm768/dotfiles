HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

#
# Prompt options
#

PS1='%F{1}[%f%n@%m %F{4}%~%f%F{1}]%(!.#.$)%f '
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

