#
# ~/.profile
# Common options for all my sh-like shells

#
# Paths
#

function in_path() {
	which "$1" > /dev/null 2>&1
}

export GEM_HOME="$HOME/.gem"
export PATH="$PATH:$HOME/.local/bin:$GEM_HOME/ruby/2.3.0/bin:$GEM_HOME/bin"

#
# Editor
#

if in_path nvim; then
	export VISUAL=nvim
elif in_path vim; then
	export VISUAL=vim
else
	export VISUAL=vi
fi

#
# Aliases
#

alias ls='ls --color=auto'

if in_path xdg-open; then
	function open() {
		for i in "$@"; do
			xdg-open "$i"
		done
	}
fi

#
# SSH agent
#

if [ -e "$XDG_RUNTIME_DIR/ssh-agent.sock" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
fi

#
# Cleanup
#

unset -f in_path

# vim:syntax=sh

