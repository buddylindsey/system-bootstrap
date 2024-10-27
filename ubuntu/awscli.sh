#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "aws"
if [ $? -eq 0 ]; then
    exit 0
fi

check_command_installed "asdf"
if [ $? -eq 1 ]; then
    echo "asdf-vm is not installed"
    exit 1
fi

asdf plugin add awscli
asdf install awscli latest
asdf global awscli latest
