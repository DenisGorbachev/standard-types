#!/usr/bin/env bash

set -xeuo pipefail

dir="$(dirname "$(realpath "$0")")"
name_new="$(basename "$dir")"
cargo_toml="$dir/Cargo.toml"
#mise_toml="$dir/mise.toml"

echo "This script assumes that your package name is equal to the directory name: $name_new"
read -r -p "Is this correct? [Y/n] " answer
if [[ ! "$answer" = "Y" ]]; then
  echo "Aborting"
  exit 1
fi

#(cd "$dir" && mise trust)
#(cd "$dir" && mise install)
#
name_old=$(taplo get -f "$cargo_toml" "package.name")
name_old_snake_case=$(ccase --to snake "$name_old")
name_new_snake_case=$(ccase --to snake "$name_new")
repo_url=$(cd "$dir" && gh repo view --json url | jq -r .url)
#
#tomli set -f "$cargo_toml" "package.name" "$name_new" | sponge "$cargo_toml"
#tomli delete -f "$cargo_toml" "package.description" | sponge "$cargo_toml"
#tomli delete -f "$cargo_toml" "package.metadata.details.title" | sponge "$cargo_toml"
#tomli delete -f "$cargo_toml" "package.metadata.details.readme.generate" | sponge "$cargo_toml"
#tomli set -f "$cargo_toml" "package.repository" "$repo_url" | sponge "$cargo_toml"
#tomli set -f "$cargo_toml" "package.homepage" "$repo_url" | sponge "$cargo_toml"
#
#rm "$dir/README.md"

rg --files-with-matches "$name_old_snake_case" "$dir" # | xargs gsed -i "s/\b$name_old_snake_case\b/$name_new_snake_case/g" || true

#(cd "$dir" && mise run build)
#
#(cd "$dir" && mise run test)
#
#(cd "$dir" && git add . && git commit -a -m "chore: update package details")
#
#rm "$dir/setup.sh"
