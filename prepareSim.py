from optparse import OptionParser
import logging

logging.basicConfig(
    format='%(asctime)s %(levelname)s %(message)s', datefmt='%H:%M:%S')
log = logging.getLogger("mySubmissionLogger")
log.setLevel(logging.INFO)
log.info('Loading options ...')

parser = OptionParser()
parser.add_option("--baseDir", help="base directory",
                  default="/nfs/dust/atlas/user/fmeloni")
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
    "tauGun_pT_250_1000",
    "tauGun_pT_1000_5000",
    "jjvv",
    "x1Gun_test",
    "x1x1",
    "x1x1_3TeV",
    "x1x1_Rodo",
    "neutronGun_E_0_50",   
    "neutronGun_E_50_250",   
    "neutronGun_E_250_1000"   
]

process = options.process
if process not in process_list:
    log.error('Unsupported process!')
    exit()

baseDir = options.baseDir
filename = "sim_" + str(process)+"_"+str(options.min).zfill(6) + \
    "_"+str(options.max).zfill(6)+".submit"

fsub = open(baseDir+"/MuonCollider/Batch/scripts_sim/"+filename, "w+")

for ievt in range(int(options.min), int(options.max), int(options.step)):

    startevent = ievt

    if "x1x1" in process:
        fsub.write("executable = " + baseDir +
                   "/MuonCollider/Batch/SIM_Job_x1x1EVENT.sh \n")
    else:
        fsub.write("executable = " + baseDir +
                   "/MuonCollider/Batch/SIM_Job_GENEVENT.sh \n")

    fsub.write("arguments = "+str(startevent)+" " +
               process + " "+options.step+" \n")

    if "x1x1" in process:
        fsub.write(
            "+MySingularityImage = \"/cvmfs/unpacked.cern.ch/registry.hub.docker.com/infnpd/mucoll-ilc-framework:1.4-centos8\" \n")
    else:
        fsub.write(
            "+MySingularityImage = \"/nfs/dust/atlas/user/fmeloni/MuonCollider/myImages/k4toroid.sif\" \n")
    fsub.write("+MySingularityArgs = \"--no-home -B " + baseDir +
               "/MuonCollider:/code -B " + baseDir + "/DataMuC:/data\" \n")
    fsub.write("universe = vanilla"+" \n")
    fsub.write("requirements = OpSysAndVer == \"CentOS7\" \n")
    fsub.write("RequestMemory = 2000 \n")
    if options.nologs:
        fsub.write("output = /dev/null \n")
        fsub.write("error = /dev/null \n")
        fsub.write("log = /dev/null \n")
    else:
        fsub.write("output = " + baseDir + "/Logs_Condor/sim_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).out"+" \n")
        fsub.write("error = " + baseDir + "/Logs_Condor/sim_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).err"+" \n")
        fsub.write("log = " + baseDir + "/Logs_Condor/sim_"+str(process) +
                   "_"+str(startevent).zfill(6)+"_$(ClusterId).$(ProcId).log"+" \n")
    if process != "x1x1":
        fsub.write("environment = \"APPTAINER_TMPDIR=/nfs/dust/atlas/user/fmeloni/apptainer/tmp APPTAINER_CACHEDIR=/nfs/dust/atlas/user/fmeloni/apptainer/cache\" \n")
    fsub.write("on_exit_hold = (ExitBySignal == True) || (ExitStatus != 0) \n")
    fsub.write("transfer_executable = False"+" \n")
    fsub.write("should_transfer_files = False"+" \n")
    fsub.write(
        "periodic_release = ((JobStatus == 5) && (time() - EnteredCurrentStatus) > 240)"+" \n")
    fsub.write("queue"+" \n\n")

fsub.close()

log.info('Script prepared')
