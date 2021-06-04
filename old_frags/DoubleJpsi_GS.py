# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: Configuration/GenProduction/python/DoubleJpsi_cfi.py --fileout file:DoubleJpsi_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename DoubleJpsi_GS.py --no_exec -n 10000
import FWCore.ParameterSet.Config as cms

from Configuration.Eras.Era_Run2_2017_cff import Run2_2017

process = cms.Process('SIM',Run2_2017)

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.GeometrySimDB_cff')
process.load('Configuration.StandardSequences.MagneticField_cff')
process.load('Configuration.StandardSequences.Generator_cff')
process.load('IOMC.EventVertexGenerators.VtxSmearedRealistic25ns13TeVEarly2018Collision_cfi')
process.load('GeneratorInterface.Core.genFilterSummary_cff')
process.load('Configuration.StandardSequences.SimIdeal_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(10000)
)

# Input source
process.source = cms.Source("EmptySource")

process.options = cms.untracked.PSet(

)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    annotation = cms.untracked.string('Configuration/GenProduction/python/DoubleJpsi_cfi.py nevts:10000'),
    name = cms.untracked.string('Applications'),
    version = cms.untracked.string('$Revision: 1.19 $')
)

# Output definition

process.RAWSIMoutput = cms.OutputModule("PoolOutputModule",
    SelectEvents = cms.untracked.PSet(
        SelectEvents = cms.vstring('generation_step')
    ),
    compressionAlgorithm = cms.untracked.string('LZMA'),
    compressionLevel = cms.untracked.int32(1),
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('GEN-SIM'),
        filterName = cms.untracked.string('')
    ),
    eventAutoFlushCompressedSize = cms.untracked.int32(20971520),
    fileName = cms.untracked.string('file:DoubleJpsi_GS.root'),
    outputCommands = process.RAWSIMEventContent.outputCommands,
    splitLevel = cms.untracked.int32(0)
)

# Additional output definition

# Other statements
process.XMLFromDBSource.label = cms.string("Extended")
process.genstepfilter.triggerConditions=cms.vstring("generation_step")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '102X_mc2017_realistic_v7', '')

process.jpsifilter = cms.EDFilter("MCSingleParticleFilter",
    MaxEta = cms.untracked.vdouble(3.0),
    MinEta = cms.untracked.vdouble(-3.0),
    MinPt = cms.untracked.vdouble(2.0),
    ParticleID = cms.untracked.vint32(443),
    Status = cms.untracked.vint32(2)
)


process.likemufilter = cms.EDFilter("MCParticlePairFilter",
    MaxEta = cms.untracked.vdouble(2.5, 2.5),
    MinEta = cms.untracked.vdouble(-2.5, -2.5),
    MinPt = cms.untracked.vdouble(1.0, 1.0),
    ParticleCharge = cms.untracked.int32(1),
    ParticleID1 = cms.untracked.vint32(13),
    ParticleID2 = cms.untracked.vint32(13),
    Status = cms.untracked.vint32(1, 1)
)


process.generator = cms.EDFilter("Pythia8GeneratorFilter",
    PythiaParameters = cms.PSet(
        parameterSets = cms.vstring('processParameters'),
        processParameters = cms.vstring(
            'Main:timesAllowErrors = 10000', 
            'Charmonium:all = on', 
            'PartonLevel:MPI = on', 
            'SecondHard:generate = on', 
            'SecondHard:Charmonium = on', 
            'PhaseSpace:pTHatMin = 3.0', 
            'PhaseSpace:pTHatMinSecond = 3.0', 
            'PhaseSpace:pTHatMinDiverge = 0.5', 
            '445:onMode = off', 
            '445:onIfAny = 443 22', 
            '10441:onMode = off', 
            '10441:onIfAny = 443 22', 
            '20443:onMode = off', 
            '20443:onIfAny = 443 22', 
            '9940003:onMode = off', 
            '9940003:onIfAny = 443 21', 
            '9941003:onMode = off', 
            '9941003:onIfAny = 443 21', 
            '9942003:onMode = off', 
            '9942003:onIfAny = 443 21', 
            '443:onMode = off', 
            '443:onIfAny = -13 13', 
            'Tune:pp 5'
        )
    ),
    comEnergy = cms.double(13000.0),
    crossSection = cms.untracked.double(0.0001755),
    filterEfficiency = cms.untracked.double(0.000416),
    maxEventsToPrint = cms.untracked.int32(0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    pythiaPylistVerbosity = cms.untracked.int32(1)
)


process.dimufilter = cms.EDFilter("MCParticlePairFilter",
    MaxEta = cms.untracked.vdouble(2.5, 2.5),
    MinEta = cms.untracked.vdouble(-2.5, -2.5),
    MinPt = cms.untracked.vdouble(1.0, 1.0),
    ParticleCharge = cms.untracked.int32(-1),
    ParticleID1 = cms.untracked.vint32(13),
    ParticleID2 = cms.untracked.vint32(13),
    Status = cms.untracked.vint32(1, 1)
)


process.ProductionFilterSequence = cms.Sequence(process.generator+process.jpsifilter+process.dimufilter+process.likemufilter)

# Path and EndPath definitions
process.generation_step = cms.Path(process.pgen)
process.simulation_step = cms.Path(process.psim)
process.genfiltersummary_step = cms.EndPath(process.genFilterSummary)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.RAWSIMoutput_step = cms.EndPath(process.RAWSIMoutput)

# Schedule definition
process.schedule = cms.Schedule(process.generation_step,process.genfiltersummary_step,process.simulation_step,process.endjob_step,process.RAWSIMoutput_step)
from PhysicsTools.PatAlgos.tools.helpers import associatePatAlgosToolsTask
associatePatAlgosToolsTask(process)
# filter all path with the production filter sequence
for path in process.paths:
	getattr(process,path).insert(0, process.ProductionFilterSequence)


# Customisation from command line

# Add early deletion of temporary data products to reduce peak memory need
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
process = customiseEarlyDelete(process)
# End adding early deletion
