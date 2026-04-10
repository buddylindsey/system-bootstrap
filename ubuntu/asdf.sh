#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "asdf" "asdf"

case "$(uname -m)" in
    x86_64)
        asdf_arch="amd64"
        ;;
    aarch64|arm64)
        asdf_arch="arm64"
        ;;
    *)
        echo "Unsupported architecture for asdf: $(uname -m)" >&2
        exit 1
        ;;
esac

pushd /tmp >/dev/null

REPO="asdf-vm/asdf"
APP_VERSION=$(github_latest_release_tag "$REPO")
ARCHIVE_FILE="asdf-$APP_VERSION-linux-$asdf_arch.tar.gz"

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo "$ARCHIVE_FILE" "https://github.com/$REPO/releases/download/$APP_VERSION/$ARCHIVE_FILE"
tar -xzf "$ARCHIVE_FILE"
sudo install asdf /usr/local/bin
popd >/dev/null

if ! asdf plugin list | grep -qx "python"; then
    asdf plugin add python
fi
asdf install python latest
asdf global python latest
if ! asdf plugin list | grep -qx "nodejs"; then
    asdf plugin add nodejs
fi
asdf install nodejs latest
asdf global nodejs latest
if ! asdf plugin list | grep -qx "golang"; then
    asdf plugin add golang
fi
asdf install golang latest
