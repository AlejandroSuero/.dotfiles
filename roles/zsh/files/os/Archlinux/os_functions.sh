#!/usr/bin/env bash

alias update='sudo pacman -Syu --noconfirm'

_copy() {
  cat $1 | xclip -selection clipboard
}

_paste() {
  xclip -selection clipboard -o
}

_get_default_browser() {
  default_browser=$(xdg-settings get default-web-browser | tr ".desktop" " ")
  echo default_browser
}

_open_default_browser() {
  "$(_get_default_browser)" 2> /dev/null
}

alias c="_copy"
alias v="_paste"

change_background() {
    nitrogen --set-auto "$HOME/wallpapers/$(ls "$HOME/wallpapers" | fzf)" --save
}
