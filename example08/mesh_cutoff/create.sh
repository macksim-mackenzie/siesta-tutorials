#!/bin/bash

for mesh in $(seq -w 100 50 800)
  do
  mkdir mesh_$mesh
  cd mesh_$mesh
  cp ../*.psf .
  sed "s/VAR_MESH/$mesh/" ../input.fdf > input.fdf
  cd ..
done
