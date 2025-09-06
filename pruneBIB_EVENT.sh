#!/bin/bash

source /opt/spack/opt/spack/linux-almalinux9-x86_64/gcc-11.5.0/mucoll-stack-master-h2ssl2yh2yduqnhsv2i2zcjws74v7mcq/setup.sh

#prune 
mkdir -p /dataMuC/run
cd /dataMuC/run
mkdir prune_${1}
cd prune_${1}

mkdir -p /dataMuC/BIB10TeV/sim_mm_pruned

cp /code/SteeringMacros/Util/steer_pruneBIB_CONDOR.py prune_EVENT.py
sed 's/TYPEEVENT/mm/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py
sed 's/INFILENAME/'${1}'/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py

k4run prune_EVENT.py

mkdir -p /dataMuC/BIB10TeV/sim_mp_pruned

cp /code/SteeringMacros/Util/steer_pruneBIB_CONDOR.py prune_EVENT.py
sed 's/TYPEEVENT/mp/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py
sed 's/INFILENAME/'${1}'/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py

k4run prune_EVENT.py

#reco
mkdir -p /dataMuC/BIB10TeV/reco_mm
mkdir -p /dataMuC/BIB10TeV/reco_mp

cd /tmp
mkdir reco_BIB10_${1}
cd reco_BIB10_${1}

cp /code/SteeringMacros/k4Reco/steer_reco_BIB10_CONDOR.py steer_reco_BIB10_${1}.py
sed 's/INFILENAME/'${1}'/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py
sed 's/TYPEEVENT/mm/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py

k4run steer_reco_BIB10_${1}.py

cp /code/SteeringMacros/k4Reco/steer_reco_BIB10_CONDOR.py steer_reco_BIB10_${1}.py
sed 's/INFILENAME/'${1}'/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py
sed 's/TYPEEVENT/mp/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py

k4run steer_reco_BIB10_${1}.py

cd ..
rm -rf reco_BIB10_${1}

#plot
mkdir -p /dataMuC/BIB10TeV/plots_mm
mkdir -p /dataMuC/BIB10TeV/plots_mp

python /code/LCIOmacros/study_BIB_by_cell.py -i /dataMuC/BIB10TeV/reco_mm/BIB_reco_${1}.slcio -o /dataMuC/BIB10TeV/plots_mm/BIB_plot_${1}.root
python /code/LCIOmacros/study_BIB_by_cell.py -i /dataMuC/BIB10TeV/reco_mp/BIB_reco_${1}.slcio -o /dataMuC/BIB10TeV/plots_mp/BIB_plot_${1}.root
