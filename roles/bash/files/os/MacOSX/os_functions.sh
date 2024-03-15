#!/usr/bin/env bash

alias update="brew update"
alias upgrade="brew upgrade"

_copy() {
  cat $1 | pbcopy
}

_paste() {
  pbpaste
}

_get_default_browser() {
  x=~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist
  plutil -convert xml1 $x
  grep 'https' -b3 $x | awk 'NR==2 {split($2, arr, "[><]"); print arr[3]}'
  echo "$(plutil -convert binary1 $x)"
}

alias c="_copy"
alias v="_paste"
