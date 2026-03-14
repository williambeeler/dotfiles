#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_terminal_plist="$repo_root/home/terminal.plist"
home_terminal_plist="$HOME/terminal.plist"
repo_brewfile="$repo_root/config/Brewfile"

defaults export com.apple.Terminal "$repo_terminal_plist"
cp "$repo_terminal_plist" "$home_terminal_plist"

brew bundle dump --describe --force --file="$repo_brewfile"

echo "Exported Terminal.app preferences to:"
echo "  $repo_terminal_plist"
echo "  $home_terminal_plist"
echo
echo "Exported Homebrew bundle to:"
echo "  $repo_brewfile"
