#!/bin/bash

#source /cvmfs/ilc.desy.de/key4hep/luxe_setup.sh
#
#mkdir convbib_${2}_${1}
#cd convbib_${2}_${1}
#
#mkdir -p /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mm_k4/
#mkdir -p /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mp_k4/
#
#/nfs/dust/atlas/user/fmeloni/Key4hep/k4EDM4hep2LcioConv/build/standalone/lcio2edm4hep /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mm/BIB_sim_${1}.slcio /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mm_k4/BIB_sim_${1}.root
#/nfs/dust/atlas/user/fmeloni/Key4hep/k4EDM4hep2LcioConv/build/standalone/lcio2edm4hep /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mp/BIB_sim_${1}.slcio /nfs/dust/atlas/user/fmeloni/DataMuC/BIB10TeV/sim_mp_k4/BIB_sim_${1}.root
#cd ..
#rm -rf convbib_${2}_${1}

source /setup.sh 
cd /tmp

mkdir -p /data/histBIB/

python /code/LCIOmacros/study_BIB_truth.py -i /data/BIB10TeV/sim_mp/BIB_sim_${1}.slcio -o /data/histBIB/histos_BIBmp_simhit_${1}.root
python /code/LCIOmacros/study_BIB_truth.py -i /data/BIB10TeV/sim_mm/BIB_sim_${1}.slcio -o /data/histBIB/histos_BIBmm_simhit_${1}.root

python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -n 45 /code/muon-decay-for-mc/particle_lists/high_statistics/10TeV_5T_uniform/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
python /code/LCIOmacros/study_mc.py -i BIBinput.slcio -o /data/histBIB/histos_BIBmp_mc_${1}.root
rm BIBinput.slcio

python3 /code/detector-simulation/utils/fluka_to_slcio_new.py -n 45 /code/muon-decay-for-mc/particle_lists/high_statistics/10TeV_5T_uniform_mu-_beam/joined_data/summary${1}_DET_IP.dat BIBinput.slcio
python /code/LCIOmacros/study_mc.py -i BIBinput.slcio -o /data/histBIB/histos_BIBmm_mc_${1}.root
rm BIBinput.slcio
