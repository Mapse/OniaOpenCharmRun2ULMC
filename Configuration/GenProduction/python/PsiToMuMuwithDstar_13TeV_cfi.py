import FWCore.ParameterSet.Config as cms
from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.Pythia8CUEP8M1Settings_cfi import * # Underlying Event(UE) 
from GeneratorInterface.EvtGenInterface.EvtGenSetting_cff import *

generator = cms.EDFilter("Pythia8GeneratorFilter",
                         pythiaPylistVerbosity = cms.untracked.int32(0), # If 0: particle has no open decay channels
                         pythiaHepMCVerbosity = cms.untracked.bool(False),
                         comEnergy = cms.double(13000.0),
                         maxEventsToPrint = cms.untracked.int32(0),
                         ExternalDecays = cms.PSet(
                         EvtGen130 = cms.untracked.PSet(
                         #uses latest evt and decay tables from evtgen 1.6
                         decay_table = cms.string('GeneratorInterface/EvtGenInterface/data/DECAY_2014_NOLONGLIFE.DEC'),
                         particle_property_file = cms.FileInPath('GeneratorInterface/EvtGenInterface/data/evt_2014.pdl'),
                         convertPythiaCodes = cms.untracked.bool(False),
                         list_forced_decays = cms.vstring('MyD0', 'Myanti-D0'), 
                         operates_on_particles = cms.vint32(10043, 413, -413, 421, -421),
                         user_decay_embedded= cms.vstring(
"""

Alias      MyD0        D0
Alias      Myanti-D0   anti-D0
ChargeConj MyD0 Myanti-D0

Decay MyD0
  1.000        K-      pi+              PHSP;
Enddecay
CDecay Myanti-D0


End
"""
                          ),
                ),
                parameterSets = cms.vstring('EvtGen130')
        ),
        PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CUEP8M1SettingsBlock,
        processParameters = cms.vstring(
            'Main:timesAllowErrors = 10000',  
            'HardQCD:hardccbar = on', # Sum of gg -> ccbar with qqbar ->ccbar
            'HardQCD:gg2gg = on',
            'HardQCD:qg2qg = on',
            'PartonLevel:MPI = on',
            'SecondHard:Charmonium = on',
            'SecondHard:generate = on',
            'PhaseSpace:pTHatMin = 4.0',
            'PhaseSpace:pTHatMinSecond = 4.0',
            'PhaseSpace:pTHatMinDiverge = 0.4',
            ),
        parameterSets = cms.vstring('pythia8CommonSettings',
                                    'pythia8CUEP8M1Settings',
                                    'processParameters',
                                    )
        )
                         )

generator.PythiaParameters.processParameters.extend(EvtGenExtraParticles)
###########
# Filters #
###########
# Filter only pp events which produce JPsi
psifilter = cms.EDFilter("PythiaFilter", 
    ParticleID = cms.untracked.int32(10043),
    MinPt           = cms.untracked.double(0.0),
    MinEta          = cms.untracked.double(-500.),
    MaxEta          = cms.untracked.double(500.)
)

# Dimuon filter
mumufilter = cms.EDFilter("MCParticlePairFilter",
    Status = cms.untracked.vint32(1, 1),
    MinP = cms.untracked.vdouble(2.7, 2.7),
    MinPt = cms.untracked.vdouble(0.1, 0.1),
    MaxPt = cms.untracked.vdouble(200, 200),
    MaxEta = cms.untracked.vdouble(2.5, 2.5),
    MinEta = cms.untracked.vdouble(-2.5, -2.5),
    ParticleCharge = cms.untracked.int32(-1),
    ParticleID1 = cms.untracked.vint32(13),
    ParticleID2 = cms.untracked.vint32(13)
)

# Filter for D* -> D0(kaonPion) pionslow 

DstarFilter = cms.EDFilter("PythiaMomDauFilter",
    ParticleID = cms.untracked.int32(413),
    DaughterID = cms.untracked.int32(421),
    ChargeConjugation = cms.untracked.bool(True),
    MinEta = cms.untracked.double(-500.),
    MaxEta = cms.untracked.double(500.),
    DaughterIDs = cms.untracked.vint32(421,211),
    NumberDaughters = cms.untracked.int32(2),
    NumberDescendants = cms.untracked.int32(2),
    DescendantsIDs = cms.untracked.vint32(-321,211)
)

ProductionFilterSequence = cms.Sequence(generator*psifilter*mumufilter*DstarFilter)