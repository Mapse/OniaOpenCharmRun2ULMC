import FWCore.ParameterSet.Config as cms
process = cms.Process("GENLevelDump")
import FWCore.Utilities.FileUtils as FileUtils

## 2017 geometry 
#from Configuration.Eras.Era_Run2_2018_cff import Run2_2018

## Phase 2
from Configuration.Eras.Era_Phase2C8_timing_layer_bar_cff import Phase2C8_timing_layer_bar
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')

## Global tag for 10.6 phase2 mc
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '102X_mc2017_realistic_v8', '')

process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(1) )


# File source
#mylist = FileUtils.loadListFromFile('files_path_D0.txt') 
process.source = cms.Source(
    "PoolSource",
    fileNames  = cms.untracked.vstring('file:/eos/user/m/mabarros/CRAB_PrivateMC/JpsiDSPlus_CRAB3_MC_GS/200804_214627/0000/JpsiToMuMuwithDSPlus_13TeV_GS_100.root'),
    #fileNames  = cms.untracked.vstring(*mylist),
    duplicateCheckMode = cms.untracked.string('noDuplicateCheck')
)


## Show GenParticles
process.load("SimGeneral.HepPDTESSource.pythiapdt_cfi")
process.printTree = cms.EDAnalyzer("ParticleListDrawer",
  maxEventsToPrint = cms.untracked.int32(10),
  printVertex = cms.untracked.bool(False),
  printOnlyHardInteraction = cms.untracked.bool(False), # Print only status=3 particles. This will not work for Pythia8, which does not have any such particles.
  src = cms.InputTag("genParticles"), #genParticles
     
)


""" process.TFileService = cms.Service("TFileService",
	fileName = cms.string("mc_D0.root"),
	closeFileFast = cms.untracked.bool(True)) """

# Path and endpath to run the producer and output modules
process.p =  cms.Path(process.printTree) #process.genlevel+
