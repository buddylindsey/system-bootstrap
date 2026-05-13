#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

ensure_apt_packages git
ensure_ppa ppa:neovim-ppa/unstable

candidate_version=$(apt-cache policy neovim | awk '/Candidate:/ { print $2 }')
if [ -z "$candidate_version" ] || [ "$candidate_version" = "(none)" ]; then
    echo "No Neovim package candidate found after enabling ppa:neovim-ppa/unstable" >&2
    exit 1
fi

if ! dpkg --compare-versions "$candidate_version" ge "0.11"; then
    echo "Neovim candidate is $candidate_version, expected 0.11 or newer from ppa:neovim-ppa/unstable" >&2
    exit 1
fi

if command_exists nvim; then
    installed_version=$(nvim --version | awk 'NR == 1 { sub(/^v/, "", $2); print $2 }')
    if dpkg --compare-versions "$installed_version" ge "0.11"; then
        log_step "Neovim $installed_version already installed"
    else
        log_step "Upgrading Neovim from $installed_version to $candidate_version"
        sudo apt-get install -y neovim
    fi
else
    log_step "Installing Neovim $candidate_version"
    sudo apt-get install -y neovim
fi

if [ ! -e "$HOME/.config/nvim" ]; then
    git clone git@github.com:buddylindsey/vim.git "$HOME/.config/nvim"
elif [ -d "$HOME/.config/nvim/.git" ]; then
    log_step "Neovim config already present; skipping clone"
else
    log_step "Neovim config exists and is not a git clone; leaving it untouched"
fi
