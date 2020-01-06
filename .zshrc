# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dennis/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gnzh"

# Update zsh each x days
export UPDATE_ZSH_DAYS=5

# Which plugins would you like to load?
plugins=(
  git
  colored-man-pages
  fzf
  sudo
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias l="lsd -l"
alias ll="lsd -al"
alias lt="lsd --tree"
alias tree="lt"

export XDG_CONFIG_HOME=$HOME/.config
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

# dotfile management
#   first init a bare git repo with:
#     git init --bare .dotfiles
#     dot config --local status.showUntrackedFiles no
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# enable zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable additional completions
autoload -U compinit && compinit

