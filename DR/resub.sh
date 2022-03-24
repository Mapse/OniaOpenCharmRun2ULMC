i=14

while [ $i -gt 0 ]
do
  crab resubmit crab_projects/crab_DR_JpsiToMuMuwithDstar2018_17-11-2021/
  sleep 1800
  echo Hours left: $i/2
  ((i--))
done
