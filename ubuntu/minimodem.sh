#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! prepare_install "$MODE_PRESENT" "minimodem" "minimodem"; then
    exit 0
fi

sudo apt-get install -y minimodem
