#!/usr/bin/env bash

function check_nvmrc() {
  if [[ -f "$PWD"/.nvmrc ]]; then
    nvm use > /dev/null
  fi
}

cd() {
  builtin cd "$@"
  check_nvmrc
}
