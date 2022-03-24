from CRABClient.UserUtilities import config
import getpass

config = config()
config.General.requestName = 'GS_Jpsi_16-03-2022'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True

config.JobType.pluginName = 'PrivateMC' 
config.JobType.psetName = 'config/Jpsi_Dstar_new_accept_cuts_13TeV_GS_cfg.py'

config.Data.publication = True
config.Data.publishDBS = 'phys03'
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC_RunII_UL_2017'
config.Data.outputDatasetTag = 'Jpsi' # Comes after outputPrimaryDataset
config.Data.splitting = 'EventBased' 
config.Data.unitsPerJob = 1200000
config.JobType.eventsPerLumi = 1200
config.Data.totalUnits = config.Data.unitsPerJob * 10000
config.Data.outLFNDirBase = '/store/group/uerj/' + getpass.getuser() + '/'

#config.Site.whitelist = ['T2_BR_UERJ']
#config.Site.storageSite = 'T2_BR_UERJ'
config.Site.storageSite = 'T2_US_Caltech'
