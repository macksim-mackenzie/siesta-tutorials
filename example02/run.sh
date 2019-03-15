#!/bin/bash
# file: run.sh

for dist in $(seq -w 0.50 0.05 1.201)
  do
  cd dist_$dist
  siesta input.fdf > job.out
  cd ..
done
