set output "velocityWithPlotOrder.eps"
set xtics ("23" 1,"36" 2,"37" 3,"58" 4,"59" 5,"60" 6,"62" 7,"70" 8,"71" 9,"72" 10,"22" 11,"34" 12,"35" 13,"46" 14,"48" 15,"49" 16,"50" 17,"51" 18,"52" 19,"53" 20,"54" 21,"55" 22,"65" 23,"66" 24,"67" 25,"68" 26,"69" 27,"74" 28,"77" 29,"78" 30,"79" 31,"2" 32,"3" 33,"4" 34,"5" 35,"14" 36,"15" 37,"16" 38,"24" 39,"25" 40,"26" 41,"27" 42,"28" 43,"29" 44,"30" 45,"38" 46,"41" 47,"42" 48,"43" 49,"44" 50,"56" 51,"57" 52,"61" 53,"63" 54,"64" 55,"73" 56,"1" 57,"6" 58,"7" 59,"8" 60,"9" 61,"10" 62,"11" 63,"12" 64,"13" 65,"17" 66,"18" 67,"19" 68,"20" 69,"21" 70,"31" 71,"32" 72,"33" 73,"39" 74,"40" 75,"45" 76,"75" 77,"76" 78,"80" 79,"" 0) rotate nomirror
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
