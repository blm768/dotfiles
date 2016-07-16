#
# ~/.bashrc
#

function in_path() {
	which "$1" > /dev/null
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export GEM_HOME="/home/blm/.gem"
export PATH="$PATH:/home/blm/.local/bin:$GEM_HOME/ruby/2.3.0/bin"

if in_path nvim; then
	export VISUAL=nvim
elif in_path vim; then
	export VISUAL=vim
else
	export VISUAL=vi
fi

