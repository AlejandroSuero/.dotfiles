export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-bash installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true

COMPLETION_WAITING_DOTS="true"

# don't put duplicate lines in the history. See zsh(1) for more options
export HISTCONTROL=ignoredups

plugins=(
  gh
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH"/oh-my-zsh.sh

for file in $HOME/.config/zsh/*.sh; do
  source "$file"
done

# Preferred editor for local and remote sessions

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Example aliases
alias zshc="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

if [[ -f "$HOME/.config/zsh/.zsh_private" ]]; then
    source "$HOME/.config/zsh/.zsh_private"
fi

eval "$(starship init zsh)"
eval "$(fzf --zsh)"

eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

eval "$(zoxide init zsh)"

check_nvmrc
