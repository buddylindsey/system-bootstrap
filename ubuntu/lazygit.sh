#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "lazygit" "lazygit"

pushd /tmp >/dev/null
LAZYGIT_VERSION=$(github_latest_release_tag "jesseduffield/lazygit")
LAZYGIT_VERSION=${LAZYGIT_VERSION#v}
curl -fsSLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
popd >/dev/null
