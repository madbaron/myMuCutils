#!/bin/bash

#source /opt/ilcsoft/muonc/init_ilcsoft.sh
#source /code/setup.sh 

source /setup.sh 

mkdir -p /data/reco/
mkdir -p /data/recoBIB/

cd /tmp
mkdir reco_${2}_${1}
cd reco_${2}_${1}

mkdir -p /data/reco/${2}/
mkdir -p /data/recoBIB/${2}/

#cp /code/SteeringMacros/k4Reco/steer_reco_3TeV_CONDOR.py steer_reco_${2}_${1}.py
cp /code/SteeringMacros/k4Reco/steer_reco_CONDOR.py steer_reco_${2}_${1}.py
#cp /code/SteeringMacros/k4Reco/steer_reco_BIB_CONDOR.py steer_reco_${2}_${1}.py
sed 's/INFILENAME/'${1}'/g' steer_reco_${2}_${1}.py > steer_reco_${2}_${1}_temp.py
mv  steer_reco_${2}_${1}_temp.py steer_reco_${2}_${1}.py
sed 's/TYPEEVENT/'${2}'/g' steer_reco_${2}_${1}.py > steer_reco_${2}_${1}_temp.py
mv  steer_reco_${2}_${1}_temp.py steer_reco_${2}_${1}.py

k4run steer_reco_${2}_${1}.py

#check_missing_cols --minimal /data/reco/${2}/${2}_reco_${1}.slcio > edm4hep_contents.txt
#sed -i '/SiTracks /d' edm4hep_contents.txt
#lcio2edm4hep /data/reco/${2}/${2}_reco_${1}.slcio /data/k4reco/${2}/${2}_reco_${1}.edm4hep.root edm4hep_contents.txt
#lcio2edm4hep /data/recoBIB/${2}/${2}_reco_${1}.slcio /data/k4recoBIB/${2}/${2}_reco_${1}.edm4hep.root edm4hep_contents.txt

cd ..
rm -rf reco_${2}_${1}