# MC Onia + Open Charm

Repository for Private MC generation for Onia + Open Charm Analysis (in construction).

## Setting the environment:

```
export SCRAM_ARCH=slc7_amd64_gcc700

cmsrel CMSSW_10_6_12
cd CMSSW_10_6_12/src
cmsenv

git clone git@github.com:kevimota/OniaOpenCharmRun2ULMC.git .

scram b
```

## cmsDriver commands

### Data 2017

* GEN,SIM step:
Dzero:
```
cmsDriver.py Configuration/GenProduction/python/UpsilonToMuMuDzero_13TeV_cfi.py --fileout file:UpsilonToMuMuDzero_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename UpsilonToMuMuDzero_GS_cfg.py -n 5000  --no_exec
```

Dplus:
```
cmsDriver.py Configuration/GenProduction/python/UpsilonToMuMuDplus_13TeV_cfi.py --fileout file:UpsilonToMuMuDplus_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename UpsilonToMuMuDplus_GS_cfg.py -n 5000  --no_exec
```

#### To update:

* DIGI (premix):
```
cmsDriver.py step3 --filein file:SIM.root --fileout file:DIGIPremix.root  --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer19ULPrePremix-UL17_106X_mc2017_realistic_v6-v1/PREMIX" --mc --eventcontent PREMIXRAW --runUnscheduled --datatier GEN-SIM-DIGI --conditions 106X_mc2017_realistic_v6 --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2 --nThreads 8 --geometry DB:Extended --datamix PreMix --era Run2_2017 --python_filename DIGIPremix_2017_cfg.py -n 10 --no_exec
```

* HLT step:
```
cmsDriver.py step4 --filein file:DIGIPremix.root --fileout file:HLT.root --mc --eventcontent RAWSIM --datatier GEN-SIM-RAW --conditions 94X_mc2017_realistic_v15 --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' --step HLT:2e34v40 --nThreads 8 --geometry DB:Extended --era Run2_2017 --python_filename HLT_2017_cfg.py -n 10 --no_exec
```

* RECO step:
```
cmsDriver.py step5 --filein file:HLT.root --fileout file:RECO.root --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 106X_mc2017_realistic_v6 --step RAW2DIGI,L1Reco,RECO,RECOSIM --nThreads 8 --geometry DB:Extended --era Run2_2017 --python_filename RECO_2017_cfg.py -n 10 --no_exec
```

* MiniAOD step:
```
cmsDriver.py step6 --filein file:RECO.root --fileout file:MiniAOD.root --mc --eventcontent MINIAODSIM --runUnscheduled --datatier MINIAODSIM --conditions 106X_mc2017_realistic_v6 --step PAT --nThreads 8 --geometry DB:Extended --era Run2_2017 --python_filename MINIAOD_2017_cfg.py -n 10 --no_exec
```

* NanoAOD step:
```
cmsDriver.py step7 --filein file:MiniAOD.root --fileout file:NanoAOD.root --mc --eventcontent NANOEDMAODSIM --datatier NANOAODSIM --conditions 106X_mc2017_realistic_v6 --step NANO --nThreads 8 --era Run2_2017 --python_filename NANOAOD_2017_cfg.py -n 10 --no_exec
```
(To create private flat ntuple, please use `--eventcontent NANOAODSIM --datatier NANOAODSIM --customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))"`)

more informations: https://twiki.cern.ch/twiki/bin/view/CMS/PdmVLegacy2017Analysis#
