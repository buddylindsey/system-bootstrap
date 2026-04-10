#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if prepare_install "$MODE_PRESENT" "nvim" "Neovim"; then
    sudo apt-get install -y software-properties-common git
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get install -y neovim
fi

if [ ! -d "$HOME/.config/nvim/.git" ]; then
    rm -rf "$HOME/.config/nvim"
    git clone git@github.com:buddylindsey/vim.git "$HOME/.config/nvim"
else
    log_step "Neovim config already present; skipping clone"
fi
