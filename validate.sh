#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/utils.sh"

log_step "Running bash syntax validation"

while IFS= read -r script_path; do
    bash -n "$script_path"
    log_step "Syntax OK: ${script_path#$SCRIPT_DIR/}"
done < <(find "$SCRIPT_DIR" -maxdepth 2 -name "*.sh" | sort)

if command_exists shellcheck; then
    log_step "Running shellcheck"
    shellcheck "$SCRIPT_DIR"/install.sh "$SCRIPT_DIR"/utils.sh "$SCRIPT_DIR"/validate.sh "$SCRIPT_DIR"/ubuntu/*.sh
else
    log_step "shellcheck not installed; skipped"
fi
