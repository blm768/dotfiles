export XDG_DATA_HOME=~/.local/share

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

#
# Keyboard and editing options
#

unsetopt beep
# Vim keys
bindkey -v
# Let backspace work "normally" in insert mode.
bindkey -v '^?' backward-delete-char
# Faster mode switching
export KEYTIMEOUT=1

autoload -Uz compinit
compinit

#
# History options
#

HISTFILE=$XDG_DATA_HOME/zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_DUPS

if which fzf > /dev/null 2>&1; then
    function fh() {
        print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac -n 2.. | sed -E 's/^ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g' )
    }
fi

# Used on Arch Linux with the zsh-syntax-highlighting package
function {
    local syntax_plugin=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [ -f "$syntax_plugin" ]; then
        source "$syntax_plugin"
    fi
}

#
# Get config options common to all (sh-like) shells
#

source ~/.config/profile
