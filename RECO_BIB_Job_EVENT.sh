#!/bin/bash

source /code/setup.sh

mkdir -p /dataMuC/recoBIB/

cd /tmp
mkdir reco_${2}_${1}
cd reco_${2}_${1}

mkdir -p /dataMuC/recoBIB/${2}/

cp /code/SteeringMacros/k4Reco/steer_reco.py steer_reco_${2}_${1}.py

k4run steer_reco_${2}_${1}.py --TypeEvent ${2} --InFileName ${1} --enableBIB --enableIP
#k4run steer_reco_${2}_${1}.py --TypeEvent ${2} --InFileName ${1} --enableBIB --enableIP --skipReco

cd ..
rm -rf reco_${2}_${1}