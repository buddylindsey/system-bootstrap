#!/bin/bash

set -euo pipefail

MODE_PRESENT="present"
MODE_LATEST="latest"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_command_installed() {
    local command_name=$1
    if command_exists "$command_name"; then
        echo "$command_name is already installed."
        return 0
    fi

    return 1
}

log_step() {
    printf '==> %s\n' "$*"
}

prepare_install() {
    local mode=$1
    local command_name=$2
    local label=${3:-$command_name}

    case "$mode" in
        "$MODE_PRESENT")
            if command_exists "$command_name"; then
                log_step "$label already installed; skipping"
                return 1
            fi
            log_step "Installing $label"
            ;;
        "$MODE_LATEST")
            if command_exists "$command_name"; then
                log_step "Updating $label"
            else
                log_step "Installing $label"
            fi
            ;;
        *)
            echo "Unknown install mode: $mode" >&2
            exit 1
            ;;
    esac

    return 0
}

apt_package_installed() {
    dpkg -s "$1" >/dev/null 2>&1
}

ensure_apt_packages() {
    sudo apt-get install -y "$@"
}

github_latest_release_tag() {
    local repo=$1
    curl -fsSL "https://api.github.com/repos/$repo/releases/latest" | grep -Po '"tag_name": "\K[^"]*'
}

append_line_once() {
    local line=$1
    local file_path=$2

    mkdir -p "$(dirname "$file_path")"
    touch "$file_path"

    if ! grep -Fqx -- "$line" "$file_path"; then
        printf '%s\n' "$line" >> "$file_path"
    fi
}
