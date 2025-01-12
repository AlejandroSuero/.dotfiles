# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  PATH=/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH
fi

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export BAT_THEME="Catppuccin Mocha"

export EDITOR="nvim"

export NVM_DIR="$HOME/.nvm"

export PATH=$HOME/bin:/usr/local/bin:$PATH
source "$XDG_CONFIG_HOME/zsh/path_functions.sh"
source "$XDG_CONFIG_HOME/zsh/path_vars.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ ! -d "$HOME/fzf-git.sh" ]] || source ~/fzf-git.sh/fzf-git.sh

# Directory for `zinit` plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Load `zsh` configuration files
for file in $XDG_CONFIG_HOME/zsh/*.sh; do
  source $file
done

# ======================================

# ======================================
# Key bindings
bindkey -v # Enable vi mode
bindkey "^y" autosuggest-accept # Accept autosuggestion
bindkey "^p" history-search-backward # Search history backward
bindkey "^n" history-search-forward # Search history forward
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^g "lazygit\n"
bindkey -s ^b "_open_default_browser\n"
bindkey -s ^e "ranger\n"
# ======================================

# ======================================
# ======================================

# ======================================
# Key bindings
bindkey -v # Enable vi mode
bindkey "^y" autosuggest-accept # Accept autosuggestion
bindkey "^p" history-search-backward # Search history backward
bindkey "^n" history-search-forward # Search history forward
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^g "lazygit\n"
bindkey -s ^b "_open_default_browser\n"
bindkey -s ^e "ranger\n"
# ======================================

# ======================================
