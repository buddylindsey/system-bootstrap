#!/bin/bash

# Function to check if a command is installed
check_command_installed() {
    local COMMAND=$1
    if command -v "$COMMAND" &> /dev/null
    then
        echo "$COMMAND is already installed."
        return 0
    else
        return 1
    fi
}
