#!/bin/bash
if [ `uname -m` == "aarch64" ]; then
 wget https://github.com/jratcliff63367/sse2neon/archive/refs/heads/master.zip --no-ch
 unzip master.zip
 cp sse2neon-master/SSE2NEON.h src/utility/src/align
 cp sse2neon-master/SSE2NEON.h src/utility/src/parasail

 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/align/align-ksw2-extz2-sse.C
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/align/align-ssw.H
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/align/align-ssw.C
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/internal_sse.h
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/sg_trace_striped_sse41_128_32.c
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/sg_trace_striped_sse2_128_16.c
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/memory_sse.c
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/sg_trace_striped_sse41_128_16.c
 sed -i 's%<emmintrin.h>%"SSE2NEON.h"%g' src/utility/src/parasail/sg_trace_striped_sse2_128_32.c

 sed -i '309d' src/utility/src/align/align-ksw2-extz2-sse.C
fi

make -C src BUILD_DIR="$(pwd)" \
	TARGET_DIR="${PREFIX}" \
	CXX="${CXX}" \
	CXXFLAGS="${CXXFLAGS} -O3 -I${PREFIX}/include" \
	LDFLAGS="${LDFLAGS} -fopenmp -L${PREFIX}/lib" -j"${CPU_COUNT}"
