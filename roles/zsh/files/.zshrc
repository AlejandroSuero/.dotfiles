# Directory for `zinit` plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download `zinit` if doesn't exist
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"

printf "\n%s\n" "Loading zinit starship plugin ..."
zinit ice as "command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
printf "\n%s\n" "Loading zinit starship ..."
zinit light starship/starship

if [ "$(command -v starship)" ]; then
  printf "\n%s\n" "Loading starship ..."
  eval "$(starship init zsh)"
fi
