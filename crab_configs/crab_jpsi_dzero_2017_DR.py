from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'JpsiDzero_MC_2017_DR'
config.General.workArea = 'crab_projects'

config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'JpsiToMuMuwithDzero_13TeV_2017_DR_cfg.py'
config.JobType.allowUndistributedCMSSW = True
config.JobType.numCores = 4

config.Data.publication = False
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.outputDatasetTag = 'JpsiDzero_CRAB3_MC_2017_DR' 
