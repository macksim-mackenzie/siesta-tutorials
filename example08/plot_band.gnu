#!/usr/bin/gnuplot -persist

# PNG output
set terminal png size 2000,2000 enhanced font "Times New Roman, 64"
set output "bands.png"

set view map

# Ranges
set xrange [0:2.106653]
set yrange [-6.00:6.00]

set border 15 lw 12

# Tics and labels
unset xtics
set ylabel '{/:Italic E}-{/:Italic E}_F (eV)'
set xtics ("{/Symbol G}" 0.000000, \
           "K"           0.890376, \
           "M"           1.335564, \
           "{/Symbol G}" 2.106653)

plot "./bands.dat" u 1:2 with lines lw 6 lc "blue" notitle

