set terminal postscript enhanced eps color solid 22
set output "profileU.eps"

b=0.08
r=0.1
y1=4.5
xarrow=2.5

set xrange [ -1 : 4 ]
set yrange [ 0 : y1 ]
set xtics 1
set ytics 1
set mxtics 4
set mytics 2
set key left
set xlabel "x/b" offset 0,1
set ylabel "z/b" offset 1,0

set arrow from  xarrow    ,y1-0.15 rto 0.5,0  nohead lw 2
set arrow from  xarrow    ,y1-0.15 rto 0,-0.1 nohead lw 2
set arrow from  xarrow+0.5,y1-0.15 rto 0,-0.1 nohead lw 2
set label "U [m/s]" at xarrow-0.2,y1-0.25 right
set label "0"       at xarrow    ,y1-0.35 center
set label "5"       at xarrow+0.5,y1-0.35 center

set arrow from -0.5,0 to -0.5,2    nohead lw 2
set arrow from -0.5,2 to  0.5,2    nohead lw 2
set arrow from  0.5,0 to  0.5,2    nohead lw 2
set arrow from -0.75,0 to -0.75,y1 nohead ls 3
set arrow from -0.5 ,2 to -0.5 ,y1 nohead ls 3
set arrow from -0.25,2 to -0.25,y1 nohead ls 3
set arrow from -0   ,2 to -0   ,y1 nohead ls 3
set arrow from  0.5 ,2 to  0.5 ,y1 nohead ls 3
set arrow from  0.75,0 to  0.75,y1 nohead ls 3
set arrow from  1.25,0 to  1.25,y1 nohead ls 3
set arrow from  2   ,0 to  2   ,y1 nohead ls 3
set arrow from  3.25,0 to  3.25,y1 nohead ls 3

plot \
"plot/expData/resutlsVerSec.txt" using ($1+$4*r):3 title "Exp" with point pt 7 lt 1 lc 1\
,"< cat postProcessing/sample/*/verx_-075_U.xy" using ($1/b+$4*r):($3/b) title "CFD" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_-050_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_-025_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_000_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_050_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_075_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_125_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_200_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2\
,"< cat postProcessing/sample/*/verx_325_U.xy" using ($1/b+$4*r):($3/b) title "" with line lt 1 lc 0 lw 2
