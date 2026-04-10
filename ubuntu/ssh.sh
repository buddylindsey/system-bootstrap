#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! apt_package_installed "openssh-server"; then
    log_step "Installing openssh-server"
    sudo apt-get install -y openssh-server
    sudo systemctl status sshd.service
else
    log_step "openssh-server already installed"
fi

if ! apt_package_installed "openssh-client"; then
    log_step "Installing openssh-client"
    sudo apt-get install -y openssh-client
else
    log_step "openssh-client already installed"
fi

mkdir -p "$HOME/.ssh"
if [ ! -f "$HOME/.ssh/config" ]; then
    log_step "Creating SSH config"
    {
        echo "Host home"
        echo "    HostName 192.168.1.1"
        echo "    User buddy"
    } > "$HOME/.ssh/config"
fi
