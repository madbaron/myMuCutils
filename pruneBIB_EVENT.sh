#!/bin/bash

source /setup.sh 

#mkdir -p /data/BIB10TeV/plots_mm
#python /code/LCIOmacros/study_BIB_by_cell.py -i /data/BIB10TeV/reco_mm/BIB_reco_${1}.slcio -o /data/BIB10TeV/plots_mm/BIB_plot_${1}.root

#mkdir -p /data/BIB10TeV/plots_mp
#python /code/LCIOmacros/study_BIB_by_cell.py -i /data/BIB10TeV/reco_mp/BIB_reco_${1}.slcio -o /data/BIB10TeV/plots_mp/BIB_plot_${1}.root


#mkdir -p /data/BIB10TeV/reco_mm

#cd /data/run
#mkdir reco_BIB10_${1}
#cd reco_BIB10_${1}

#cp /code/SteeringMacros/k4Reco/steer_reco_BIB10_CONDOR.py steer_reco_BIB10_${1}.py
#sed 's/INFILENAME/'${1}'/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
#mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py
#sed 's/TYPEEVENT/mm/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
#mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py

#k4run steer_reco_BIB10_${1}.py

#mkdir -p /data/BIB10TeV/reco_mp

#cp /code/SteeringMacros/k4Reco/steer_reco_BIB10_CONDOR.py steer_reco_BIB10_${1}.py
#sed 's/INFILENAME/'${1}'/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
#mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py
#sed 's/TYPEEVENT/mp/g' steer_reco_BIB10_${1}.py > steer_reco_BIB10_${1}_temp.py
#mv  steer_reco_BIB10_${1}_temp.py steer_reco_BIB10_${1}.py

#k4run steer_reco_BIB10_${1}.py

#cd ..
#rm -rf reco_BIB10_${1}

#prune 

mkdir -p /data/run
cd /data/run
mkdir prune_${1}
cd prune_${1}

mkdir -p /data/BIB10TeV/sim_mm_pruned

cp /code/SteeringMacros/Util/steer_pruneBIB_CONDOR.py prune_EVENT.py
sed 's/TYPEEVENT/mm/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py
sed 's/INFILENAME/'${1}'/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py

k4run prune_EVENT.py

mkdir -p /data/BIB10TeV/sim_mp_pruned

cp /code/SteeringMacros/Util/steer_pruneBIB_CONDOR.py prune_EVENT.py
sed 's/TYPEEVENT/mp/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py
sed 's/INFILENAME/'${1}'/g' prune_EVENT.py > prune_EVENT_temp.py
mv  prune_EVENT_temp.py prune_EVENT.py

k4run prune_EVENT.py

cd ..
rm -rf prune_${1}