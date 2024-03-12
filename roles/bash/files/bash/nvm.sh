#!/usr/bin/env bash

cd() {
  builtin cd "$@"
  if [[ -f "$PWD"/.nvmrc ]]; then
    nvm use > /dev/null
  fi
}
