#!/usr/bin/env bash

source ./tasks.sh

function junk {
  _task "Moving items to the trash"
  for item in $@; do
    _cmd "mv $item $HOME/.Trash/"
  done
}
