# enable colors
autoload -U colors && colors

NEWLINE=$'\n'
PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$reset_color%}${NEWLINE}$%b "

local return_code="%(?..%F{red}%? ↵%f)"
RPROMPT="${return_code}"
# cd when only a path is given
setopt autocd

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

# correction
setopt correct
setopt correct_all

# completion
autoload -U compinit 
zstyle ':completion:*' menu select
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v

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

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# load functions
source ~/.config/zsh/functions/*.zsh

# load aliases
source ~/.config/zsh/aliases/*.zsh

# load zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

