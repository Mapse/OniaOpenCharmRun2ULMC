# Configuration file for run Monte Carlo events for J/Psi + Open charms (D0, D+, D_s+, Lambda_c+)



########################################## INSTRUCTIONS!!! ######################################################
######################################### READ ME!!!!!!!!!!!!!!!!!!!!!!!! #######################################

# Set the variables on mcConfig.sh!
# For LHCb phase space region at 7 TeV set EN=7, for CMS phase space region at 13 Tev set EN=13.
# You need to organize your folders properly. For each simulation we have two different folders:

# Folder 1: Path for the cff (fragment file).
# Ex: Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDzero_7TeV.py

# Folder 2: Path for root file and Gen sim fragment.
# Ex: Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDzero_TeV_GS.root
# Ex: Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDZero_7TeV_GS.py

# Ways to run the configuration file:

#. genSim.sh
# sh genSim.sh

# Any questions? 
# Fell free to contact-me: mapse.b@cern.ch.

########################################## END OF THE INSTRUCTIONS ###################################################3

# Data parser
. Thesis/mcConfig.sh

# Starts CMS enviroment on lxplus.
cmsenv


if [[ "$MonteCarlo_particle" == "" ]]; then

   echo -e " \n \n ############################################### ERROR ##################################################                   
   \nYou have to set the variable PARTICLE  !!!!! "

fi

if [[ "$MonteCarlo_numevts" == "" ]]; then

   echo -e " \n \n ############################################### ERROR ##################################################                   
   \nYou have to set the variable NEV (number of events to be computed)  !!!!! "

fi

if [[ "$MonteCarlo_energy" == "7TeV" ]]; then

   if [[ "$MonteCarlo_particle" != "" ]]; then
      echo -e " \n \n --------------------- Fragment for LHCb kinematic region at 7 TeV -----------------------"                   
   fi

   # Runs Monte Carlo for production of J/Psi meson associated with D0 meson.
   if [[ "$MonteCarlo_particle" == "D0" ]] || [[ "$MonteCarlo_particle" == "Dzero" ]] || [[ "$MonteCarlo_particle" == "DZero" ]] || [[ "$MonteCarlo_particle" == "d0" ]] || [[ "$MonteCarlo_particle" == "dzero" ]]; then
      # Changes the bash name (just for organization)
      PS1='[\u@\h \W]\ D0 Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for D0 meson --------------------------"                   

      # Generates the fragment for Ultra legacy Monte Carlo 2017.
      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDzero_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDzero_TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDZero_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      # Generates events and gives filter efficency and cross sections
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDZero_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D+ meson.
   elif [[ "$MonteCarlo_particle" == "D+" ]] || [[ "$MonteCarlo_particle" == "Dplus" ]] || [[ "$MonteCarlo_particle" == "DPlus" ]] || [[ "$MonteCarlo_particle" == "d+" ]] || [[ "$MonteCarlo_particle" == "dplus" ]]; then
      
      PS1='[\u@\h \W]\ D+ Simulation: $'

      echo -e " \n \n -------------------------- Running fragment for D+ meson --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D_s+ meson.
   elif [[ "$MonteCarlo_particle" == "D_s+" ]] || [[ "$MonteCarlo_particle" == "Dsplus" ]] || [[ "$MonteCarlo_particle" == "DSPlus" ]] || [[ "$MonteCarlo_particle" == "DSplus" ]] || [[ "$MonteCarlo_particle" == "D_S+" ]] || [[ "$MonteCarlo_particle" == "D_splus" ]] || [[ "$MonteCarlo_particle" == "D_sPlus" ]] || [[ "$MonteCarlo_particle" == "ds+" ]] || [[ "$MonteCarlo_particle" == "d_s+" ]] || [[ "$MonteCarlo_particle" == "d_splus" ]] || [[ "$MonteCarlo_particle" == "Ds+" ]]; then
      
      PS1='[\u@\h \W]\ D_s+ Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for D_s+ meson --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with Lambda_c+ meson.
   elif [[ "$MonteCarlo_particle" == "Lambda_c+" ]] || [[ "$MonteCarlo_particle" == "lambda_c+" ]] || [[ "$MonteCarlo_particle" == "Lambda_C+" ]] || [[ "$MonteCarlo_particle" == "Lambda_Cplus" ]] || [[ "$MonteCarlo_particle" == "Lambda_CPlus" ]] || [[ "$MonteCarlo_particle" == "Lambdac+" ]] || [[ "$MonteCarlo_particle" == "lambdac+" ]] || [[ "$MonteCarlo_particle" == "LambdaC+" ]] || [[ "$MonteCarlo_particle" == "lambdaC+" ]]; then
      
      PS1='[\u@\h \W]\ Lambda_c+ Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for Lambda_c+ barion --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithLambdaCPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdac_TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdaCPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdaCPlus_7TeV_GS.py
   
   fi

