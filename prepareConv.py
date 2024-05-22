from optparse import OptionParser
import logging

logging.basicConfig(
    format='%(asctime)s %(levelname)s %(message)s', datefmt='%H:%M:%S')
log = logging.getLogger("mySubmissionLogger")
log.setLevel(logging.INFO)
log.info('Loading options ...')

parser = OptionParser()
parser.add_option("--outDir", help="dir to store the output",
                  default="Batch/scripts_conv/")
parser.add_option("--baseDir", help="base directory",
                  default="/nfs/dust/atlas/user/fmeloni")
parser.add_option("--process", help="process", default="muonGun")
parser.add_option("--step", help="step", default="10")
parser.add_option("--min", help="min event", default="0")
parser.add_option("--max", help="max event", default="1000")
parser.add_option("--energy", help="gun energy", default="1000")
parser.add_option("--nologs", help="logs to /dev/null",
                  action='store_true', default=False)
(options, args) = parser.parse_args()

log.info('Preparing ...')

process_list = ["smuons", "selectrons", "pionGun", "bib",
                "muonGun", "electronGun", "photonGun", "sbottom", "zh"]
if options.process not in process_list:
    log.error('Unsupported process!')
    exit()

baseDir = options.baseDir

process = options.process
if "Gun" in options.process:
    process = options.process + "_" + str(options.energy)

filename = "conv_"+str(process)+"_"+str(options.min).zfill(6) + \
    "_"+str(options.max).zfill(6)+".submit"
fsub = open(baseDir+"/MuonCollider/"+options.outDir+filename, "w+")

for ievt in range(int(options.min), int(options.max), int(options.step)):

    startevent = ievt

    if process == "bib":
        fsub.write(
            "executable = /nfs/dust/atlas/user/fmeloni/MuonCollider/Batch/CONVBIB_Job_EVENT.sh \n")
    else:
        fsub.write(
            "executable = /nfs/dust/atlas/user/fmeloni/MuonCollider/Batch/CONV_Job_EVENT.sh \n")
    fsub.write("arguments = "+str(startevent)+" "+process+" \n")
    fsub.write("+MySingularityImage = \"/nfs/dust/atlas/user/fmeloni/MuonCollider/myImages/k4toroid.sif\" \n")
    fsub.write("+MySingularityArgs = \"--no-home -B " + baseDir + "/MuonCollider:/code -B " + baseDir + "/DataMuC:/data\" \n")
    fsub.write("universe = vanilla"+" \n")
    if options.nologs:
        fsub.write("output = /dev/null \n")
        fsub.write("error = /dev/null \n")
        fsub.write("log = /dev/null \n")
    else:
        fsub.write("output = " + baseDir + "/Logs_Condor/conv_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).out"+" \n")
        fsub.write("error = " + baseDir + "/Logs_Condor/conv_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).err"+" \n")
        fsub.write("log = " + baseDir + "/Logs_Condor/conv_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).log"+" \n")
    fsub.write("requirements = OpSysAndVer == \"CentOS7\" \n")
    fsub.write("RequestMemory = 8000 \n")
    #fsub.write("+requestRuntime=28800 \n")
    fsub.write("on_exit_hold = (ExitBySignal == True) || (ExitStatus != 0) \n")
    fsub.write("transfer_executable = False"+" \n")
    fsub.write("should_transfer_files = False"+" \n")
    fsub.write(
        "periodic_release = ((JobStatus == 5) && (time() - EnteredCurrentStatus) > 240)"+" \n")
    fsub.write("queue"+" \n\n")

fsub.close()

log.info('Script prepared')
