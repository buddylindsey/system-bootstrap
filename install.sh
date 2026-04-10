#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/utils.sh"

os="ubuntu"
env="cli"
validate_only="no"
list_only="no"
help_only="no"
requested_targets=()

UBUNTU_CLI_SCRIPTS=(
    tailscale.sh
    nfs.sh
    ssh.sh
    ohmyzsh.sh
    zellij.sh
    asdf.sh
    rust.sh
    ripgrep.sh
    starship.sh
    bat.sh
    eza.sh
    fastfetch.sh
    lazygit.sh
    yazi.sh
    nvim.sh
    onefetch.sh
    yt_dlp.sh
    docker.sh
    awscli.sh
    kubectl.sh
    kind.sh
    imagemagick.sh
)

UBUNTU_GUI_SCRIPTS=(
    1password.sh
    alacritty.sh
    meslo.sh
    brave.sh
    freecad.sh
    mpv.sh
    kdenlive.sh
    obs.sh
    steam.sh
    gimp.sh
    dbgate.sh
    minimodem.sh
    telegram.sh
)

UBUNTU_OPTIONAL_SCRIPTS=(
    ghostty.sh
    ollama.sh
    direwolf.sh
    balenaetcher.sh
)

run_script_list() {
    local os_name=$1
    shift

    local script_name
    for script_name in "$@"; do
        "$SCRIPT_DIR/$os_name/$script_name"
    done
}

script_exists() {
    local os_name=$1
    local target_name=$2
    [ -x "$SCRIPT_DIR/$os_name/$target_name.sh" ] || [ -f "$SCRIPT_DIR/$os_name/$target_name.sh" ]
}

normalize_target_name() {
    local target_name=$1
    if [[ $target_name == *.sh ]]; then
        printf '%s\n' "$target_name"
    else
        printf '%s.sh\n' "$target_name"
    fi
}

run_requested_targets() {
    local os_name=$1
    shift

    local raw_target
    local script_name
    for raw_target in "$@"; do
        script_name=$(normalize_target_name "$raw_target")
        if ! script_exists "$os_name" "${script_name%.sh}"; then
            echo "Unknown $os_name target: $raw_target" >&2
            exit 1
        fi

        log_step "Running $os_name target: ${script_name%.sh}"
        "$SCRIPT_DIR/$os_name/$script_name"
    done
}

print_manifest() {
    log_step "Ubuntu CLI scripts: ${UBUNTU_CLI_SCRIPTS[*]}"
    log_step "Ubuntu GUI scripts: ${UBUNTU_GUI_SCRIPTS[*]}"
    log_step "Ubuntu optional/manual scripts: ${UBUNTU_OPTIONAL_SCRIPTS[*]}"
}

print_available_targets() {
    log_step "Available ubuntu targets"
    printf '%s\n' \
        "${UBUNTU_CLI_SCRIPTS[@]}" \
        "${UBUNTU_GUI_SCRIPTS[@]}" \
        "${UBUNTU_OPTIONAL_SCRIPTS[@]}" | sed 's/\.sh$//' | sort -u
}

print_help() {
    cat <<'EOF'
Usage:
  ./install.sh [--os ubuntu] [--env cli|gui]
  ./install.sh [--os ubuntu] [target ...]
  ./install.sh --list
  ./install.sh --validate

Examples:
  ./install.sh --env cli
  ./install.sh docker awscli
  ./install.sh telegram
  ./install.sh --list
EOF
}

ARGS=$(getopt -o "h" --long os:,env:,validate,list,help -- "$@")
if [ $? -ne 0 ]; then
    echo "Error parsing options"
    exit 1
fi

eval set -- "$ARGS"

while true; do
    case "$1" in
        --os)
            case "$2" in
                ubuntu|arch|mac)
                    os="$2"
                    ;;
                *)
                    echo "Invalid value for --os. Must be one of: ubuntu, arch, mac"
                    exit 1
                    ;;
            esac
            shift 2
            ;;
        --env)
            case "$2" in
                cli|gui)
                    env="$2"
                    ;;
                *)
                    echo "Invalid value for --env. Must be one of: cli, gui"
                    exit 1
                    ;;
            esac
            shift 2
            ;;
        --validate)
            validate_only="yes"
            shift
            ;;
        --list)
            list_only="yes"
            shift
            ;;
        -h|--help)
            help_only="yes"
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "Operating system: $os"
    log_step "Environment: $env"
    print_manifest
fi

if [[ $help_only == "yes" ]]; then
    print_help
    exit 0
fi

if [[ $validate_only == "yes" ]]; then
    "$SCRIPT_DIR/validate.sh"
    exit 0
fi

requested_targets=("$@")

if [[ $list_only == "yes" ]]; then
    if [[ $os != "ubuntu" ]]; then
        echo "$os is not currently supported"
        exit 0
    fi

    print_available_targets
    exit 0
fi

if [[ $os == "mac" ]] || [[ $os == "arch" ]]; then
    echo "$os is not currently supported"
    exit 0
fi

if [[ $os == "ubuntu" ]]; then
    log_step "Installing for ubuntu"
    sudo apt-get update

    if [[ ${#requested_targets[@]} -gt 0 ]]; then
        run_requested_targets "$os" "${requested_targets[@]}"
        exit 0
    fi

    if [[ $env == "cli" ]]; then
        log_step "Running Ubuntu CLI manifest"
        run_script_list "$os" "${UBUNTU_CLI_SCRIPTS[@]}"
    fi

    if [[ $env == "gui" ]]; then
        log_step "Running Ubuntu GUI manifest"
        run_script_list "$os" "${UBUNTU_GUI_SCRIPTS[@]}"
    fi
fi
