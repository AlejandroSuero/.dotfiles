#!/usr/bin/env bash

function junk {
  _task "Moving items to the trash"
  for item in $@; do
    _cmd "mv $item $HOME/.Trash/"
  done
}
