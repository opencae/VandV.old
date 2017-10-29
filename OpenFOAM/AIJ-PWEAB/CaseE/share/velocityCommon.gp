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
