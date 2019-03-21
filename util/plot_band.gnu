#!/usr/bin/gnuplot -persist

# PNG output
set terminal png size 2000,2000 enhanced font "Times New Roman, 64"
set output "proj_band.png"

# PS
#set term postscript enhanced 
#set output "proj_band.ps"

# SVG output
#set terminal svg enhanced font "Times New Roman, 24" size 600,600
#set output "proj_band.svg"
#set encoding iso_8859_1

# PDF output
#set terminal pdf
#set output "proj_band.pdf"

set view map

# Ranges
set xrange [0:1.553878]
set yrange [-3.00:3.00]
set zrange [0:1]
set cbrange [0:1]

#set palette defined (0 '#91cf60', 0.5 '#ffffbf', 1 '#fc8d59')
#set palette defined (0 '#ffffff', 1.0 '#ff0000')
set palette defined (0.0 '#d53e4f', \
                     0.2 '#fc8d59', \
                     0.4 '#fee08b', \
                     0.6 '#e6f598', \
                     0.8 '#99d594', \
                     1.0 '#3288bd')


set border 15 lw 12

# Tics and labels
unset xtics
set ylabel 'E-E_F (eV)'
set xtics ("{/Symbol G}" 0.0,"K" 0.656737,"M" 0.985106, "{/Symbol G}" 1.553878)

f(x)=x+4.404580

plot "./bands_Nb.dat" u 1:(f($2)):3 notitle with lines lw 20 palette, \
     "./bands_Nb.dat" u 1:(f($2)) w lines lw 4 lc "black" notitle

#plot "./bands_Nb.dat" u 1:(f($2)):3 notitle with lines lw 16 palette
#set output "band.eps"
