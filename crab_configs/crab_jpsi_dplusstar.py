from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'JpsiDStarPlus_MC_GS'
config.General.workArea = 'crab_projects'

config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'JpsiToMuMuwithDstar_13TeV_GS.py'
config.JobType.allowUndistributedCMSSW = True

config.Data.publication = False
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.outputDatasetTag = 'JpsiDStarPlus_CRAB3_MC_GS'
