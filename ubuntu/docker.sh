#!/bin/bash

# Check if `ca-certificates` and `curl` are installed
if dpkg -l | grep -q "ca-certificates"; then
    echo "ca-certificates is already installed."
else
    echo "Installing ca-certificates..."
    sudo apt-get install -y ca-certificates
fi

if dpkg -l | grep -q "curl"; then
    echo "curl is already installed."
else
    echo "Installing curl..."
    sudo apt-get install -y curl
fi

# Check if the Docker GPG key is already installed
if [ -f /etc/apt/keyrings/docker.asc ]; then
    echo "Docker GPG key already exists."
else
    echo "Installing Docker GPG key..."
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
fi

# Check if the Docker repository is already added to the sources list
if grep -q "^deb .*download.docker.com" /etc/apt/sources.list.d/docker.list; then
    echo "Docker repository is already present."
else
    echo "Adding Docker repository..."
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt-get update

# Install Docker if it is not already installed
if ! docker --version &> /dev/null; then
    echo "Installing Docker..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "Docker is already installed."
fi

if groups $USER | grep -q "\bdocker\b"; then
    echo "User $USER is already in the docker group."
else
    echo "Adding user $USER to the docker group..."
    sudo usermod -aG docker $USER
    echo "You need to log out and log back in to apply the group changes."
fi
