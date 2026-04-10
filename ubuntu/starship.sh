#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "starship" "starship"

pushd /tmp >/dev/null
curl -fsSL https://starship.rs/install.sh | sh -s -- -y
popd >/dev/null

append_line_once 'eval "$(starship init zsh)"' "$HOME/.zshrc"
