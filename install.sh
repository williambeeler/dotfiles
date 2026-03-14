#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
terminal_plist="$repo_root/home/terminal.plist"
brewfile="$repo_root/config/Brewfile"

if command -v brew >/dev/null 2>&1; then
  if [[ -f "$brewfile" ]]; then
    echo "Installing Homebrew packages from $brewfile..."
    brew bundle --file="$brewfile"
  else
    echo "No Brewfile found at $brewfile. Skipping Homebrew package install."
  fi
else
  echo "Homebrew is not installed. Skipping Homebrew package install."
fi

echo

echo "Installing Codex symlinks..."
"$repo_root/config/install-codex-symlinks.sh"

echo
echo "Installing home directory symlinks..."
"$repo_root/config/install-home-symlinks.sh"

if [[ -f "$terminal_plist" ]]; then
  echo
  cp "$terminal_plist" "$HOME/terminal.plist"
  echo "Importing Terminal.app preferences from $terminal_plist..."
  defaults import com.apple.Terminal "$terminal_plist"
  echo "Terminal.app preferences imported."
else
  echo
  echo "No version-controlled Terminal.app plist found. Skipping Terminal.app import."
fi

echo
echo "Base dotfiles install complete."
echo "Add more setup steps to $(basename "$0") as this repo grows."
