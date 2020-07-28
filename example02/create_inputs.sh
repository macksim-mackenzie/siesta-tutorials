#!/bin/bash
# file: create_inputs.sh

for dist in $(seq -w 0.50 0.05 1.201)
  do
  mkdir dist_$dist
  cd dist_$dist
  cp ../H.psf .
  sed "s/VAR_DISTANCE/$dist/g" ../input.fdf > input.fdf
  cd ..
done
