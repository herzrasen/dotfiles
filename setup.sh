#!/bin/bash

link_file() {
    DIR=$(dirname $2)
    if [ ! -d $DIR ]; then
        echo "Creating directory $DIR"
        mkdir -p "$DIR"
    fi
    if [ -f "$2" ] || [ -d "$1" ]; then
        LINK_TARGET=$(readlink $2)
        if [ $? -eq "0" ]; then
            if [ "$LINK_TARGET" == "$1" ]; then
                echo "$2 is aleady a link pointing to $1"
                return
            fi
        fi
        BACKUP="$2.$(date +%s)"
        echo "$2 already exists. Saving it to $BACKUP"
        mv "$2" $BACKUP
    fi
    ln -s "$1" "$2"
    echo "Created link for $2"
}

link_file $HOME/.dotfiles/.zshrc $HOME/.zshrc
link_file $HOME/.dotfiles/.config/zsh $HOME/.config/zsh
link_file $HOME/.dotfiles/.config/nvim $HOME/.config/nvim