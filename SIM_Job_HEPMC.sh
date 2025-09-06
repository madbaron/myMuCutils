#!/bin/bash

source /code/setup.sh

cd /dataMuC/run
mkdir -p sim_${2}_${1}
cd sim_${2}_${1}

mkdir -p /dataMuC/sim
mkdir -p /dataMuC/sim/${2}

cp /code/SteeringMacros/Sim/sim_steer_GEN_CONDOR.py sim_EVENT_${1}.py

ddsim --steeringFile sim_EVENT_${1}.py --inputFiles /dataMuC/gen/${2}/tag_1_pythia8_events.hepmc --numberOfEvents ${3} --skipNEvents ${1} --outputFile /dataMuC/sim/${2}/${2}_sim_${1}.slcio

cd ..
rm -rf sim_${2}_${1}