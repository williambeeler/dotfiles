#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

source_dir="$repo_root/home"

links=(
  ".gitconfig"
  ".global-gitignore"
)

for item in "${links[@]}"; do
  ln -sfn "$source_dir/$item" "$HOME/$item"
  echo "Linked $HOME/$item -> $source_dir/$item"
done
