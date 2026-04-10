#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if [ -d "$HOME/.oh-my-zsh" ]; then
    log_step "Oh My Zsh already installed; skipping"
    exit 0
fi

log_step "Installing Oh My Zsh"
pushd /tmp >/dev/null
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
popd >/dev/null
