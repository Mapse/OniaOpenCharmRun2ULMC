
### 2018 Fragment

## Path to gs fragment
path_gs=Configuration/GenProduction/python/Jpsi_100to150_Dstar_DPS_2018_13TeV_cfi.py
# Number of events for gs step
nevt=600000
# GS cfg fragment 
py_gs=Jpsi_100to150_Dstar_DPS_2018_13TeV_GS_cfg_report.py
# For MC Gen parameters 
REPORT_NAME=Jpsi_100to150_Dstar_DPS_2018_13TeV_GS_report.xml
## Root files

# GS root
root_gs=Jpsi_100to150_Dstar_DPS_2018_13TeV_GS_report.root

# CmsDriver for GS step
cmsDriver.py $path_gs --fileout file:$root_gs --mc --eventcontent RAWSIM --datatier GEN --conditions 106X_upgrade2018_realistic_v15_L1v1 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN --customise Configuration/DataProcessing/Utils.addMonitoring --nThreads 1 --geometry DB:Extended --era Run2_2018 --python_filename $py_gs -n $nevt --no_exec

cmsRun -e -j $REPORT_NAME $py_gs
