i=14

while [ $i -gt 0 ]
do
  crab resubmit crab_projects/crab_AOD_Jpsi_23-03-2022/
  sleep 900
  echo Hours left: $i/2
  ((i--))
done
