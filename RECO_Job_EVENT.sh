#!/bin/bash

source /code/setup.sh

mkdir -p /dataMuC/reco/

cd /tmp
mkdir reco_${2}_${1}
cd reco_${2}_${1}

mkdir -p /dataMuC/reco/${2}/

cp /code/SteeringMacros/k4Reco/steer_reco.py steer_reco_${2}_${1}.py

k4run steer_reco_${2}_${1}.py --TypeEvent ${2} --InFileName ${1}

#check_missing_cols --minimal /dataMuC/reco/${2}/${2}_reco_${1}.slcio > edm4hep_contents.txt
#sed -i '/SiTracks /d' edm4hep_contents.txt
#lcio2edm4hep /dataMuC/reco/${2}/${2}_reco_${1}.slcio /dataMuC/k4reco/${2}/${2}_reco_${1}.edm4hep.root edm4hep_contents.txt
#lcio2edm4hep /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio /dataMuC/k4recoBIB/${2}/${2}_reco_${1}.edm4hep.root edm4hep_contents.txt

cd ..
rm -rf reco_${2}_${1}