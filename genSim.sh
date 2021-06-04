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
# Fell free to contact-me: mapse.b@cern.ch, mapse.b@hotmail.com

########################################## END OF THE INSTRUCTIONS ###################################################3

# Data parser
. mcConfig.sh

# Starts CMS enviroment on lxplus.
cmsenv


if [[ "$MonteCarlo_channel" == "" ]]; then

   echo -e " \n \n ############################################### ERROR ##################################################                   
   \nYou have to set the variable CHANNEL  !!!!! "

fi

if [[ "$MonteCarlo_numevts" == "" ]]; then

   echo -e " \n \n ############################################### ERROR ##################################################                   
   \nYou have to set the variable NEV (number of events to be computed)  !!!!! "

fi

if [[ "$MonteCarlo_energy" == "7TeV" ]]; then

   if [[ "$MonteCarlo_channel" != "" ]]; then
      echo -e " \n \n --------------------- Fragment for LHCb kinematic region at 7 TeV -----------------------"                   
   fi

   # Runs Monte Carlo for production of J/Psi meson associated with D0 meson.
   if [[ "$MonteCarlo_channel" == "D0" ]] || [[ "$MonteCarlo_channel" == "Dzero" ]] || [[ "$MonteCarlo_channel" == "DZero" ]] || [[ "$MonteCarlo_channel" == "d0" ]] || [[ "$MonteCarlo_channel" == "dzero" ]]; then
      # Changes the bash name (just for organization)
      PS1='[\u@\h \W]\ D0 Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for D0 meson --------------------------"                   

      # Generates the fragment for Ultra legacy Monte Carlo 2017.
      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDzero_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDzero_TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDZero_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      # Generates events and gives filter efficency and cross sections
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDZero_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D+ meson.
   elif [[ "$MonteCarlo_channel" == "D+" ]] || [[ "$MonteCarlo_channel" == "Dplus" ]] || [[ "$MonteCarlo_channel" == "DPlus" ]] || [[ "$MonteCarlo_channel" == "d+" ]] || [[ "$MonteCarlo_channel" == "dplus" ]]; then
      
      PS1='[\u@\h \W]\ D+ Simulation: $'

      echo -e " \n \n -------------------------- Running fragment for D+ meson --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with D_s+ meson.
   elif [[ "$MonteCarlo_channel" == "D_s+" ]] || [[ "$MonteCarlo_channel" == "Dsplus" ]] || [[ "$MonteCarlo_channel" == "DSPlus" ]] || [[ "$MonteCarlo_channel" == "DSplus" ]] || [[ "$MonteCarlo_channel" == "D_S+" ]] || [[ "$MonteCarlo_channel" == "D_splus" ]] || [[ "$MonteCarlo_channel" == "D_sPlus" ]] || [[ "$MonteCarlo_channel" == "ds+" ]] || [[ "$MonteCarlo_channel" == "d_s+" ]] || [[ "$MonteCarlo_channel" == "d_splus" ]] || [[ "$MonteCarlo_channel" == "Ds+" ]]; then
      
      PS1='[\u@\h \W]\ D_s+ Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for D_s+ meson --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithDPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithDPlus_7TeV_GS.py
   
   # Runs Monte Carlo for production of J/Psi meson associated with Lambda_c+ baryon.
   elif [[ "$MonteCarlo_channel" == "Lambda_c+" ]] || [[ "$MonteCarlo_channel" == "lambda_c+" ]] || [[ "$MonteCarlo_channel" == "Lambda_C+" ]] || [[ "$MonteCarlo_channel" == "Lambda_Cplus" ]] || [[ "$MonteCarlo_channel" == "Lambda_CPlus" ]] || [[ "$MonteCarlo_channel" == "Lambdac+" ]] || [[ "$MonteCarlo_channel" == "lambdac+" ]] || [[ "$MonteCarlo_channel" == "LambdaC+" ]] || [[ "$MonteCarlo_channel" == "lambdaC+" ]]; then
      
      PS1='[\u@\h \W]\ Lambda_c+ Simulation: $'
      
      echo -e " \n \n -------------------------- Running fragment for Lambda_c+ baryon --------------------------"                   

      cmsDriver.py Thesis/MonteCarlo/python/SevenTeVFrag/JpsiToMuMuwithLambdaCPlus_7TeV.py --fileout file:Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdac_TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdaCPlus_7TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun Thesis/MonteCarlo/GenSimFrags/JpsiToMuMuwithLambdaCPlus_7TeV_GS.py
   
   fi

