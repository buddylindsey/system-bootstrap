#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "asdf" "asdf"

ensure_asdf_language_installed() {
    local plugin_name=$1

    if ! asdf plugin list | grep -qx "$plugin_name"; then
        asdf plugin add "$plugin_name"
    fi

    if asdf list "$plugin_name" >/dev/null 2>&1; then
        log_step "asdf $plugin_name already has an installed version; skipping latest install"
        return 1
    fi

    asdf install "$plugin_name" latest
    return 0
}

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

if ensure_asdf_language_installed "python"; then
    asdf global python latest
fi

if ensure_asdf_language_installed "nodejs"; then
    asdf global nodejs latest
fi

ensure_asdf_language_installed "golang" || true
