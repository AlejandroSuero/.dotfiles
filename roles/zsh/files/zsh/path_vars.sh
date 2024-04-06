#!/usr/bin/env zsh

addToPath /usr/local/go/bin
addToPath $GOPATH/bin
addToPath $HOME/go/bin
addToPath $HOME/.dotfiles/bin
addToPath $HOME/.cargo/bin
addToPath $HOME/.luarocks/bin
addToPathFront $HOME/.local/bin
# ccache
addToPathFront /usr/lib/ccache
