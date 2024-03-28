#!/usr/bin/env bash

alias update="sudo apt update"
alias upgrade="sudo apt upgrade"

_copy() {
  cat $1 | xclip -selection clipboard
}

_paste() {
  xclip -selection clipboard -o
}

alias c="_copy"
alias v="_paste"

change_background() {
    dconf write /org/mate/desktop/background/picture-filename "'$HOME/anime/$(ls ~/anime| fzf)'"
}
