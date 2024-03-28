if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

if [ -n "$ZSH_VERSION" -a -n "$PS1" ]; then
    # include .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
      . "$HOME/.zshrc"
    fi
fi
