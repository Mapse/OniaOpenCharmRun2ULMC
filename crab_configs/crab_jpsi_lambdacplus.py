from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'JpsiLambdaCPlus_MC_GS'
config.General.workArea = 'crab_projects'

config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'JpsiToMuMuwithLambdaCPlus_13TeV_GS.py'
config.JobType.allowUndistributedCMSSW = True

config.Data.publication = False
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.outputDatasetTag = 'JpsiLambdaCPlus_CRAB3_MC_GS'
