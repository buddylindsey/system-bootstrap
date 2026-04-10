#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "kind" "kind"

case "$(uname -m)" in
    x86_64)
        kind_arch="amd64"
        ;;
    aarch64|arm64)
        kind_arch="arm64"
        ;;
    *)
        echo "Unsupported architecture for kind: $(uname -m)" >&2
        exit 1
        ;;
esac

pushd /tmp >/dev/null

kind_version=$(github_latest_release_tag "kubernetes-sigs/kind")
tmp_dir=$(mktemp -d /tmp/kind.XXXXXX)
trap 'rm -rf "$tmp_dir"' EXIT

curl -fsSLo "$tmp_dir/kind" "https://kind.sigs.k8s.io/dl/${kind_version}/kind-linux-${kind_arch}"
chmod +x "$tmp_dir/kind"
sudo install "$tmp_dir/kind" /usr/local/bin

popd >/dev/null
