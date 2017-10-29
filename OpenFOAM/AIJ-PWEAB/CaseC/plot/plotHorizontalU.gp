set terminal postscript eps color solid 22
set output "plotHorizontalU.eps"
set style data lp
set xlabel "Measurement Points"
set grid
set ylabel "Normalized velocity" offset 1
set xrange [0:120]
set yrange [0:2.0]
set pointsize 0.8
V0 = 2.43 
plot \
'< cat postProcessing/sample/*/horizontal_k_mag\(U\).xy' \
  using ($0+1):(($5/V0+2*$4/(V0*V0))) title "CFD" with lp lc 0 pt 2 \
,'plot/exptData/UMeasured0deg.txt' using ($0+1):4 title "Exp." with lp lc 1 lw 2 pt 7
