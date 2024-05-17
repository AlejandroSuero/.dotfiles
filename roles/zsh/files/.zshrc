# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ ! -x "$(command -v starship)" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ -f "$XDG_CONFIG_HOME/zsh/.zsh_private" ]]; then
  source "$XDG_CONFIG_HOME/zsh/.zsh_private"
fi

# Directory for `zinit` plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download `zinit` if doesn't exist
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
[[ ! -x "$(command -v starship)" ]] && zinit light romkatv/powerlevel10k

# Load zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

zinit cdreplay -q

# Load p10k prompt if it's installed
if [[ ! -x "$(command -v starship)" ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  eval "$(starship init zsh)"
fi

# Key bindings
bindkey -v # Enable vi mode
bindkey "^y" autosuggest-accept # Accept autosuggestion
bindkey "^p" history-search-backward # Search history backward
bindkey "^n" history-search-forward # Search history forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" # Case insensitive
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
# zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"

alias zshc="$EDITOR ~/.zshrc"


[[ ! -x "$(command -v fzf)" ]] || eval "$(fzf --zsh)"
[[ ! -x "$(command -v zoxide)" ]] || eval "$(zoxide init --cmd cd zsh)"
[[ ! -x "$(command -v thefuck)" ]] || eval "$(thefuck --alias)"

[[ ! -f "$PWD/.nvmrc" ]] || check_nvmrc
