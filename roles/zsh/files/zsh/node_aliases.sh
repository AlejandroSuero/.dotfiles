#!/usr/bin/env zsh

choose_pkg_mgr() {
  packages=("npm" "pnpm" "bun")
  choice=$(printf "%s\n" "${packages[@]}" | fzf)
  echo "$choice"
}

# p for package
alias p="$(choose_pkg_mgr)"

# p + cmd
alias pi="$(choose_pkg_mgr) install"
alias pie="$(choose_pkg_mgr) install -E"
alias pidev="$(choose_pkg_mgr) install -D -E"

alias pdev="$(choose_pkg_mgr) dev"
alias pstart="$(choose_pkg_mgr) start"
alias pbuild="$(choose_pkg_mgr) build"

alias plint="$(choose_pkg_mgr) lint"
alias pformat="$(choose_pkg_mgr) format"

# vi:ft=zsh
