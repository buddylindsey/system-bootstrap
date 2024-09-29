#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

pushd /tmp
check_command_installed "starship"
if [ $? -eq 0 ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi
popd
