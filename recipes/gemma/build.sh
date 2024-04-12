#!/bin/bash
set -eu
# Install libqualmath for linux-aarch64
if [ `uname -m` == "aarch64" ];then
 cd gcc/libquadmath
 mkdir build
 cd build
 ../configure --prefix=${SRC_DIR}/gcc/libquadmath/install
 make
 cp .libs/libquadmath.a ${PREFIX}/lib/
 cp .libs/libquadmath.so* ${PREFIX}/lib/
 cp ../quadmath.h ${PREFIX}/include/
 cp ../quadmath_weak.h ${PREFIX}/include/
 cd ${SRC_DIR}
 rm -rf gcc
fi
# Fix coredumperd caused by passing a wild pointer or released pointer when calling gsl_rng_free() in param.cpp
if [ `uname -m` == "aarch64" ];then
 sed -i "110s%^%//%g" src/param.cpp
fi

export C_INCLUDE_PATH=${PREFIX}/include
export CPP_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

LIBS="${PREFIX}/lib/libgsl.a ${PREFIX}/lib/libgslcblas.a -L${PREFIX}/lib -pthread -lopenblas -lz -lgfortran -lquadmath"

if [ $(uname) == "Darwin" ]; then
    PIE=""
else
    PIE="-no-pie"
fi

make EIGEN_INCLUDE_PATH="${PREFIX}/include/eigen3" WITH_OPENBLAS=1 DEBUG=0 GCC_FLAGS="-Wall" LIBS="${LIBS} ${PIE}"

mkdir -p ${PREFIX}/bin
cp bin/gemma ${PREFIX}/bin/gemma
