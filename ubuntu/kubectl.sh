#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

APP_DIR='/usr/local/bin'

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl $APP_DIR

popd
