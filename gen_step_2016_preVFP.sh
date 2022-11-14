
### 2016 Fragment - pre FVP

## Path to gs fragment
path_gs=Configuration/GenProduction/python/Jpsi_100to150_Dstar_DPS_2016_13TeV_cfi.py

# Number of events for gs step
nevt=600000
# GS cfg fragment 
py_gs=Jpsi_100to150_Dstar_DPS_2016preVFP_13TeV_GS_cfg_report.py
# For MC Gen parameters 
REPORT_NAME=Jpsi_100to150_Dstar_DPS_2016preVFP_13TeV_GS_report.xml
## Root files

# GS root
root_gs=Jpsi_100to150_Dstar_DPS_2016preVFP_13TeV_GS_report.root

# CmsDriver for GS step
cmsDriver.py $path_gs --fileout file:$root_gs --mc --eventcontent RAWSIM --datatier GEN --conditions 106X_mcRun2_asymptotic_preVFP_v9 --beamspot Realistic25ns13TeV2016Collision --step GEN --customise Configuration/DataProcessing/Utils.addMonitoring --nThreads 1 --geometry DB:Extended --era Run2_2016 --python_filename $py_gs -n $nevt --no_exec

cmsRun -e -j $REPORT_NAME $py_gs
