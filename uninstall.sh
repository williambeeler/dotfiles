#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brewfile="$repo_root/config/Brewfile"

remove_brew_bundle() {
  local brewfile_path="$1"

  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed. Skipping Homebrew uninstall."
    return
  fi

  if [[ ! -f "$brewfile_path" ]]; then
    echo "No Brewfile found at $brewfile_path. Skipping Homebrew uninstall."
    return
  fi

  echo "Removing Homebrew items from $brewfile_path..."

  while IFS= read -r line; do
    case "$line" in
      brew\ \"*\"*)
        local formula
        formula="${line#brew \"}"
        formula="${formula%%\"*}"
        brew uninstall "$formula" 2>/dev/null || true
        ;;
      cask\ \"*\"*)
        local cask
        cask="${line#cask \"}"
        cask="${cask%%\"*}"
        brew uninstall --cask "$cask" 2>/dev/null || true
        ;;
      vscode\ \"*\"*)
        local extension
        extension="${line#vscode \"}"
        extension="${extension%%\"*}"
        if command -v code >/dev/null 2>&1; then
          code --uninstall-extension "$extension" >/dev/null 2>&1 || true
        fi
        ;;
    esac
  done < "$brewfile_path"

  while IFS= read -r line; do
    case "$line" in
      tap\ \"*\"*)
        local tap_name
        tap_name="${line#tap \"}"
        tap_name="${tap_name%%\"*}"
        brew untap "$tap_name" 2>/dev/null || true
        ;;
    esac
  done < "$brewfile_path"

  echo "Homebrew uninstall pass complete."
}

remove_symlink() {
  local target="$1"
  local expected_source="$2"

  if [[ -L "$target" ]]; then
    local actual_source
    actual_source="$(readlink "$target")"

    if [[ "$actual_source" == "$expected_source" ]]; then
      rm "$target"
      echo "Removed $target"
      return
    fi
  fi

  echo "Skipped $target"
}

remove_brew_bundle "$brewfile"

echo

remove_symlink "$HOME/.codex/AGENTS.md" "$repo_root/config/codex/AGENTS.md"
remove_symlink "$HOME/.codex/config.toml" "$repo_root/config/codex/config.toml"
remove_symlink "$HOME/.codex/laravel-php-guidelines.md" "$repo_root/config/codex/laravel-php-guidelines.md"
remove_symlink "$HOME/.codex/skills" "$repo_root/config/codex/skills"
remove_symlink "$HOME/.gitconfig" "$repo_root/home/.gitconfig"
remove_symlink "$HOME/.global-gitignore" "$repo_root/home/.global-gitignore"

echo
echo "Symlink cleanup complete."
echo "Terminal.app preferences were not changed by uninstall."
