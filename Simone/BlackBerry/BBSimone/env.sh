#!/bin/bash
source ~/Apps/bbndk-2.1.0/bbndk-env.sh
export DEBUG_TOKEN=~/.rim/debugtoken1.bar
export PATH=/home/bedahr/Apps/bbndk-2.1.0/qt/prefix/bin:$PATH
export QTDIR=/home/bedahr/Apps/bbndk-2.1.0/qt/prefix
echo "Setup complete, go ahead"
exec /bin/bash
