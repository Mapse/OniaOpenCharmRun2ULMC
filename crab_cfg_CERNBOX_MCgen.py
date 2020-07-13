from WMCore.Configuration import Configuration
config = Configuration()

config.section_("General")
config.General.requestName = 'UpsilonOpenCharm_MC_GS_1'
config.General.workArea = 'crab_projects'

config.section_("JobType")
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'UpsilonOpenCharmToMuMu_LHCb_cfg_GS.py'
config.JobType.allowUndistributedCMSSW = True

config.section_("Data")
config.Data.publishDBS = 'phys03'
config.Data.outputPrimaryDataset = 'CRAB_PrivateMC'
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = 100
NJOBS = 10  # This is not a configuration parameter, but an auxiliary variable that we use in the next line.
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.publication = True
config.Data.outputDatasetTag = 'UpsilonOpenCharm_CRAB3_MC_GS_1'

config.section_("Site")
config.Site.storageSite = 'T2_CH_CERNBOX' # Should change to the site that you have write permission
