To run GS do:

1. on src/ run run_<year>_GS.sh, year could be 2016, 2017, 2018

This step will generate the configuration file and move it to the right folder.

2. Open submit_GS.py

change the values as you wish:

njobs = 10000 
evtsjob = 1200000 

3. Open crab_config_GS.py

Change config.Data.outputPrimaryDataset = 'CRAB_PrivateMC_RunII_UL_<year>'

year: The year of the fragment.

Change config.JobType.eventsPerLumi = <value>

value should follow evtsjob:

it should be at least 1000xevtsjob

4. Run sh:

. run_2018_GS.sh
