#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

ensure_apt_packages git
ensure_ppa ppa:neovim-ppa/unstable

if prepare_install "$MODE_PRESENT" "nvim" "Neovim"; then
    sudo apt-get install -y neovim
fi

if [ ! -e "$HOME/.config/nvim" ]; then
    git clone git@github.com:buddylindsey/vim.git "$HOME/.config/nvim"
elif [ -d "$HOME/.config/nvim/.git" ]; then
    log_step "Neovim config already present; skipping clone"
else
    log_step "Neovim config exists and is not a git clone; leaving it untouched"
fi
