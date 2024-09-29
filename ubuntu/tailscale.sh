#!/bin/bash

# Source utils in parent directory
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "tailscale"
if [ $? -eq 0 ]; then
    exit 0
fi

pushd /tmp
echo "Installing Tailscale"

curl -fsSL https://tailscale.com/install.sh | sh

popd
