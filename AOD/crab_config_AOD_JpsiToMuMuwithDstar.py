from CRABClient.UserUtilities import config
import getpass

config = config()
config.General.requestName = 'AOD_JpsiToMuMuwithDstar_07-12-2021'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True

config.JobType.pluginName = 'Analysis' 
config.JobType.psetName = 'AOD_cfg_2018.py'
config.JobType.numCores = 1
config.JobType.maxMemoryMB = 2000 #### I changed from 2500!!!!!

config.Data.outputDatasetTag = 'JpsiToMuMuwithDstar'
config.Data.userInputFiles = open('paths/JpsiToMuMuwithDstar.txt').readlines()
config.Data.inputDBS = 'phys03'
config.Data.publishDBS = 'phys03'
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.totalUnits = config.Data.unitsPerJob * 10000
config.Data.outLFNDirBase = '/store/user/' + getpass.getuser() + '/'
config.Data.publication = True
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC_RunII_UL_2018' # Comes after /store/user/mabarros

#config.Site.whitelist = ['T2_BR_UERJ']
config.Site.storageSite = 'T2_BR_UERJ'
