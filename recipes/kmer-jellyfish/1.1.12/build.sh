#!/bin/bash
if [ `uname -m` == "aarch64" ]; then
 sed -i "8s/^/#/g" configure.ac
 sed -i "8a LT_INIT" configure.ac
fi
autoreconf -fi
./configure --prefix=$PREFIX
make
make install
