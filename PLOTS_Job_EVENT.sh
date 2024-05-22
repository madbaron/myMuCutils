#!/bin/bash

#source /opt/ilcsoft/muonc/init_ilcsoft.sh
source /setup.sh 

mkdir -p /data/ntup/${2}/
mkdir -p /data/ntupBIB/${2}/
mkdir -p /data/ntupTRUTH/${2}/

# 10 TeV paper performance
#python /code/LCIOmacros/study_photons.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_photon_${1}.root
#python /code/LCIOmacros/study_neutrons.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_neutron_${1}.root
#python /code/LCIOmacros/study_kaons.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_neutron_${1}.root
#python /code/LCIOmacros/study_tracks.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_track_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/analysis_softpion.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_analysis_${1}.root

#python /code/LCIOmacros/optimise_tracks.py -i /data/${2}/reco/${2}_reco_${1}.slcio -o /data/${2}/ntup/opt_${2}_track_${1}
#python /code/LCIOmacros/study_efficiency.py -i /data/${2}/reco/${2}_reco_${1}.slcio -o /data/${2}/histos/${2}_eff_${1}.root

#python /code/LCIOmacros/study_pions.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_pion_${1}.root
#python /code/LCIOmacros/study_muons.py -i /data/${2}/reco/${2}_reco_${1}.slcio -o /data/${2}/ntup/${2}_muon_${1}.root

python /code/LCIOmacros/study_softpion.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_softpion_${1}.root
python /code/LCIOmacros/study_softpion.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_softpion_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/analysis_softpion.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/truth_softpion.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntupTRUTH/${2}/${2}_truth_${1}.root

# photon performance
#python /code/LCIOmacros/study_truth_photons.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_photon_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/study_tracklets.py -i /data/reco/${2}/${2}_reco_${1}.slcio -o /data/ntup/${2}/${2}_reco_${1}.root

# with BIB
#python /code/LCIOmacros/study_photons.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_photon_${1}.root
#python /code/LCIOmacros/study_tracks.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_track_${1}.root

#python /code/LCIOmacros/study_softpion.py -t -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_softpion_${1}.root
#python /code/LCIOmacros/study_tracklets.py -i /data/recoBIB/${2}/${2}_reco_${1}.slcio -o /data/ntupBIB/${2}/${2}_tracklets_${1}.root
