#!/usr/bin/env bash

function junk {
  for item in $@; do
    _task "Moving '$item' to the trash"
    _cmd "mv -f '$item' '$HOME/.Trash/'"
  done
}
