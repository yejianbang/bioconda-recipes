#!/bin/bash

mkdir -p $PREFIX/bin

if [ `uname -m` == "aarch64" ]; then
 export C_INCLUDE_PATH=${PREFIX}/include
 export CPLUS_INCLUDE_PATH=${PREFIX}/include
 wget https://521github.com/nodejs/node/archive/refs/tags/v18.17.0.tar.gz --no-ch
 tar xf v18.17.0.tar.gz
 cd node-18.17.0
 ./configure
 make -j 64

 cd -
 sed -i "2c NODE_SRC=node-18.17.0" Makefile
 sed -i "5s%LIB_LINUX=%LIB_LINUX=-L${PREFIX}/lib %g" Makefile
 make -j 64
 cp k8 $PREFIX/bin/k8
else
 cp k8-$(uname -m)-$(uname -s) $PREFIX/bin/k8
fi
