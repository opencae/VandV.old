set terminal postscript eps enhanced color solid 17
set output "velocityThermistor.eps"
set size ratio 0 1,0.6
set pointsize 0.9
set xlabel "Measurement point number"
set ylabel "Normalized velocity" 1,0
set yrange [ 0 : 1.2 ]
set xtics 5
set ytics 0.1
set grid xtics ytics
set key box horizontal
UH=6.61
plot \
"corvelocityThermistor.txt" using ($0+1):(sqrt($4*$4+2*$5)/UH) with lp lt 1 pt 6 title "CFD(OpenFOAM)"\
,"validation/cfdData/M1/velocity.txt" using 1:3 with lp lt 2 pt 2 title "CFD(M1)"\
,"validation/cfdData/T1/velocity.txt" using 1:3 with lp lt 3 pt 4 title "CFD(T1)"\
,"validation/exptData/thermistor.txt" using 1:($2 != "NA" ? ($2/UH) : 1/0) with lp lt 1 lw 2 pt 7 title "Exp(Thermister)"
#    EOF