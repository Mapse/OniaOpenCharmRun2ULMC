import FWCore.ParameterSet.Config as cms
from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.Pythia8CUEP8M1Settings_cfi import * # Underlying Event(UE) 
from GeneratorInterface.EvtGenInterface.EvtGenSetting_cff import *

generator = cms.EDFilter("Pythia8GeneratorFilter",
                         pythiaPylistVerbosity = cms.untracked.int32(0), # If 0: particle has no open decay channels
                         pythiaHepMCVerbosity = cms.untracked.bool(False),
                         comEnergy = cms.double(7000.0),
                         maxEventsToPrint = cms.untracked.int32(0),
                         ExternalDecays = cms.PSet(
                         EvtGen130 = cms.untracked.PSet(
                         #uses latest evt and decay tables from evtgen 1.6
                         decay_table = cms.string('GeneratorInterface/EvtGenInterface/data/DECAY_2014_NOLONGLIFE.DEC'),
                         particle_property_file = cms.FileInPath('GeneratorInterface/EvtGenInterface/data/evt_2014.pdl'),
                         convertPythiaCodes = cms.untracked.bool(False),
                         #user_decay_file = cms.vstring('GeneratorInterface/ExternalDecays/data/Bu_Kstarmumu_Kspi.dec'),
                         #content was dump in the embed string below. This should test this feature.
                         list_forced_decays = cms.vstring('MyUpsilon','MyD+','MyD-'), 
                         operates_on_particles = cms.vint32(553,411,-411),
                         user_decay_embedded= cms.vstring(
"""
Alias      MyD+   D+
Alias      MyD-   D-
ChargeConj MyD+ MyD-

Alias MyUpsilon Upsilon

Decay MyUpsilon
  1.000        mu+     mu-       PHOTOS   VLL;
Enddecay

Decay MyD+
  1.000        K-      pi+      pi+     D_DALITZ;
Enddecay
CDecay MyD-

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
            #'Main:timesAllowErrors = 10000',  
	        'HardQCD:hardccbar = on',
            'HardQCD:gg2gg = on',
            'PartonLevel:MPI = on',
            'SecondHard:Bottomonium = on',
            'SecondHard:generate = on',
            #'StringFlav:mesonCvector = 1.4',
            'PhaseSpace:pTHatMin = 4.5',
            'PhaseSpace:pTHatMinSecond = 4.5',
            'PhaseSpace:pTHatMinDiverge = 0.5',
            '413:onMode = off'
            #'443:onMode = off',
            #'421:onMode = off',
            #'411:onMode = off',
            #'431:onMode = off',
            #'4122:onMode = off'
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
# Filter only pp events which produce Upsilon (1S)

upsilonfilter = cms.EDFilter("PythiaFilter", 
    ParticleID = cms.untracked.int32(553),
    MaxPt           = cms.untracked.double(15.0),
    MinEta          = cms.untracked.double(2.0),
    MaxEta          = cms.untracked.double(4.5)
)

dplusfilter = cms.EDFilter("MCSingleParticleFilter",
    ParticleID = cms.untracked.vint32(411, -411),
    MinPt           = cms.untracked.vdouble(1.0 ,1.0),
    MaxPt           = cms.untracked.vdouble(20.0, 20.0),
    MinEta          = cms.untracked.vdouble(2.0, 2.0),
    MaxEta          = cms.untracked.vdouble(4.5, 4.5)
)

upsilondaufilter = cms.EDFilter(
    "PythiaDauVFilter",
    verbose         = cms.untracked.int32(1),
    NumberDaughters = cms.untracked.int32(2),
    #MotherID        = cms.untracked.int32(541),
    ParticleID      = cms.untracked.int32(553),
    DaughterIDs     = cms.untracked.vint32(13, -13),
    MinPt           = cms.untracked.vdouble(1.0, 1.0),
    MaxPt           = cms.untracked.double(25.0),
    MinP            = cms.untracked.vdouble(10.0, 10.0),
    MaxP            = cms.untracked.vdouble(400.0, 400.0),
    MinEta          = cms.untracked.vdouble(2.0, 2.0),
    MaxEta          = cms.untracked.vdouble(4.5, 4.5)
)

dplusdaufilter = cms.EDFilter(
    "PythiaDauVFilter",
    verbose         = cms.untracked.int32(1),
    NumberDaughters = cms.untracked.int32(3),
    #MotherID        = cms.untracked.int32(541),
    ParticleID      = cms.untracked.int32(411),
    DaughterIDs     = cms.untracked.vint32(-321, 211, 211),
    MinPt           = cms.untracked.vdouble(0.25, 0.25, 0.25),
    MinP            = cms.untracked.vdouble(3.2, 3.2, 3.2),
    MaxP            = cms.untracked.vdouble(100.0, 100.0, 100.0),
    MinEta          = cms.untracked.vdouble(2.0, 2.0, 2.0),
    MaxEta          = cms.untracked.vdouble(5.0, 5.0, 2.0)
)

ProductionFilterSequence = cms.Sequence(generator*upsilonfilter*dplusfilter*upsilondaufilter*dplusdaufilter)
