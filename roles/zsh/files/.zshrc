export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-bash installation.
export ZSH="$HOME/.oh-my-bash"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME=""
eval "$(starship init zsh)"

DISABLE_UPDATE_PROMPT=true

COMPLETION_WAITING_DOTS="true"

# don't put duplicate lines in the history. See zsh(1) for more options
export HISTCONTROL=ignoredups

plugins=(
  ansible
  docker
  gh
  git
  golang
  tmux
  vault
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH"/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="nvim"
else
  export EDITOR="nvim"
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Example aliases
alias zshc="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

if [[ -f "$HOME/.config/zsh/.zsh_private" ]]; then
    source "$HOME/.config/zsh/.zsh_private"
fi

for file in $HOME/.config/zsh/*.sh; do
  source "$file"
done

[ -f ~/.fzf.zsh ]   && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DEFAULT_BROWSER=$(_get_default_browser)

if [[ "$(uname)" == "Darwin" ]]; then
  # gnu-tar as tar
  addToPathFront "/opt/homebrew/opt/gnu-tar/libexec/gnubin"
fi
