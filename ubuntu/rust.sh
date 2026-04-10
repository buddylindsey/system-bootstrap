#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "rustup" "Rust"

pushd /tmp >/dev/null
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
popd >/dev/null
