#!/bin/sh
set -eu
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
install_dir="$HOME/.local/bin"
mkdir -p "$install_dir"
install -m 755 "$script_dir/onlinefix" "$install_dir/onlinefix"
printf 'Installed %s\n' "$install_dir/onlinefix"
