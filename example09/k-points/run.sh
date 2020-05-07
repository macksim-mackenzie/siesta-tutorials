#!/bin/bash

for k in $(seq -w 5 2 25)
  do
  cd k_$k
  OMP_NUM_THREADS=1 mpirun -np 6 siesta-intel < input.fdf > job.out
  cd ..
done
