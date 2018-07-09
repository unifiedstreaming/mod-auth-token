#!/bin/sh -ex
autoreconf -f -i
./configure --quiet --enable-silent-rules
make
sudo make install
