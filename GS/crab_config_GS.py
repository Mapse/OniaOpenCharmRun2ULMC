from CRABClient.UserUtilities import config
import getpass

config = config()
config.General.requestName = 'GS_DATASET_DATE'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True

config.JobType.pluginName = 'PrivateMC' 
config.JobType.psetName = 'config/CONFIG'

config.Data.publication = True
config.Data.publishDBS = 'phys03'
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC_RunII_UL_2017'
config.Data.outputDatasetTag = 'DATASET' # Comes after outputPrimaryDataset
config.Data.splitting = 'EventBased' 
config.Data.unitsPerJob = EVENTSJOB
config.JobType.eventsPerLumi = 1200
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.outLFNDirBase = '/store/group/uerj/' + getpass.getuser() + '/'

#config.Site.whitelist = ['T2_BR_UERJ']
#config.Site.storageSite = 'T2_BR_UERJ'
config.Site.storageSite = 'T2_US_Caltech'
