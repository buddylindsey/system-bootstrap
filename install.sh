#!/bin/bash

# Set default values
os="ubuntu"
env="cli"

# Parse options using `getopt`
ARGS=$(getopt -o "" --long os:,env: -- "$@")
if [ $? -ne 0 ]; then
    echo "Error parsing options"
    exit 1
fi

# Reorder the positional parameters based on the getopt results
eval set -- "$ARGS"

# Process options
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
                    ;; esac
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

if [[ $VERBOSE = 'yes' ]]; then
    # Output the values for testing purposes
    echo "Operating system: $os"
    echo "Environment: $env"
fi

if [[ $os == 'mac' ]] || [[ $os == 'arch' ]]; then
    echo "$os is not currently supported"
    exit 0
fi

# You can add your main logic here using $os and $env

if [[ $os == 'ubuntu' ]]; then
    echo "Installing for ubuntu"
    sudo apt-get update
    if [[ $env == 'cli' ]]; then
        echo "... CLI Tools"
        # System
        ./$os/tailscale.sh
        ./$os/nfs.sh
        ./$os/ssh.sh

        # CLI
        ./$os/ohmyzsh.sh
        ./$os/zellij.sh
        ./$os/asdf.sh
        ./$os/rust.sh
        ./$os/ripgrep.sh
        ./$os/starship.sh
        ./$os/bat.sh
        ./$os/eza.sh
        ./$os/fastfetch.sh
        ./$os/lazygit.sh
        ./$os/yazi.sh
        ./$os/nvim.sh
        ./$os/onefetch.sh
        ./$os/yt_dlp.sh
        ./$os/docker.sh
        ./$os/awscli.sh
        ./$os/kubectl.sh
    fi
    if [[ $env == 'gui' ]]; then
        # GUI
        echo "... GUI Tools"
        ./$os/1password.sh
        ./$os/alacritty.sh
        ./$os/meslo.sh
        ./$os/brave.sh
        ./$os/freecad.sh
        ./$os/mvp.sh
        ./$os/kdenlive.sh
        ./$os/obs.sh
        ./$os/steam.sh
        ./$os/gimp.sh
        ./$os/dbgate.sh
    fi
fi
