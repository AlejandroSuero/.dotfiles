if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  PATH=/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH
fi

export GOROOT="$HOME/go"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export BAT_THEME="Catppuccin Mocha"

export EDITOR="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/fzf-git.sh/fzf-git.sh
