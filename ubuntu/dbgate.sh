#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

log_step "Installing latest DbGate"

if ! command_exists wget; then
    ensure_apt_packages wget
fi

pushd /tmp >/dev/null

wget -O dbgate-latest.deb https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
sudo dpkg -i dbgate-latest.deb

popd >/dev/null
