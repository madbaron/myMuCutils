#!/bin/bash

source /opt/spack/opt/spack/linux-almalinux9-x86_64/gcc-11.5.0/mucoll-stack-master-h2ssl2yh2yduqnhsv2i2zcjws74v7mcq/setup.sh

mkdir -p /dataMuC/run
cd /dataMuC/run
mkdir bib_${2}_${1}
cd bib_${2}_${1}

mkdir -p /dataMuC/BIB10TeV
mkdir -p /dataMuC/BIB10TeV/sim_mm
mkdir -p /dataMuC/BIB10TeV/sim_mp
mkdir -p /dataMuC/histBIB

# ESPPU
#n = 57800 decays/m * 246 m / 6667 (cycles) / 200 (decays per cycle) = 10.66
#n = 42.64 to get 4 BX for oversampling
#python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -n ${2} /dataMuC/BIB10TeV/FLUKA/summary${1}_DET_IP.dat BIBinput.slcio
python3 /code/detector-simulation/utils/fluka_remix.py -n ${2} /dataMuC/BIB10TeV/FLUKA/summary${1}_DET_IP.dat BIBinput.slcio

#n = 64000 decays/m * 110 m / 106000 (tot gen particles) = 66.42
# latest of the previous
#python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -n ${2} /code/muon-decay-for-mc/particle_lists/high_statistics/10TeV_5T_uniform/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
#python3 /code/detector-simulation/utils/fluka_to_slcio.py -n ${2} -b 1167.4718151832183 /code/muon-decay-for-mc/particle_lists/pureFF_withCC_synchrad_on_v1/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
#python3 /code/detector-simulation/utils/fluka_to_slcio.py -n 100 -b 687.67366975809892 /code/muon-decay-for-mc/particle_lists/pureFF_withCC_synchrad_on_v1/joined_data/summary${1}_DET_IP.dat BIBinput.slcio

cp /code/SteeringMacros/Sim/sim_steer_BIB_CONDOR.py sim_EVENT_${1}.py
sed 's/OUTFILENAME/"\/dataMuC\/BIB10TeV\/sim_mp\/BIB_sim_'${1}'.slcio"/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py

ddsim --steeringFile sim_EVENT_${1}.py --inputFiles BIBinput.slcio
python /code/LCIOmacros/study_mc.py -i BIBinput.slcio -o /dataMuC/histBIB/histos_BIBmp_mc_${1}.root
rm BIBinput.slcio

#ESPPU
#python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -i 1 -n ${2} /dataMuC/BIB10TeV/FLUKA/summary${1}_DET_IP.dat BIBinput.slcio
python3 /code/detector-simulation/utils/fluka_remix.py -i 1 -n ${2} /dataMuC/BIB10TeV/FLUKA/summary${1}_DET_IP.dat BIBinput.slcio

# latest of the previous
#python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -n ${2} /code/muon-decay-for-mc/particle_lists/high_statistics/10TeV_5T_uniform_mu-_beam/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
#python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -i 1 -n ${2} /code/muon-decay-for-mc/particle_lists/high_statistics/10TeV_5T_uniform/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
#python3 /code/detector-simulation/utils/fluka_to_slcio.py -i 1 -n ${2} -b 1167.4718151832183 /code/muon-decay-for-mc/particle_lists/pureFF_withCC_synchrad_on_v1/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
#python3 /code/detector-simulation/utils/fluka_to_slcio.py -i 1 -n 100 -b 687.67366975809892 /code/muon-decay-for-mc/particle_lists/pureFF_withCC_synchrad_on_v1/joined_data/summary${1}_DET_IP.dat BIBinput.slcio

cp /code/SteeringMacros/Sim/sim_steer_BIB_CONDOR.py sim_EVENT_${1}.py
sed 's/OUTFILENAME/"\/dataMuC\/BIB10TeV\/sim_mm\/BIB_sim_'${1}'.slcio"/g' sim_EVENT_${1}.py > sim_EVENT_${1}_temp.py
mv  sim_EVENT_${1}_temp.py sim_EVENT_${1}.py

ddsim --steeringFile sim_EVENT_${1}.py --inputFiles BIBinput.slcio
python /code/LCIOmacros/study_mc.py -i BIBinput.slcio -o /dataMuC/histBIB/histos_BIBmm_mc_${1}.root
rm BIBinput.slcio

# produce simhit plots
python /code/LCIOmacros/study_BIB_truth.py -i /dataMuC/BIB10TeV/sim_mp/BIB_sim_${1}.slcio -o /dataMuC/histBIB/histos_BIBmp_simhit_${1}.root
python /code/LCIOmacros/study_BIB_truth.py -i /dataMuC/BIB10TeV/sim_mm/BIB_sim_${1}.slcio -o /dataMuC/histBIB/histos_BIBmm_simhit_${1}.root

cd ..
rm -rf bib_${2}_${1}