#!/bin/sh
# Source tutorial run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

gnuplot plot/profileU.gp
gnuplot plot/profilek.gp
gnuplot plot/residual.gp

epsfiles="profileU.eps profilek.eps residual.eps"
base=`basename ${PWD}`
CONVERT=$(which convert 2> /dev/null)
if [ ! "x$CONVERT" = "x" ]
then
    $CONVERT -density 300 $epsfiles $base.pdf
else
    echo "convert not installed" >&2
fi
