#!/bin/bash

source /opt/ilcsoft/muonc/init_ilcsoft.sh 
cd /tmp
mkdir sim_${2}_${1}
cd sim_${2}_${1}

mkdir -p /data/${2}
mkdir -p /data/${2}/sim

cp /code/SteeringMacros/Sim/sim_steer_GEN_CONDOR.py sim_EVENT_${1}.py
sed 's/EVENTSTOSKIP/'${1}'/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py
sed 's/OUTFILENAME/"\/data\/'${2}'\/sim\/'${2}'_sim_'${1}'.slcio"/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py
sed 's/STEPSIZE/'${3}'/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py

ddsim --steeringFile sim_EVENT_${1}.py --inputFiles /data/${2}/hepmc_10TeV/tag_1_pythia8_events.hepmc

cd ..
rm -rf sim_${2}_${1}