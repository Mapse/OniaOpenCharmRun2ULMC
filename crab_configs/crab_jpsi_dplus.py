from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'JpsiDPlus_MC_GS'
config.General.workArea = 'crab_projects'

config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'JpsiToMuMuwithDPlus_13TeV_2016_GS_cfg.py'
config.JobType.allowUndistributedCMSSW = True

config.Data.publication = False
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.outputDatasetTag = 'JpsiDPlus_CRAB3_MC_GS'
