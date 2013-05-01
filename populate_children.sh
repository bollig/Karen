#!/bin/bash 

if [ ! -d "paper1/" ]; then 
	git clone -b cleanup_jcp_typeset ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/paper1.git 
fi
if [ ! -d "paper2/" ]; then 
	git clone -b master ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/paper2.git 
fi 
if [ ! -d "locality_sensitive_hashing/" ]; then 
	git clone -b master ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/locality_sensitive_hashing.git 
fi 
if [ ! -d "prospectus/" ]; then 
	git clone -b master ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/prospectus.git
fi 
if [ ! -d "spear_benchmarks/" ]; then 
	git clone -b master ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/spear_benchmarks.git
fi 
if [ ! -d "fsu_2012/" ]; then 
	git clone -b master git@github.com:bollig/fsu_2012.git
fi 
if [ ! -d "ncar_2011/" ]; then 
	git clone -b master git@github.com:bollig/ncar_2011.git
fi 
if [ ! -d "keeneland_benchmarks/" ]; then 
	git clone -b master git@github.com:bollig/keeneland_benchmarks.git
fi 
if [ ! -d "rbffd_gpu_doc/" ]; then 
	git clone -b master ssh://efb06@pamd.sc.fsu.edu/~efb06/repos/rbffd_gpu_doc.git
fi 
if [ ! -d "rbffd_gpu/" ]; then 
	git clone -b master git@github.com:bollig/rbffd_gpu.git
fi 
if [ ! -d "rbffd_gpu_scripts/" ]; then 
	git clone -b master git@github.com:bollig/rbffd_gpu_scripts.git
fi  
if [ ! -d "karen_references/" ]; then 
	git clone -b master git@github.com:bollig/karen_references.git
fi   
if [ ! -d "rbffd_prototypes/" ]; then 
	git clone -b master git@github.com:bollig/rbffd_prototypes.git
fi 
