#!/usr/bin/env bash

alias update='sudo pacman -Syu --noconfirm'

_copy() {
  cat $1 | xclip -selection clipboard
}

_paste() {
  xclip -selection clipboard -o
}

alias c="_copy"
alias v="_paste"

change_background() {
    nitrogen --set-auto "$HOME/wallpapers/$(ls "$HOME/wallpapers" | fzf)" --save
}