elif [[ "$MonteCarlo_energy" == "13TeV" ]]; then

   if [[ "$MonteCarlo_particle" != "" ]]; then
      echo -e " \n \n --------------------- Fragment for CMS kinematic region at 13 TeV -----------------------"                   
   fi

   # Runs Monte Carlo for production of J/Psi meson associated with D0 meson.
   if [[ "$MonteCarlo_particle" == "D0" ]] || [[ "$MonteCarlo_particle" == "Dzero" ]] || [[ "$MonteCarlo_particle" == "DZero" ]] || [[ "$MonteCarlo_particle" == "d0" ]] || [[ "$MonteCarlo_particle" == "dzero" ]]; then
      # Changes the bash name (just for organization)
      PS1='[\u@\h \W]\ D0 Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for D0 meson --------------------------"

      # Generates the fragment for Ultra legacy Monte Carlo 2017.
      cmsDriver.py Thesis/MonteCarlo/python/ThirteenTeVFrag/JpsiToMuMuwithDzero_13TeV.py --fileout file:JpsiToMuMuwithDZero_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDZero_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      # Generates events and gives filter efficency and cross sections
      cmsRun JpsiToMuMuwithDZero_13TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D+ meson.
   elif [[ "$MonteCarlo_particle" == "D+" ]] || [[ "$MonteCarlo_particle" == "Dplus" ]] || [[ "$MonteCarlo_particle" == "DPlus" ]] || [[ "$MonteCarlo_particle" == "d+" ]] || [[ "$MonteCarlo_particle" == "dplus" ]]; then
      PS1='[\u@\h \W]\ D+ Simulation at 13 TeV: $'
      echo -e " \n \n -------------------------- Running fragment for D+ meson --------------------------"
      cmsDriver.py Thesis/MonteCarlo/python/ThirteenTeVFrag/JpsiToMuMuwithDPlus_13TeV.py --fileout file:JpsiToMuMuwithDPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithDPlus_13TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D_s+ meson.
   elif [[ "$MonteCarlo_particle" == "D_s+" ]] || [[ "$MonteCarlo_particle" == "Dsplus" ]] || [[ "$MonteCarlo_particle" == "DSPlus" ]] || [[ "$MonteCarlo_particle" == "DSplus" ]] || [[ "$MonteCarlo_particle" == "D_S+" ]] || [[ "$MonteCarlo_particle" == "D_splus" ]] || [[ "$MonteCarlo_particle" == "D_sPlus" ]] || [[ "$MonteCarlo_particle" == "ds+" ]] || [[ "$MonteCarlo_particle" == "d_s+" ]] || [[ "$MonteCarlo_particle" == "d_splus" ]] || [[ "$MonteCarlo_particle" == "Ds+" ]]; then
      PS1='[\u@\h \W]\ D_s+ Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for D_s+ meson --------------------------"
      cmsDriver.py Thesis/MonteCarlo/python/ThirteenTeVFrag/JpsiToMuMuwithDSPlus_13TeV.py --fileout file:JpsiToMuMuwithDSPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v8 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDSPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithDSPlus_13TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with Lambda_c+ meson.
   elif [[ "$MonteCarlo_particle" == "Lambda_c+" ]] || [[ "$MonteCarlo_particle" == "lambda_c+" ]] || [[ "$MonteCarlo_particle" == "Lambda_C+" ]] || [[ "$MonteCarlo_particle" == "Lambda_Cplus" ]] || [[ "$MonteCarlo_particle" == "Lambda_CPlus" ]] || [[ "$MonteCarlo_particle" == "Lambdac+" ]] || [[ "$MonteCarlo_particle" == "lambdac+" ]] || [[ "$MonteCarlo_particle" == "LambdaC+" ]] || [[ "$MonteCarlo_particle" == "lambdaC+" ]]; then
      PS1='[\u@\h \W]\ Lambda_c+ Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for Lambda_c+ meson --------------------------"
      cmsDriver.py Thesis/MonteCarlo/python/ThirteenTeVFrag/JpsiToMuMuwithLambdaCPlus_13TeV.py --fileout file:JpsiToMuMuwithLambdac_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithLambdaCPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithLambdaCPlus_13TeV_GS.py
   
   fi

else
  
  echo -e " \n \n ############################################### ERROR ##################################################                   
  \nYou have to set the variable ENV  !!!!! "
                                                                           
fi