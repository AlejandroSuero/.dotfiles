#!/usr/bin/env zsh

function check_nvmrc() {
  if [[ -f "$PWD"/.nvmrc ]]; then
    nvm use > /dev/null
  fi
}

cd() {
  builtin cd "$@"
  check_nvmrc
}

z() {
  __zoxide_z "$@"
  check_nvmrc
}
