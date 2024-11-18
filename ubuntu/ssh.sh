#!/bin/bash

if apt list --installed 2>/dev/null | grep -q "^openssh-server/"; then
    echo "Package openssh-server is installed."
else
    sudo apt install -y openssh-server
    sudo systemctl status sshd.service
fi

if apt list --installed 2>/dev/null | grep -q "^openssh-client/"; then
    echo "Package openssh-server is installed."
else
    sudo apt install -y openssh-server
    sudo systemctl status sshd.service
fi


if [ ! -f ~/.ssh/config ]; then
    echo "SSH Config is not there"
    touch ~/.ssh/config
    echo "Host home" > ~/.ssh/config
    echo "    HostName 192.168.1.1" >> ~/.ssh/config
    echo "    User buddy" >> ~/.ssh/config
fi
