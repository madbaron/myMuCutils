#!/bin/bash

source /code/setup.sh 

mkdir -p /dataMuC/ntup/${2}/
mkdir -p /dataMuC/ntupBIB/${2}/
mkdir -p /dataMuC/ntupTRUTH/${2}/

# 10 TeV paper performance
python /code/LCIOmacros/study_jets.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_jets_${1}.root -p /code/LCIOmacros/ResponseMap_reco_photons_v5_noBIB.root -n /code/LCIOmacros/ResponseMap_reco_neutrons_v5_noBIB.root -j /code/LCIOmacros/ResponseMap_reco_jets_v5_noBIB.root 

#python /code/LCIOmacros/study_photons.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_photon_${1}.root
#python /code/LCIOmacros/study_neutrons.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_neutron_${1}.root
#python /code/LCIOmacros/study_kaons.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_neutron_${1}.root
#python /code/LCIOmacros/study_tracks.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_track_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/analysis_softpion.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_analysis_${1}.root

#python /code/LCIOmacros/optimise_tracks.py -i /dataMuC/${2}/reco/${2}_reco_${1}.slcio -o /dataMuC/${2}/ntup/opt_${2}_track_${1}
#python /code/LCIOmacros/study_efficiency.py -i /dataMuC/${2}/reco/${2}_reco_${1}.slcio -o /dataMuC/${2}/histos/${2}_eff_${1}.root

#python /code/LCIOmacros/study_pions.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_pion_${1}.root
#python /code/LCIOmacros/study_muons.py -i /dataMuC/${2}/reco/${2}_reco_${1}.slcio -o /dataMuC/${2}/ntup/${2}_muon_${1}.root

#python /code/LCIOmacros/study_softpion.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_softpion_${1}.root
#python /code/LCIOmacros/study_softpion.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_softpion_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/analysis_softpion.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/truth_softpion.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupTRUTH/${2}/${2}_truth_${1}.root

# photon performance
#python /code/LCIOmacros/study_truth_photons.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_photon_${1}.root

#python /code/LCIOmacros/analysis_softpion.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_analysis_${1}.root
#python /code/LCIOmacros/study_tracklets.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_reco_${1}.root

# with BIB
#python /code/LCIOmacros/study_photons.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_photon_${1}.root
#python /code/LCIOmacros/study_tracks.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_track_${1}.root
#python /code/LCIOmacros/study_tracks.py -i /dataMuC/reco/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntup/${2}/${2}_track_${1}.root

#python /code/LCIOmacros/study_softpion.py -t -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_softpion_${1}.root
#python /code/LCIOmacros/study_tracklets.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_tracklets_${1}.root

#python /code/LCIOmacros/study_jets.py -i /dataMuC/recoBIB/${2}/${2}_reco_${1}.slcio -o /dataMuC/ntupBIB/${2}/${2}_jets_${1}.root
