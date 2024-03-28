#!/usr/bin/env zsh

# Generate a timestamped log file name
#   Usage: LOG=$(generate_log)
#   Returns: the log file name as a string
generate_log() {
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
    echo "/tmp/bash._task.$TIMESTAMP-$RANDOM_STRING.log"
}

# _header colorize the given argument with spacing
_task() {
  # if _task is called while a task was set, complete the previous
  if [[ $TASK != "" ]]; then
    printf "${OVERWRITE}${LGREEN} [OK]  ${LGREEN}${TASK}\n"
  fi
  # set new task title and print
  TASK=$1
  printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

# _cmd performs commands with error checking
_cmd() {
  LOG=$(generate_log)
  #create log if it doesn't exist
  if ! [[ -f $LOG ]]; then
    touch $LOG
  fi
  # empty conduro.log
  > $LOG
  # hide stdout, on error we print and exit
  if eval "$1" 1> /dev/null 2> $LOG; then
    return 0 # success
  fi
  # read error from log and add spacing
  printf "${OVERWRITE}${LRED} [X]  ${TASK}${LRED}\n"
  while read line; do
    printf "      ${line}\n"
  done < $LOG
  printf "\n"
  # remove log file
  rm $LOG
  # exit installation
  exit 1
}

_clear_task() {
  TASK=""
}

_task_done() {
  printf "${OVERWRITE}${LGREEN} [OK]  ${LGREEN}${TASK}\n"
  _clear_task
}
