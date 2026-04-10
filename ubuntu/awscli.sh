#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "aws" "AWS CLI"

if ! command_exists asdf; then
    echo "asdf-vm is not installed" >&2
    exit 1
fi

if ! asdf plugin list | grep -qx "awscli"; then
    asdf plugin add awscli
fi

asdf install awscli latest
asdf global awscli latest
