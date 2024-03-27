#!/usr/bin/env bash

alias update="brew update"
alias upgrade="brew upgrade"

_copy() {
  cat $1 | pbcopy
}

_paste() {
  pbpaste
}

alias c="_copy"
alias v="_paste"

export $DEFAULT_BROWSER="Brave Browser.app"
