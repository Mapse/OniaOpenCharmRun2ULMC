#CMSW path: /afs/cern.ch/work/m/mabarros/CMSSW_10_2_15_patch1/src/Configuration/GenProduction/python


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
                         list_forced_decays = cms.vstring('MyJpsi', 'MyD+'), 
                         operates_on_particles = cms.vint32(443,411),
                         user_decay_embedded= cms.vstring(
"""
Alias      MyD+        D+

Alias      MyJpsi      J/psi


Decay MyJpsi
  1.000        mu+     mu-       PHOTOS   VLL;
Enddecay

Decay MyD+
  1.000        K-      pi+      pi+     D_DALITZ;
Enddecay

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
            'HardQCD:hardccbar = on',
            'HardQCD:gg2gg = on'
            'PartonLevel:MPI = on',
            'SecondHard:Charmonium = on',
            'SecondHard:generate = on',
            #'StringFlav:mesonCvector = 1.4',
            'PhaseSpace:pTHatMin = 4.5',
            'PhaseSpace:pTHatMinSecond = 4.5',
            'PhaseSpace:pTHatMinDiverge = 0.1',
            '443:onMode = off',
            #'421:onMode = off',
            '411:onMode = off',
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
# Filter only pp events which produce JPsi
#bufilter1 = cms.EDFilter("PythiaFilter", ParticleID = cms.untracked.int32(443)) #OBS: I tried to put 2 particles but it went wrong.
#jpsifilter = cms.EDFilter("MCSingleParticleFilter",
#    Status = cms.untracked.vint32(2),
#    MinPt = cms.untracked.vdouble(20.0),
#    MaxPt = cms.untracked.vdouble(130.),
#    MaxEta = cms.untracked.vdouble(1.2),
#    MinEta = cms.untracked.vdouble(-1.2),
#    ParticleID = cms.untracked.vint32(443)
#)
jpsifilter = cms.EDFilter(
    "PythiaDauVFilter",
    verbose         = cms.untracked.int32(1),
    NumberDaughters = cms.untracked.int32(2),
    #MotherID        = cms.untracked.int32(541),
    ParticleID      = cms.untracked.int32(443),
    DaughterIDs     = cms.untracked.vint32(13, -13),
    MinPt           = cms.untracked.vdouble(1., 1.),
    MinEta          = cms.untracked.vdouble(-2.7, -2.7),
    MaxEta          = cms.untracked.vdouble( 2.7,  2.7)
) 
# Filter only pp events which produce D+-
#dPlusfilter = cms.EDFilter("MCParticlePairFilter",
#      Status = cms.untracked.vint32(2,2),
#      MinPt = cms.untracked.vdouble(4.0, 4.0),
#      MaxPt = cms.untracked.vdouble(100.0, 100.0),
#      MaxEta = cms.untracked.vdouble(2.1, 2.1),
#      MinEta = cms.untracked.vdouble(-2.1, -2.1),
#      ParticleID = cms.untracked.vint32(411, -411)
#) 

# Filter on final state muons
#mumugenfilter = cms.EDFilter("MCParticlePairFilter",
#                             Status = cms.untracked.vint32(1, 1),
#                             MinPt = cms.untracked.vdouble(4.5, 4.5),
#                             MaxEta = cms.untracked.vdouble(1.4, 1.4),
#                             MinEta = cms.untracked.vdouble(-1.4, -1.4),
#                             ParticleID1 = cms.untracked.vint32(13,-13),
#                             ParticleID2 = cms.untracked.vint32(13,-13)
#                             )

ProductionFilterSequence = cms.Sequence(generator*jpsifilter)#*dPlusfilter*mumugenfilter)
