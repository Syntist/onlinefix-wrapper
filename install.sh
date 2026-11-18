#!/bin/sh
set -eu

install_dir="$HOME/.local/bin"
source_file=
case "$0" in
    */install.sh|install.sh)
        script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
        if [ -f "$script_dir/onlinefix" ]; then
            source_file="$script_dir/onlinefix"
        fi
        ;;
esac

if [ -z "$source_file" ]; then
    if ! command -v curl >/dev/null 2>&1; then
        printf '%s\n' 'Error: curl is required to download onlinefix.' >&2
        exit 1
    fi
    temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT HUP INT TERM
    source_file="$temp_dir/onlinefix"
    curl -fsSL https://raw.githubusercontent.com/Syntist/onlinefix-wrapper/main/onlinefix -o "$source_file"
fi

mkdir -p "$install_dir"
install -m 755 "$source_file" "$install_dir/onlinefix"
printf 'Installed %s\n' "$install_dir/onlinefix"
