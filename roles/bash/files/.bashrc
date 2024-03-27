# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME=""
eval "$(starship init bash)"

DISABLE_UPDATE_PROMPT=true

COMPLETION_WAITING_DOTS="true"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

completions=(
  docker
  git
  gh
  go
  ssh
  system
  tmux
  vault
)

aliases=(
  chmod
  general
  misc
)

plugins=(
  ansible
  bashmarks
  git
  goenv
  golang
  progress
  xterm
  zoxide
)

source "$OSH"/oh-my-bash.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="nvim"
else
  export EDITOR="nvim"
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Example aliases
alias bashc="$EDITOR ~/.bashrc"
alias ohmybash="$EDITOR ~/.oh-my-bash"

if [[ -f "$HOME/.config/bash/.bash_private" ]]; then
    source "$HOME/.config/bash/.bash_private"
fi

for file in $HOME/.config/bash/*.sh; do
  source "$file"
done

[ -f ~/.fzf.bash ]   && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DEFAULT_BROWSER=$(_get_default_browser)

if [[ "$(uname)" == "Darwin" ]]; then
  # gnu-tar as tar
  addToPathFront "/opt/homebrew/opt/gnu-tar/libexec/gnubin"
fi
