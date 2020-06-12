#!/usr/bin/gnuplot -persist

# PNG output
set terminal png size 2000,2000 enhanced font "Times New Roman, 64"
set output "bands.png"

set view map

# Ranges
set xrange [0:1.553878]
set yrange [-3.00:3.00]

set border 15 lw 12

# Tics and labels
unset xtics
set ylabel 'E-E_F (eV)'
set xtics ("{/Symbol G}" 0.000000,
           "K"           0.656737,
           "M"           0.985106,
           "{/Symbol G}" 1.553878)

# Fermi level shift
f(x)=x+4.404580

plot "./bands.dat" u 1:(f($2)) with lines lw 4 lc "black" notitle

