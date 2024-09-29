#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "1password"
if [ $? -eq 0 ]; then
    exit 0
fi

pushd /tmp

sudo apt install -y gnupg2 wget
wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
sudo dpkg -i 1password-latest.deb

popd
