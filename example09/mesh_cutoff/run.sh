#!/bin/bash

for mesh in $(seq -w 100 50 800)
  do
  cd mesh_$mesh
  OMP_NUM_THREADS=1 mpirun -np 6 siesta-intel < input.fdf > job.out
  cd ..
done
