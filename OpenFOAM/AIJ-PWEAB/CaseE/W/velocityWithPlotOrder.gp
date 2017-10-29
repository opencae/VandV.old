set output "velocityWithPlotOrder.eps"
set xtics ("16" 1,"24" 2,"25" 3,"26" 4,"27" 5,"28" 6,"29" 7,"30" 8,"37" 9,"38" 10,"41" 11,"56" 12,"57" 13,"58" 14,"59" 15,"60" 16,"61" 17,"62" 18,"63" 19,"64" 20,"70" 21,"71" 22,"72" 23,"73" 24,"39" 25,"40" 26,"50" 27,"51" 28,"52" 29,"53" 30,"54" 31,"55" 32,"75" 33,"76" 34,"2" 35,"3" 36,"4" 37,"5" 38,"14" 39,"15" 40,"23" 41,"36" 42,"42" 43,"43" 44,"44" 45,"1" 46,"6" 47,"7" 48,"8" 49,"9" 50,"10" 51,"11" 52,"12" 53,"13" 54,"17" 55,"18" 56,"19" 57,"20" 58,"21" 59,"22" 60,"31" 61,"32" 62,"33" 63,"34" 64,"35" 65,"45" 66,"46" 67,"48" 68,"49" 69,"65" 70,"66" 71,"67" 72,"68" 73,"69" 74,"74" 75,"77" 76,"78" 77,"79" 78,"80" 79,"" 0) rotate nomirror
set terminal postscript eps enhanced 10
set size ratio 0 1,0.4
set pointsize 0.8
set xlabel "Measurement point number"
set ylabel "Ratio of velocity" 1,0
set xrange [ 0 : 81]
set yrange [ 0 : 1.6 ]
set ytics 0.2
set mytics 2
set grid xtics ytics

zRef=0.008
z0=0.005
z1=0.010
U0=0.365
U1=0.390
Uboundary=7.8
alpha=(zRef-z0)/(z1-z0)
URef=((1-alpha)*U0+alpha*U1)*Uboundary
plot \
"sets/latestTime/measuringPoints_k_magU.xy"\
  using ($0+1):($5/URef) with lp title "CFD"\
,"exp/U.txt"\
  using ($0+1):2 with p pt 6 title "Exp"
#    EOF
