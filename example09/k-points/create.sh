#!/bin/bash

for k in $(seq -w 5 2 25)
  do
  mkdir k_$k
  cd k_$k
  cp ../*.psf .
  sed "s/VAR_K/$k/" ../input.fdf > input.fdf
  cd ..
done
