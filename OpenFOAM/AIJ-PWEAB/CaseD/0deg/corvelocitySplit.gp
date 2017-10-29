set terminal postscript eps enhanced 22
set output "corvelocitySplit.eps"
set style data points
set xlabel "Exp(Split fiber)"
set ylabel "CFD"
set xrange [0:1]
set yrange [0:1]
set xtics 0.2
set ytics 0.2
set size square 1,1
set xzeroaxis
set yzeroaxis
set key bottom
set grid
set pointsize 1.5
unset key 
UH=6.61
se=`awk 'BEGIN {rmse=0;n=0;UH=6.61} $7!="NA" {n++;x=$7/UH;y=$5/UH;e=y-x;rmse+=e*e} END {rmse=sqrt(rmse/n);print rmse}' corvelocitySplit.txt`
set label "RMSE=%.3g", se  at 0.1,0.9 
plot \
x title "" \
,"corvelocitySplit.txt" using ($7/UH):($5/UH) with p pt 6
#    EOF
