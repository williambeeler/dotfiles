#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

source_dir="$repo_root/config/codex"
target_dir="$HOME/.codex"

mkdir -p "$target_dir"

links=(
  "AGENTS.md"
  "config.toml"
  "laravel-php-guidelines.md"
)

for item in "${links[@]}"; do
  ln -sfn "$source_dir/$item" "$target_dir/$item"
  echo "Linked $target_dir/$item -> $source_dir/$item"
done

ln -sfn "$source_dir/skills" "$target_dir/skills"
echo "Linked $target_dir/skills -> $source_dir/skills"

echo
echo "Codex symlinks are installed."
