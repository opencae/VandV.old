plot \
"sets/latestTime/measuringPoints_k_magU.xy"\
  using ($0+1):($5/URef) with lp title "CFD"\
,"exp/U.txt"\
  using ($0+1):2 with p pt 6 title "Exp"
#    EOF
