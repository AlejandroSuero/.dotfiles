#!/usr/bin/env zsh

junk() {
  for item in $@; do
    _task "Moving '$item' to the trash"
    # mv "$item" "$HOME/.Trash/"
    # _task_done
    _cmd "mv $item $HOME/.Trash/"
  done;
}

validateYaml() {
    python3 -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < $1
}
