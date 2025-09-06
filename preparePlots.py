import os
from optparse import OptionParser
import sys
import logging

logging.basicConfig(
    format='%(asctime)s %(levelname)s %(message)s', datefmt='%H:%M:%S')
log = logging.getLogger("mySubmissionLogger")
log.setLevel(logging.INFO)
log.info('Loading options ...')

parser = OptionParser()
parser.add_option("--outDir", help="dir to store the output",
                  default="Batch/scripts_plots/")
parser.add_option("--baseDir", help="base directory",
                  default="/data/dust/user/fmeloni")
parser.add_option("--process", help="process", default="muonGun")
parser.add_option("--step", help="step", default="10")
parser.add_option("--min", help="min event", default="0")
parser.add_option("--max", help="max event", default="10000")
parser.add_option("--nologs", help="logs to /dev/null",
                  action='store_true', default=False)
(options, args) = parser.parse_args()

log.info('Preparing ...')

process_list = [
    "electronGun_pT_0_50",
    "electronGun_pT_1000_5000",
    "electronGun_pT_250_1000",
    "electronGun_pT_50_250",
    "muonGun_pT_0_50",
    "muonGun_pT_1000_5000",
    "muonGun_pT_250_1000",
    "muonGun_pT_50_250",
    "photonGun_E_0_50",
    "photonGun_E_1000_5000",
    "photonGun_E_250_1000",
    "photonGun_E_50_250",
    "pionGun_pT_0_50",
    "pionGun_pT_1000_5000",
    "pionGun_pT_250_1000",
    "pionGun_pT_50_250",
    "tauGun_pT_0_50",
    "tauGun_pT_50_250",
    "jjvv",
    "x1Gun_test",
    "x1x1",
    "x1x1_3TeV",
    "x1x1_Rodo",
    "x1x1_2blet",
    "x1x1_3plet",
    "x1x1_5plet",
    "neutronGun_E_0_50",
    "neutronGun_E_50_250",   
    "neutronGun_E_250_1000",  
    "neutronGun_E_1000_5000",
    "nuGun_pT_0_50", 
    "dijet_mjj_50",
    "dijet_mjj_100",
    "dijet_mjj_250",
    "dijet_mjj_500",
    "dijet_mjj_1000",
    "dijet_mjj_5000",
    "dijet_mjj_10000",
    "mm2mvw2jj",
    "mm2vvz2jj",
    "mm2jj_ISRoff",
    "mm2jj_ISRon",
    "mm2h2bb",
    "mm2h2ww",
    "mm2h2tata",
    "mm2h2zz"
]
if options.process not in process_list:
    log.error('Unsupported process!')
    exit()

baseDir = options.baseDir
process = options.process

filename = "plots_"+str(process)+"_"+str(options.min).zfill(6) + "_"+str(options.max).zfill(6)+".submit"

fsub = open(baseDir+"/MuonCollider/"+options.outDir+filename, "w+")

for ievt in range(int(options.min), int(options.max), int(options.step)):

    startevent = ievt
    
    if "x1" in options.process:
        fsub.write(
            "executable = /data/dust/user/fmeloni/MuonCollider/Batch/PLOTS_Rodo_EVENT.sh \n")
    else:
        fsub.write(
            "executable = /data/dust/user/fmeloni/MuonCollider/Batch/PLOTS_Job_EVENT.sh \n")
    
    fsub.write("arguments = "+str(startevent)+" "+process+" \n")

    fsub.write("universe = vanilla"+" \n")
    if options.nologs:
        fsub.write("output = /dev/null \n")
        fsub.write("error = /dev/null \n")
        fsub.write("log = /dev/null \n")
    else:
        fsub.write("output = " + baseDir + "/Logs_Condor/plots_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).out"+" \n")
        fsub.write("error = " + baseDir + "/Logs_Condor/plots_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).err"+" \n")
        fsub.write("log = " + baseDir + "/Logs_Condor/plots_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).log"+" \n")
    fsub.write("RequestMemory = 4000 \n")
    fsub.write("on_exit_hold = (ExitBySignal == True) || (ExitStatus != 0) \n")
    fsub.write("environment = \"APPTAINER_TMPDIR=/data/dust/user/fmeloni/apptainer/tmp APPTAINER_CACHEDIR=/data/dust/user/fmeloni/apptainer/cache\" \n")
    fsub.write("+MySingularityImage = \"/cvmfs/unpacked.cern.ch/ghcr.io/muoncollidersoft/mucoll-sim-alma9:v2.9.7\" \n")
    fsub.write("+MySingularityArgs = \"--no-home -B " + baseDir +
               "/MuonCollider:/code -B " + baseDir + "/DataMuC:/dataMuC\" \n")
    fsub.write("transfer_executable = False"+" \n")
    fsub.write("should_transfer_files = False"+" \n")
    fsub.write("queue"+" \n\n")

fsub.close()

log.info('Script prepared')
