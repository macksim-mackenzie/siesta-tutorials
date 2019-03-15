#!/bin/bash

for dist in $(seq -w 0.50 0.05 1.25)
  do
  cd dist_$dist
  siesta input.fdf > job.out
  cd ..
done
