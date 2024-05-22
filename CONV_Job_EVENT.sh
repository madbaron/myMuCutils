#!/bin/bash

source /cvmfs/ilc.desy.de/key4hep/luxe_setup.sh
cd /tmp
mkdir conv_${2}_${1}
cd conv_${2}_${1}

mkdir -p /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/reco_k4/
mkdir -p /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/reco_k4BIB/

/nfs/dust/atlas/user/fmeloni/Key4hep/k4EDM4hep2LcioConv/build/standalone/lcio2edm4hep /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/reco/${2}_reco_${1}.slcio /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/reco_k4/${2}_reco_${1}.root
/nfs/dust/atlas/user/fmeloni/Key4hep/k4EDM4hep2LcioConv/build/standalone/lcio2edm4hep /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/recoBIB/${2}_reco_${1}.slcio /nfs/dust/atlas/user/fmeloni/DataMuC/${2}/reco_k4BIB/${2}_reco_${1}.root

cd ..
rm -rf conv_${2}_${1}
