plot \
"sets/latestTime/measuringPoints_k_magU.xy"\
  using ($0+1):(sqrt($5*$5+2*$4)/URef) with lp title "CFD"\
,"exp/U.txt"\
  using ($0+1):2 with p pt 6 title "Exp"
#    EOF
