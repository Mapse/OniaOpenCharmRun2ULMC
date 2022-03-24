i=24

while [ $i -gt 0 ]
do
  crab resubmit crab_projects/crab_GS_Jpsi_16-03-2022/
  sleep 1800
  echo Hours left: $i
  ((i--))
done