elif [[ "$MonteCarlo_energy" == "13TeV" ]]; then

   if [[ "$MonteCarlo_channel" != "" ]]; then
      echo -e " \n \n --------------------- Fragment for CMS kinematic region at 13 TeV -----------------------"                   
   fi

   # Runs Monte Carlo for production of JPsi meson associated with D0 meson.
   if [[ "$MonteCarlo_channel" == "JpsiD0" ]] || [[ "$MonteCarlo_channel" == "JpsiDzero" ]] || [[ "$MonteCarlo_channel" == "JpsiDZero" ]] || [[ "$MonteCarlo_channel" == "Jpsid0" ]] || [[ "$MonteCarlo_channel" == "Jpsidzero" ]]; then
      # Changes the bash name (just for organization)
      PS1='[\u@\h \W]\ Jpsi + D0 Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for Jpsi + D0 meson --------------------------"

      # Generates the fragment for Ultra legacy Monte Carlo 2017.
      cmsDriver.py Configuration/GenProduction/python/JpsiToMuMuwithDzero_13TeV_cfi.py --fileout file:JpsiToMuMuwithDZero_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDZero_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      # Generates events and gives filter efficency and cross sections
      cmsRun JpsiToMuMuwithDZero_13TeV_GS.py
      cp JpsiToMuMuwithDZero_13TeV_GS.py GS/config/

   # Runs Monte Carlo for production of Psi meson associated with D0 meson.
   elif [[ "$MonteCarlo_channel" == "PsiD0" ]] || [[ "$MonteCarlo_channel" == "PsiDzero" ]] || [[ "$MonteCarlo_channel" == "PsiDZero" ]] || [[ "$MonteCarlo_channel" == "Psid0" ]] || [[ "$MonteCarlo_channel" == "Psidzero" ]]; then
      # Changes the bash name (just for organization)
      PS1='[\u@\h \W]\ Psi(2S) + D0 Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for Psi + D0 meson --------------------------"

      # Generates the fragment for Ultra legacy Monte Carlo 2017.
      cmsDriver.py Configuration/GenProduction/python/PsiToMuMuwithDzero_13TeV_cfi.py --fileout file:PsiToMuMuwithDZero_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename PsiToMuMuwithDZero_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      # Generates events and gives filter efficency and cross sections
      cmsRun PsiToMuMuwithDZero_13TeV_GS.py
   
   # Runs Monte Carlo for production of JPsi meson associated with D+ meson.
   elif [[ "$MonteCarlo_channel" == "JpsiD+" ]] || [[ "$MonteCarlo_channel" == "JpsiDplus" ]] || [[ "$MonteCarlo_channel" == "JpsiDPlus" ]] || [[ "$MonteCarlo_channel" == "Jpsid+" ]] || [[ "$MonteCarlo_channel" == "Jpsidplus" ]]; then
      PS1='[\u@\h \W]\ Jpsi + D+ Simulation at 13 TeV: $'
      echo -e " \n \n -------------------------- Running fragment for Jpsi + D+ meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/JpsiToMuMuwithDPlus_13TeV_cfi.py --fileout file:JpsiToMuMuwithDPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithDPlus_13TeV_GS.py

   # Runs Monte Carlo for production of Psi meson associated with D+ meson.
   elif [[ "$MonteCarlo_channel" == "PsiD+" ]] || [[ "$MonteCarlo_channel" == "PsiDplus" ]] || [[ "$MonteCarlo_channel" == "PsiDPlus" ]] || [[ "$MonteCarlo_channel" == "Psid+" ]] || [[ "$MonteCarlo_channel" == "Psidplus" ]]; then
      PS1='[\u@\h \W]\ Psi + D+ Simulation at 13 TeV: $'
      echo -e " \n \n -------------------------- Running fragment for Psi + D+ meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/PsiToMuMuwithDPlus_13TeV_cfi.py --fileout file:PsiToMuMuwithDPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename PsiToMuMuwithDPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun PsiToMuMuwithDPlus_13TeV_GS.py
      
   
   # Runs Monte Carlo for production of JPsi meson associated with D_s+ meson.
   elif [[ "$MonteCarlo_channel" == "JpsiD_s+" ]] || [[ "$MonteCarlo_channel" == "JpsiDsplus" ]] || [[ "$MonteCarlo_channel" == "JpsiDSPlus" ]] || [[ "$MonteCarlo_channel" == "JpsiDSplus" ]] || [[ "$MonteCarlo_channel" == "JpsiD_S+" ]] || [[ "$MonteCarlo_channel" == "JpsiD_splus" ]] || [[ "$MonteCarlo_channel" == "JpsiD_sPlus" ]] || [[ "$MonteCarlo_channel" == "Jpsids+" ]] || [[ "$MonteCarlo_channel" == "Jpsid_s+" ]] || [[ "$MonteCarlo_channel" == "Jpsid_splus" ]] || [[ "$MonteCarlo_channel" == "JpsiDs+" ]]; then
      PS1='[\u@\h \W]\ Jpsi + D_s+ Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for Jpsi + D_s+ meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/JpsiToMuMuwithDSPlus_13TeV_cfi.py --fileout file:JpsiToMuMuwithDSPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDSPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithDSPlus_13TeV_GS.py

   # Runs Monte Carlo for production of Psi meson associated with D_s+ meson.
   elif [[ "$MonteCarlo_channel" == "PsiD_s+" ]] || [[ "$MonteCarlo_channel" == "PsiDsplus" ]] || [[ "$MonteCarlo_channel" == "PsiDSPlus" ]] || [[ "$MonteCarlo_channel" == "PsiDSplus" ]] || [[ "$MonteCarlo_channel" == "PsiD_S+" ]] || [[ "$MonteCarlo_channel" == "PsiD_splus" ]] || [[ "$MonteCarlo_channel" == "PsiD_sPlus" ]] || [[ "$MonteCarlo_channel" == "Psids+" ]] || [[ "$MonteCarlo_channel" == "Psid_s+" ]] || [[ "$MonteCarlo_channel" == "Psid_splus" ]] || [[ "$MonteCarlo_channel" == "PsiDs+" ]]; then
      PS1='[\u@\h \W]\ Psi + D_s+ Simulation at 13 TeV: $'

      echo -e " \n \n -------------------------- Running fragment for Psi + D_s+ meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/PsiToMuMuwithDSPlus_13TeV_cfi.py --fileout file:PsiToMuMuwithDSPlus_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 106X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename PsiToMuMuwithDSPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun PsiToMuMuwithDSPlus_13TeV_GS.py
   
   # Runs Monte Carlo for production of Jpsi meson associated with Lambda_c+ baryon.
   elif [[ "$MonteCarlo_channel" == "JpsiLambda_c+" ]] || [[ "$MonteCarlo_channel" == "Jpsilambda_c+" ]] || [[ "$MonteCarlo_channel" == "JpsiLambda_C+" ]] || [[ "$MonteCarlo_channel" == "JpsiLambda_Cplus" ]] || [[ "$MonteCarlo_channel" == "JpsiLambda_CPlus" ]] || [[ "$MonteCarlo_channel" == "JpsiLambdac+" ]] || [[ "$MonteCarlo_channel" == "Jpsilambdac+" ]] || [[ "$MonteCarlo_channel" == "JpsiLambdaC+" ]] || [[ "$MonteCarlo_channel" == "JpsilambdaC+" ]]; then
      PS1='[\u@\h \W]\ Jpsi + Lambda_c+ Simulation at 13 TeV:$'

      echo -e " \n \n -------------------------- Running fragment for Jpsi + Lambda_c+ baryon --------------------------"
      cmsDriver.py Configuration/GenProduction/python/JpsiToMuMuwithLambdaCPlus_13TeV_cfi.py --fileout file:JpsiToMuMuwithLambdac_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithLambdaCPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithLambdaCPlus_13TeV_GS.py

   # Runs Monte Carlo for production of Psi meson associated with Lambda_c+ baryon.
   elif [[ "$MonteCarlo_channel" == "PsiLambda_c+" ]] || [[ "$MonteCarlo_channel" == "Psilambda_c+" ]] || [[ "$MonteCarlo_channel" == "PsiLambda_C+" ]] || [[ "$MonteCarlo_channel" == "PsiLambda_Cplus" ]] || [[ "$MonteCarlo_channel" == "PsiLambda_CPlus" ]] || [[ "$MonteCarlo_channel" == "PsiLambdac+" ]] || [[ "$MonteCarlo_channel" == "Psilambdac+" ]] || [[ "$MonteCarlo_channel" == "PsiLambdaC+" ]] || [[ "$MonteCarlo_channel" == "PsilambdaC+" ]]; then
      PS1='[\u@\h \W]\ Psi + Lambda_c+ Simulation at 13 TeV:$'

      echo -e " \n \n -------------------------- Running fragment for Psi + Lambda_c+ baryon --------------------------"
      cmsDriver.py Configuration/GenProduction/python/PsiToMuMuwithLambdaCPlus_13TeV_cfi.py --fileout file:PsiToMuMuwithLambdac_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename PsiToMuMuwithLambdaCPlus_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun PsiToMuMuwithLambdaCPlus_13TeV_GS.py
   
   # Runs Monte Carlo for production of JPsi meson associated with D* meson.
   elif [ "$MonteCarlo_channel" == "JpsiD*" ]; then
      PS1='[\u@\h \W]\ Jpsi + D* Simulation at 13 TeV:$'

      echo -e " \n \n -------------------------- Running fragment for Jpsi + D* meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/JpsiToMuMuwithDstar_13TeV_cfi.py --fileout file:JpsiToMuMuwithDstar_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename JpsiToMuMuwithDstar_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun JpsiToMuMuwithDstar_13TeV_GS.py
      cp JpsiToMuMuwithDstar_13TeV_GS.py GS/config/
   
   # Runs Monte Carlo for production of Psi meson associated with D* meson.
   elif [ "$MonteCarlo_channel" == "PsiD*" ]; then
      PS1='[\u@\h \W]\ Psi + D* Simulation at 13 TeV:$'

      echo -e " \n \n -------------------------- Running fragment for Psi + D* meson --------------------------"
      cmsDriver.py Configuration/GenProduction/python/PsiToMuMuwithDstar_13TeV_cfi.py --fileout file:PsiToMuMuwithDstar_13TeV_GS.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_mc2017_realistic_v7 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename PsiToMuMuwithDstar_13TeV_GS.py --no_exec -n $MonteCarlo_numevts
      cmsRun PsiToMuMuwithDstar_13TeV_GS.py

   fi
   

else
  
  echo -e " \n \n ############################################### ERROR ##################################################                   
  \nYou have to set the variable ENV  !!!!! "
                                                                           
fi
