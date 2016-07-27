#
# ~/.profile
# Common options for all my sh-like shells
#

function in_path() {
	which "$1" > /dev/null
}

export GEM_HOME="$HOME/.gem"
export PATH="$PATH:$HOME/.local/bin:$GEM_HOME/ruby/2.3.0/bin"

if in_path nvim; then
	export VISUAL=nvim
elif in_path vim; then
	export VISUAL=vim
else
	export VISUAL=vi
fi

unset -f in_path

# vim:syntax=sh

