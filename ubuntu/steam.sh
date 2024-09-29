#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "steam"
if [ $? -eq 0 ]; then
    exit 0
fi

pushd /tmp

sudo apt install -y wget
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo dpkg -i steam.deb

popd
