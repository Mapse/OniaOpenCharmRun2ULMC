from CRABClient.UserUtilities import config
import getpass

config = config()
config.General.requestName = 'DR_Jpsi_21-03-2022'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True

config.JobType.pluginName = 'Analysis' 
config.JobType.psetName = 'Jpsi_Dstar_new_accept_cuts_13TeV_DR_cfg.py'
config.JobType.numCores = 1
config.JobType.maxMemoryMB = 2500

config.Data.outputDatasetTag = 'Jpsi'
config.Data.userInputFiles = open('paths/Jpsi.txt').readlines()
config.Data.inputDBS = 'phys03'
config.Data.publishDBS = 'phys03'
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.totalUnits = config.Data.unitsPerJob * 10000
config.Data.outLFNDirBase = '/store/group/uerj/' + getpass.getuser() + '/'
config.Data.publication = True
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC_RunII_UL_2017' # Comes after /store/user/mabarros/

#config.Site.whitelist = ['T2_BR_UERJ']
config.Site.storageSite = 'T2_US_Caltech'
#config.Site.storageSite = 'T2_BR_UERJ'
