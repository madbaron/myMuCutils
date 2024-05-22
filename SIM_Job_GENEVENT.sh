#!/bin/bash

source /setup.sh 

#cd /tmp
cd /data/run
mkdir -p sim_${2}_${1}
cd sim_${2}_${1}

mkdir -p /data/sim
mkdir -p /data/sim/${2}

cp /code/SteeringMacros/Sim/sim_steer_GEN_CONDOR.py sim_EVENT_${1}.py
#cp /code/SteeringMacros/Sim/sim_steer_x1x1_CONDOR.py sim_EVENT_${1}.py
sed 's/EVENTSTOSKIP/'${1}'/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py
sed 's/OUTFILENAME/"\/data\/sim\/'${2}'\/'${2}'_sim_'${1}'.slcio"/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py
sed 's/STEPSIZE/'${3}'/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py

ddsim --steeringFile sim_EVENT_${1}.py --inputFiles /data/gen/${2}/${2}_gen.slcio

cd ..
rm -rf sim_${2}_${1}