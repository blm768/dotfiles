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
export PATH="$PATH:$HOME/.local/bin:$GEM_HOME/ruby/2.3.0/bin"

#
# Aliases
#

if in_path nvim; then
	export VISUAL=nvim
elif in_path vim; then
	export VISUAL=vim
else
	export VISUAL=vi
fi

if in_path xdg-open; then
	alias open=xdg-open
fi

if in_path rbenv; then
	eval "$(rbenv init -)"
fi

#
# Cleanup
#

unset -f in_path

# vim:syntax=sh

