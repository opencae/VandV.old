#!/bin/sh
# Source tutorial run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

dir=${PWD##*/}

# make syblock link to latest time directory
(
    cd postProcessing/sample
    rm -f latestTime
    ln -s `ls -d [1-9]* | sort -n | tail -n 1` latestTime
)

paste \
postProcessing/sample/latestTime/measuringPoints_mag\(U\)_k.xy \
validation/exptData/thermistor.txt \
> corvelocityThermistor.txt

for file in plot/{residual.gp,probes.gp}
do
    gnuplot $file
done

for file in validation/{corvelocityThermistor.gp,velocityThermistor.gp}
do
    gnuplot $file
done

epsfiles="velocityThermistor.eps corvelocityThermistor.eps"

if [ "$dir" = "0deg" ];then
    paste \
	postProcessing/sample/latestTime/measuringPoints_mag\(U\)_k.xy \
        validation/exptData/split.txt \
	> corvelocitySplit.txt
    for file in validation/{corvelocitySplit.gp,velocitySplit.gp}
    do
	gnuplot $file
    done
  epsfiles="$epsfiles velocitySplit.eps corvelocitySplit.eps"
fi

epsfiles="$epsfiles residual.eps probes.eps"

convert -density 300 $epsfiles plot.pdf
