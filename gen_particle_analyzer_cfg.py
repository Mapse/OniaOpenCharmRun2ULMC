import FWCore.ParameterSet.Config as cms
import FWCore.ParameterSet.VarParsing as VarParsing
import FWCore.Utilities.FileUtils as FileUtils

# VarParsing
options = VarParsing.VarParsing('analysis')
options.register('outFile', 
                    'test.root', 
                    VarParsing.VarParsing.multiplicity.singleton, 
                    VarParsing.VarParsing.varType.string, 
                    'name of the out file')
options.register('inFile', 
                    '', 
                    VarParsing.VarParsing.multiplicity.singleton, 
                    VarParsing.VarParsing.varType.string, 
                    'name of the in file')

options.parseArguments()

process = cms.Process("GenParticleAnalyzer")

## Phase 2
from Configuration.Eras.Era_Phase2C8_timing_layer_bar_cff import Phase2C8_timing_layer_bar
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')

## Global tag for 10.6 phase2 mc
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '106X_upgrade2023_realistic_v2', '')

process.options   = cms.untracked.PSet( wantSummary = cms.untracked.bool(True) )

process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )

#mylist = FileUtils.loadListFromFile(options.inFile)

process.source = cms.Source(
    "PoolSource",
    fileNames  = cms.untracked.vstring("file:UpsilonToMuMuDzero_13TeV_GS.root"),
    #fileNames  = cms.untracked.vstring(*mylist),
    duplicateCheckMode = cms.untracked.string('noDuplicateCheck')
)


## Show GenParticlesls
process.load("SimGeneral.HepPDTESSource.pythiapdt_cfi")

process.genparticleana = cms.EDAnalyzer(
    'GenParticleAnalyzer',
    outFile = cms.string(options.outFile),
)

process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '106X_upgrade2023_realistic_v2', '')

# Path and endpath to run the producer and output modules
process.p =  cms.Path(process.genparticleana)
