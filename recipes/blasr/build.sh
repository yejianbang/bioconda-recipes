#!/usr/bin/env bash

mkdir -p "${PREFIX}"/bin
mkdir -p "${PREFIX}"/lib
mkdir -p "${PREFIX}"/include

wget https://distfiles.macports.org/szip/szip-2.1.1.tar.gz --no-ch

tar xf szip-2.1.1.tar.gz

cd szip-2.1.1

./configure --prefix=${PREFIX}

make -j

make install

cd -

wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz --no-ch

tar xf hdf5-1.8.12.tar.gz

cd hdf5-1.8.12

rm -rf bin/config.guess
rm -rf bin/config.sub
wget -O bin/config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' --no-ch
wget -O bin/config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' --no-ch


./configure  --enable-cxx --enable-static=yes --enable-shared --prefix=${PREFIX} LDFLAGS="-L${PREFIX}/lib" CPPFLAGS="-I${PREFIX}/include"

make -j

make install

cd -

sed -i "5c\HDF5INCLUDEDIR=${PREFIX}/include" common.mk

sed -i "6c\HDF5LIBDIR=${PREFIX}/lib" common.mk

sed -i "s/\-static//g" `grep -rnl "\-static"`

sed -i "13s/$/ -ldl/" common.mk

sed -i "33s/testIn/testIn.good()/g" ./common/data/hdf/HDFFile.h

sed -i "242c\ (unsigned int) curPrefix.tuple + 1 < (unsigned int) (this->lookupTableLength));" ./common/datastructures/suffixarray/SuffixArray.h

sed -i "2271s/cout <<//g" ./pbihdfutils/LoadPulses2.cpp 

sed -i "128s/ ==/.good() ==/" ./common/datastructures/alignmentset/SAMAlignment.h

make -j

cp alignment/bin/blasr "${PREFIX}"/bin
