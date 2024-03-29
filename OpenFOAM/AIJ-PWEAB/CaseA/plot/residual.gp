set terminal postscript eps color solid 20 linewidth 2
set output "residual.eps"
set logscale y
set xlabel "Time"
set ylabel "Residual"
set grid
set style data line
plot \
"postProcessing/residuals/0/residuals.dat" using 1:2 title "p",\
"" using 1:3  title "Ux",\
"" using 1:4  title "Uy",\
"" using 1:5  title "Uz",\
"" using 1:6  title "k",\
"" using 1:7  title "epsilon"
#    EOF
