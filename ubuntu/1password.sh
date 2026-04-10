#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

log_step "Installing latest 1Password"

pushd /tmp >/dev/null

ensure_apt_packages gnupg2 wget
wget -O 1password-latest.deb https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
sudo dpkg -i 1password-latest.deb

popd >/dev/null
