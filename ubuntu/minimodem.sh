#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "minimodem"
if [ $? -eq 0 ]; then
    exit 0
fi

sudo apt install -y minimodem
