#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "nvim"
if [ $? -eq 0 ]; then
    exit 0
fi

sudo apt-get install -y software-properties-common git
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get install -y neovim

mkdir -p ~/.config/nvim
git clone git@github.com:buddylindsey/vim.git ~/.config/nvim/
