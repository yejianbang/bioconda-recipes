#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    # building the library requires an implementation of basic_stringbuf
    # from the c++ standard library
    # 10.9 seems to be the minimum possible deployment target
    MACOSX_DEPLOYMENT_TARGET=10.9
fi
if [ `uname -m` == "aarch64" ]; then
        rm -rf config.guess config.sub config/config.guess config/config.sub
        wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" -O config.guess
        wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD" -O config.sub
        cp config.guess config/config.guess
        cp config.sub config/config.sub
fi

./configure --prefix=$PREFIX
make
make install
