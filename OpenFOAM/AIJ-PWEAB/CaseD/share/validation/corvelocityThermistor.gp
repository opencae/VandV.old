set terminal postscript eps enhanced 22
set output "corvelocityThermistor.eps"
set style data points
set xlabel "Exp(Thermister)"
set ylabel "CFD(OpenFOAM)"
set xrange [0:1]
set yrange [0:1]
set xtics 0.2
set ytics 0.2
set size square 1,1
set xzeroaxis
set yzeroaxis
set key bottom
set grid
unset key 
set pointsize 1.5
UH=6.61
se=`awk 'BEGIN {rmse=0;n=0;UH=6.61} \
$7!="NA" {n++;x=$7/UH;y=sqrt($4*$4+2*$5)/UH;e=y-x;rmse+=e*e} \
END {rmse=sqrt(rmse/n);print rmse}' corvelocityThermistor.txt`
set label "RMSE=%.3g", se  at 0.1,0.9 
plot \
x title "" \
,"corvelocityThermistor.txt" using ($7/UH):(sqrt($4*$4+2*$5)/UH) with p pt 6
#    EOF
