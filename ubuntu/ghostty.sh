#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

ensure_ppa ppa:mkasberg/ghostty-ubuntu

if ! prepare_install "$MODE_PRESENT" "ghostty" "Ghostty"; then
    exit 0
fi

sudo apt install -y ghostty
