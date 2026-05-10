#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "tailscale" "Tailscale"

pushd /tmp >/dev/null
curl -fsSL https://tailscale.com/install.sh | sh
popd >/dev/null
