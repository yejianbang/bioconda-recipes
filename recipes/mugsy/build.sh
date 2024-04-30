mkdir -pv ${PREFIX}/bin ${PREFIX}/etc/conda/activate.d ${PREFIX}/etc/conda/deactivate.d
if [ `uname -m` == "aarch64" ]; then
 cd MUMmer3.20/src/tigr
 sed -i "16a #include <algorithm>" show-diff.cc
 make
 cd -
 make src-libmaf/libmaf.a
 make nucmer
 make all
 cp README.old README
 cp mugsy-seqan/projects/library/apps/mugsy/gcc/mugsy mugsyWGA
 cp chaining/synchain-mugsy synchain-mugsy
 cp MUMmer3.20/src/tigr/delta-filter MUMmer3.20/delta-filter
 cp MUMmer3.20/src/tigr/delta2maf MUMmer3.20/delta2maf
 cp MUMmer3.20/src/tigr/gaps MUMmer3.20/gaps
 cp MUMmer3.20/src/tigr/mgaps MUMmer3.20/mgaps
 
 sed -i "2s/x86-64/aarch64/g" Makefile
 sed -i "55,56s%/aux_bin%%g" Makefile
 
 make mugsy_install
 make mummer_install
 
 cp -R mugsy_aarch64-v1r2.3.1/* ${PREFIX}/bin
else
 cp -R {*.sh,*.pl,MUMmer3.20,mugsy,mugsyWGA,synchain-mugsy} ${PREFIX}/bin
fi
cp mugsyenv.sh ${PREFIX}/etc/conda/activate.d
cat <<EOF >>  ${PREFIX}/etc/conda/deactivate.d/mugsyenv.sh
unset MUGSY_INSTALL
unset PERL5LIB
EOF
