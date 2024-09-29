#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "asdf"
if [ $? -eq 0 ]; then
    exit 0
fi

sudo apt install -y curl git build-essential libssl-dev libffi-dev liblzma-dev
ASDF_VERSION=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$ASDF_VERSION

export ASDF_DIR=$HOME/.asdf
source "$ASDF_DIR/asdf.sh"
~/.asdf/bin/asdf plugin add python
~/.asdf/bin/asdf install python latest
~/.asdf/bin/asdf global python latest
~/.asdf/bin/asdf plugin add nodejs 
~/.asdf/bin/asdf install nodejs latest
~/.asdf/bin/asdf global nodejs latest
