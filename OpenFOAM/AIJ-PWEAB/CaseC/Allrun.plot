#!/bin/sh
# Source tutorial run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

gnuplot plot/plotHorizontalU.gp
gnuplot plot/residual.gp

epsfiles="plotHorizontalU.eps residual.eps"
base=`basename ${PWD}`
CONVERT=$(which convert 2> /dev/null)
if [ ! "x$CONVERT" = "x" ]
then
    $CONVERT -density 300 $epsfiles $base.pdf
else
    echo "convert not installed" >&2
fi
