#!/usr/bin/env zsh

check_nvmrc() {
  if [[ "$(command -v nvm)" == "" ]]; then
    echo -e "${WARNING} ${YELLOW}nvm not found${NC}"
  else
    if [[ -f "$PWD"/.nvmrc ]]; then
      nvm use > /dev/null
    fi
  fi
}

cd() {
  builtin cd "$@"
  check_nvmrc
}
