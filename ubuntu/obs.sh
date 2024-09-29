#!/bin/bash

# check_command_installed "steam"
# if [ $? -eq 0 ]; then
#     exit 0
# fi

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y ffmpeg obs-studio
