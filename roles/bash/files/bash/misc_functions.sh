#!/usr/bin/env bash

function junk {
  for item in $@; do
    _task "Moving '$item' to the trash"
    mv "$item" "$HOME/.Trash/"
    _task_done
  done;
}
