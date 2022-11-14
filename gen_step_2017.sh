
### 2017 Fragment

## Path to gs frameng
#path_gs=Configuration/GenProduction/python/Jpsi_40to100_Dstar_13TeV_cfi.py
path_gs=Configuration/GenProduction/python/Jpsi_10to30_Dstar_DPS_13TeV_cfi.py
# Number of events for gs step
nevt=100000
# GS cfg fragment 
py_gs=Jpsi_10to30_Dstar_DPS_2017_13TeV_cfg.py
# For MC Gen parameters 
REPORT_NAME=Jpsi_10to30_Dstar_DPS_2017_13TeV_report.xml
## Root files

# GS root
root_gs=Jpsi_10to30_Dstar_DPS_2017_13TeV.root

# CmsDriver for GS step
cmsDriver.py $path_gs --fileout file:$root_gs --mc --eventcontent RAWSIM --datatier GEN --conditions 106X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN --customise Configuration/DataProcessing/Utils.addMonitoring --geometry DB:Extended --era Run2_2017 --python_filename $py_gs -n $nevt --no_exec

cmsRun -e -j $REPORT_NAME $py_gs
