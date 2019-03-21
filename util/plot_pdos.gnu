#!/usr/bin/gnuplot

# PNG output
set terminal png transparent size 2000,1000 enhanced font "Times New Roman, 64"
set output "pdos_in.png"
# type: $ convert -rotate -90 pdos_in.png pdos_out.png
# after gnuplot

# Ranges
set xrange [-3.00:3.00]
set yrange [-6.00:0.00]

#set palette defined (0 '#91cf60', 0.5 '#ffffbf', 1 '#fc8d59')
#set palette defined (0 '#ffffff', 1.0 '#ff0000')
#set palette defined (0.0 '#d53e4f', \
#                     0.2 '#fc8d59', \
#                     0.4 '#fee08b', \
#                     0.6 '#e6f598', \
#                     0.8 '#99d594', \
#                     1.0 '#3288bd')


set border 15 lw 12

f(x)=x+4.044271
m(x)=-x

set ylabel 'Mo  S  Total' rotate by -90
set xlabel 'E-E_F (eV)'
unset ytics
set xtics rotate by -90
plot "./pdos_tot.dat" u (f($1)):(m($2)) notitle with lines lw 4 lc "#d53e4f", \
     "./pdos_Mo.dat" u (f($1)):(m($2)) with lines lw 4 lc "#3288bd" notitle 


