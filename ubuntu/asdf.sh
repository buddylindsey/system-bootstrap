#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='asdf-vm/asdf'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE="asdf-$APP_VERSION-linux-386.tar.gz"
DOWNLOAD_ARCHIVE="asdf-$APP_VERSION-linux-386.tar.gz"
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='asdf'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
tar -xzvf $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR 
popd


# export ASDF_DIR=$HOME/.asdf
# source "$ASDF_DIR/asdf.sh"
# ~/.asdf/bin/asdf plugin add python
# ~/.asdf/bin/asdf install python latest
# ~/.asdf/bin/asdf global python latest
# ~/.asdf/bin/asdf plugin add nodejs 
# ~/.asdf/bin/asdf install nodejs latest
# ~/.asdf/bin/asdf global nodejs latest
