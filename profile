#
# ~/.config/profile.global
# Common login options for all my sh-like shells
#

#
# Paths
#

function in_path() {
    which "$1" > /dev/null 2>&1
}

if [ -d ~/.local/bin ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

if [ -z "$XDG_DATA_HOME" ]; then
    export XDG_DATA_HOME=~/.local/share
fi

# Add Ruby gem executables to PATH
if [ -d ~/.gem ]; then
    export GEM_HOME="$HOME/.gem"
    export PATH="$PATH:$GEM_HOME/ruby/2.3.0/bin:$GEM_HOME/bin"
fi

# Add Cargo-installed executables to PATH
if [ -d ~/.cargo ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

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
export EDITOR="$VISUAL"
export FCEDIT="$EDITOR"

#
# GPG agent
#

if in_path gpg && in_path tty; then
    export GPG_TTY="$(tty)"
fi

#
# SSH agent
#

if [ -e "$XDG_RUNTIME_DIR/ssh-agent.sock" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
fi

#
# FZF configuration
#

if in_path fzf && in_path rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    export FZF_CTRL_T_COMMAND='rg --files --hidden'
fi

#
# Cleanup
#

unset -f in_path

# vim:syntax=sh:sw=4:ts=4:et
