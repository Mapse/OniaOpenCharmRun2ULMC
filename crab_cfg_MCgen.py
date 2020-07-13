from WMCore.Configuration import Configuration
config = Configuration()

config.section_("General")
config.General.requestName = 'UpsilonOpenCharm_MC_GS'
config.General.workArea = 'crab_projects'

config.section_("JobType")
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'UpsilonToMuMuDzero_GS_cfg.py'
config.JobType.allowUndistributedCMSSW = True

config.section_("Data")
config.Data.publication = False
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = 100000
NJOBS = 100  # This is not a configuration parameter, but an auxiliary variable that we use in the next line.
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.outputDatasetTag = 'UpsilonOpenCharm_CRAB3_MC_GS'

config.section_("Site")
config.Site.storageSite = 'T2_BR_UERJ' # Should change to the site that you have write permission