#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "wget"
if [ $? -eq 1 ]; then
    sudo apt install -y wget
fi

check_command_installed "dbgate"
if [ $? -eq 0 ]; then
    exit 0
fi

pushd /tmp

wget https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
sudo dpkg -i dbgate-latest.deb

popd
