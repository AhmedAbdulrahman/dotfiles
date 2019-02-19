#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-02-09 12:10
################################################################################

# get the dir of the current script
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.timewarrior

_exists() {
  command -v $1 > /dev/null 2>&1
}

# Install cmake, assumes brew is installed.
if ! _exists cmake; then
    brew install cmake
    sudo chown -R $(whoami):admin /usr/local/share/man
    /usr/local/bin/brew link cmake
else
    echo "CMAKE is installed, nothing to do here skipping ... 💨"
fi

echo "---------------------------------------------------------"
# Install timewarrior
if ! _exists timew; then
    mkdir -p $SCRIPT_DIR/tmp
    cd $SCRIPT_DIR/tmp
    curl -OL http://taskwarrior.org/download/timew-1.0.0.tar.gz
    tar xzf timew-1.0.0.tar.gz
    cd timew-1.0.0
    cmake -DCMAKE_BUILD_TYPE=release .
    make
    sudo make install
    # cleanup
    cd $SCRIPT_DIR
    rm -rf tmp
else
    echo "Timewarrior is installed, nothing to do here skipping ... 💨"
fi
echo "---------------------------------------------------------"

echo "Symlinking Timewarrior config ..."
ln -sf  "$SCRIPT_DIR/timewarrior.cfg"       ~/.timewarrior/timewarrior.cfg