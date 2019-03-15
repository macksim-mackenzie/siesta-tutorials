# file: create_inputs.sh

for dist in $(seq -w 0.50 0.05 1.25)
  do
  mkdir dist_$dist
  cd dist_$dist
  cp ../H.gga.psf .
  sed "s/VAR_DISTANCE/$dist/g" ../input.fdf > input.fdf
  cd ..
done
