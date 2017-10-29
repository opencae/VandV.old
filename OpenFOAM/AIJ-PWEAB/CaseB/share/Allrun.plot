#!/bin/sh
#    This file is part of caseB.
#
#    caseB is free software: you can redistribute it and/or modify it
#    under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    caseB is distributed in the hope that it will be useful, but
#    WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with caseB.  If not, see <http://www.gnu.org/licenses/>.

# Copyright (c) 2010-2017 Takuya OSHIMA <oshima@eng.niigata-u.ac.jp>.
# Copyright (c) 2014-2017 Masashi Imano <masashi.imano@gmail.com>.

model="${PWD##*/}"

gnuplot <<EOF
    # Common settings
    set st d lp
    set size 1, 0.8
    set key box
    set grid
    set term post eps color "Helvetica" 21

    # Plot horizontal distribution of normalized velocity
    set xla \
        "Location (1-: Region 1, 14-: R. 2, 38-: R. 3, 11-: R. 4, 94-: R. 5)"
    set yla "Normalized velocity" offset 1
    set xtics ("1" 1, "14" 11, "38" 50, "11" 74, "94" 98, "115" 115)
    set yrange [0:1.8]
    set out "horizontal_U_$model.eps"
    file = "horizontal_U_processed_$model.txt"
    plot [1:115] file u 1:3 lw 3 t "Wind tunnel", \
         file u 1:4 lw 3 t "OpenFOAM ($model)"

    # Plot vertical profile of normalized velocity
    unset key
    set xla "x [m]"
    set yla "z [m]" offset 1
    set xtics (-0.075, 0, 0.1, 0.2, 0.3, 0.4)
    set ytics (0, 0.1, 0.2, 0.3, 0.35)
    set yrange [0:0.35]
    set object 1 rect from -0.025,0 to 0.025, 0.2
    set out "verticalProfile_U_$model.eps"
    plot [-0.1:0.5] \
        "UMeasuredVertical_processed_$model.txt" lw 3 t "Wind tunnel", \
        "vertical_U_processed_$model.txt" w lp lw 3 t "OpenFOAM ($model)"

    # Plot vertical profile of k
    set out "verticalProfile_k_$model.eps"
    plot [-0.1:0.5] \
        "kMeasuredVertical_processed_$model.txt" lw 3 t "Wind tunnel", \
        "vertical_k_processed_$model.txt" w lp lw 3 t "OpenFOAM ($model)"
EOF

epsfiles="horizontal_U_${model}.eps verticalProfile_U_${model}.eps verticalProfile_k_${model}.eps"
base=`basename ${PWD}`
CONVERT=$(which convert 2> /dev/null)
if [ ! "x$CONVERT" = "x" ]
then
    $CONVERT -density 300 $epsfiles $base.pdf
else
    echo "convert not installed" >&2
fi
