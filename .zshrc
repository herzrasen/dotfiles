# enable colors
autoload -U colors && colors

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
zstyle ':completion:*' special-dirs true

zmodload zsh/complist
compinit
_comp_options+=(globdots)
setopt complete_aliases

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -M viins '^[[Z' reverse-menu-complete
bindkey -M vicmd '^[[Z' reverse-menu-complete

# vi mode
bindkey -v

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
# Defined shortcut keys: [Esc] [Esc]
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line

# indicate vi mode with cursor shape
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] || 
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
# initialize the vi mode correctly
zle-line-init() {
  zle -K viins
  echo -ne '\e[5 q'
}
zle -N zle-line-init

preexec() {
  echo -ne '\e[5 q'
}

# load env 
source ~/.config/zsh/env/*.zsh

# load functions
source ~/.config/zsh/functions/*.zsh

# load aliases
source ~/.config/zsh/aliases/*.zsh

# load zsh-syntax-highlighting
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

 [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh 

