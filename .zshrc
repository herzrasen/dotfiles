# enable colors
autoload -U colors && colors

EDITOR=vim
# prompt
NEWLINE=$'\n'
PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$reset_color%}${NEWLINE}$%b "

# show git info on the right side
local return_code="%(?..%F{red}%? ↵%f)"
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=${return_code}
# cd when only a path is given
setopt autocd autopushd pushdignoredups

# case insensitive globbing
setopt no_case_glob

# histor settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# share history across multiple sessions
setopt share_history
# persist commands to history after every command
setopt inc_append_history
# remove blank lines from history
setopt hist_reduce_blanks

# completion
autoload -U compinit 
zstyle ':completion:*' menu select
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zmodload zsh/complist
compinit
_comp_options+=(globdots)
setopt complete_aliases

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# fix the cursor style 
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line

# load env 
source ~/.config/zsh/env/*.zsh

# load functions
source ~/.config/zsh/functions/*.zsh

# load aliases
source ~/.config/zsh/aliases/*.zsh

# load zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/fzf/shell/key-bindings.zsh
source .fzf/shell/key-bindings.zsh
