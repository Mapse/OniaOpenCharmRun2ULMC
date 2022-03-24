
### 2018 Fragment

## Steps: https://twiki.cern.ch/twiki/bin/viewauth/CMS/PdmVLegacy2018Analysis

# Path to gs frameng
path_gs=Configuration/GenProduction/python/Jpsi_Dstar_new_accept_cuts_13TeV_cfi.py
# Number of events for gs step
nevt=100000
# GS cfg fragment 
py_gs=Jpsi_Dstar_DPS_2018_13TeV_GS_cfg.py
# For MC Gen parameters 
REPORT_NAME=Jpsi_Dstar_DPS_2018_13TeV_GS_report.xml
# DR cfg fragment
py_dr=Jpsi_Dstar_DPS_2018_13TeV_DR_cfg.py
# HLT cfg fragment
py_hlt=Jpsi_Dstar_DPS_2018_13TeV_HLT_cfg.py
# AOD cfg fragment
py_aod=Jpsi_Dstar_DPS_2018_13TeV_AOD_cfg.py

## Root files

# GS root
root_gs=Jpsi_Dstar_DPS_2018_13TeV_GS.root
# DR root
root_dr=Jpsi_Dstar_DPS_2018_13TeV_DR.root
# HLT root
root_hlt=Jpsi_Dstar_DPS_2018_13TeV_HLT.root
# AOD root
root_aod=Jpsi_Dstar_DPS_2018_13TeV_AOD.root

# CmsDriver for GS step
cmsDriver.py $path_gs --fileout file:$root_gs --mc --eventcontent RAWSIM --runUnscheduled --datatier GEN-SIM --conditions 106X_upgrade2018_realistic_v15_L1v1 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --customise Configuration/DataProcessing/Utils.addMonitoring --nThreads 1 --geometry DB:Extended --era Run2_2018 --python_filename $py_gs -n $nevt --no_exec
#cp $py_gs GS/config/

cmsRun -e -j $REPORT_NAME $py_gs

# Cmsdriver for DR step - with pileup
cmsDriver.py --filein file:$root_gs --fileout file:$root_dr --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer20ULPrePremix-UL18_106X_upgrade2018_realistic_v11_L1v1-v2/PREMIX" --mc --eventcontent PREMIXRAW --runUnscheduled --datatier GEN-SIM-DIGI --conditions 106X_upgrade2018_realistic_v15_L1v1 --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2 --nThreads 1 --geometry DB:Extended --datamix PreMix --era Run2_2018 --python_filename $py_dr -n 1 --no_exec

cmsRun $py_dr

cp $py_dr DR/ && cp $root_dr ../../CMSSW_10_2_16_UL/src/HLT && cd ../../CMSSW_10_2_16_UL/src/HLT

cmsenv

# Cmsdriver for HLT step
cmsDriver.py --filein file:$root_dr --fileout file:$root_hlt --mc --eventcontent RAWSIM --datatier GEN-SIM-RAW --conditions 102X_upgrade2018_realistic_v15 --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' --step HLT:2018v32 --nThreads 1 --geometry DB:Extended --era Run2_2018 --python_filename $py_hlt -n 1 —no_exec

cmsRun $py_hlt

cp $root_hlt ../../../CMSSW_10_6_20/src/ && cd ../../../CMSSW_10_6_20/src/

cmsenv

# Cmsdriver for AOD step
cmsDriver.py --filein file:$root_hlt --fileout file:$root_aod --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 106X_upgrade2018_realistic_v15_L1v1 --step RAW2DIGI,L1Reco,RECO,RECOSIM,EI --nThreads 1 --geometry DB:Extended --era Run2_2018 --python_filename $py_aod -n 1 --no_exec

cmsRun $py_aod

cp $py_aod AOD/

