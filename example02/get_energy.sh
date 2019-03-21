#!/bin/bash
# file: get_energy.sh

for dist in $(seq -w 0.50 0.05 1.201)
  do
  cd dist_$dist
  energy=`grep 'Total =' job.out | cut -d = -f 2`
  echo $dist $energy
  cd ..
done
