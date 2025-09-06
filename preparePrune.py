from optparse import OptionParser
import logging

logging.basicConfig(
    format='%(asctime)s %(levelname)s %(message)s', datefmt='%H:%M:%S')
log = logging.getLogger("mySubmissionLogger")
log.setLevel(logging.INFO)
log.info('Loading options ...')

parser = OptionParser()
parser.add_option("--outDir", help="dir to store the output",
                  default="Batch/scripts_prune/")
parser.add_option("--baseDir", help="base directory",
                  default="/data/dust/user/fmeloni")
parser.add_option("--min", help="min event", default="1")
#parser.add_option("--max", help="max event", default="769")
parser.add_option("--max", help="max event", default="6668")
parser.add_option("--nologs", help="logs to /dev/null",
                  action='store_true', default=False)
(options, args) = parser.parse_args()

log.info('Preparing ...')

baseDir = options.baseDir

filename = "pruneconv_" + str(options.min).zfill(6)+"_"+str(options.max).zfill(6)+".submit"
fsub = open(baseDir+"/MuonCollider/"+options.outDir+filename, "w+")

for ievt in range(int(options.min), int(options.max)):

    startevent = ievt

    fsub.write("executable = " + baseDir +
               "/MuonCollider/Batch/pruneBIB_EVENT.sh \n")
    fsub.write("arguments = "+str(startevent)+" \n")

    fsub.write("+MySingularityImage = \"/cvmfs/unpacked.cern.ch/ghcr.io/muoncollidersoft/mucoll-sim-alma9:v2.9.7\" \n")
    fsub.write("+MySingularityArgs = \"--no-home -B " + baseDir + "/MuonCollider:/code -B " + baseDir + "/DataMuC:/dataMuC\" \n")
    fsub.write("universe = vanilla"+" \n")
    fsub.write("RequestMemory = 16000 \n")    
    if options.nologs:
        fsub.write("output = /dev/null \n")
        fsub.write("error = /dev/null \n")
        fsub.write("log = /dev/null \n")
    else:
        fsub.write("output = " + baseDir + "/Logs_Condor/pruneBIB_" +
                   str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).out"+" \n")
        fsub.write("error = " + baseDir + "/Logs_Condor/pruneBIB_" +
                   str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).err"+" \n")
        fsub.write("log = " + baseDir + "/Logs_Condor/pruneBIB_" +
                   str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).log"+" \n")

    fsub.write("environment = \"APPTAINER_TMPDIR=/data/dust/user/fmeloni/apptainer/tmp APPTAINER_CACHEDIR=/data/dust/user/fmeloni/apptainer/cache\" \n")
    fsub.write("on_exit_hold = (ExitBySignal == True) || (ExitStatus != 0) \n")
    fsub.write("transfer_executable = False"+" \n")
    fsub.write("should_transfer_files = False"+" \n")
    fsub.write(
        "periodic_release = ((JobStatus == 5) && (time() - EnteredCurrentStatus) > 240)"+" \n")
    fsub.write("queue"+" \n\n")

fsub.close()

log.info('Script prepared')
