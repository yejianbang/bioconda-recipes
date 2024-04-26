#!/bin/bash

mkdir -p $PREFIX/bin

export CPATH=${PREFIX}/include
if [ `uname -m` == "aarch64" ]; then
        sed -i "2s/-msse4//g" Makefile
fi

make  CC="${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}"  CXX="${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS}"
cp minigraph $PREFIX/bin
