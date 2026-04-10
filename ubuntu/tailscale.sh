#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! prepare_install "$MODE_PRESENT" "tailscale" "Tailscale"; then
    exit 0
fi

pushd /tmp >/dev/null
curl -fsSL https://tailscale.com/install.sh | sh
popd >/dev/null
