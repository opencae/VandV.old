##
### commands
###
application=simpleFoam
potentialFoam=potentialFoam
ps_viewer=gv
R=/usr/bin/R --vanilla

###
### targets 
###
plot_objs=\
velocityWithPlotOrder.eps \
velocityThermistorWithPlotOrder.eps \
res.eps \

###
### suffix rules
###
.SUFFIXES : .gp .eps

.gp.eps:
	nohup gnuplot $< >& /dev/null

###
### entries
###

all:
	@echo "Type: make (mesh|init|fgrun|bgrun|de|pfgrun|pbgrun|re|plot|plotview|cleanmesh|cleaninit|cleanrun|clean)"

mesh: tmp.mesh

tmp.mesh: ./makeMesh blockMeshDict system/snappyHexMeshDict
	 ./makeMesh 2>&1 | tee $@

init: tmp.init

tmp.init: ./makeInit system/setDiscreteFieldsDict
	 ./makeInit 2>&1 | tee $@

de:
	decomposePar 2>&1 | tee tmp.decomposePar

re:	
	reconstructPar -latestTime 2>&1 | tee tmp.reconstructPar

fgrun:
	${application} | tee log

pfgrun:
	foamJob -s -p ${application}

bgrun:
	foamJob ${application}

pbgrun:
	foamJob -p ${application}

fgpotential:
	foamJob -s ${potentialFoam}
	mv log log.${potentialFoam}

pfgpotential:
	foamJob -s -p ${potentialFoam}
	mv log log.${potentialFoam}

bgpotential:
	foamJob ${potentialFoam}
	mv log log.${potentialFoam}

pbgpotential:
	foamJob -p ${potentialFoam}
	mv log log.${potentialFoam}

plot:	${plot_objs}

plotview: plot
	for file in ${plot_objs};do echo $$file;${ps_viewer} $$file;done

view:
	paraFoam

## clean entries
cleanmesh: 
	rm -f tmp.mesh
	rm -fr constant/polyMesh/*

cleaninit: 
	rm -f tmp.init
	rm -fr 0

cleanrun:
	rm -f tmp.* log log.${potentialFoam}
	rm -fr [1-9]* processor*/

cleanplot: 
	rm -f tmp.* *.eps
	rm -fr sets/ surfaces/ logs/

clean: cleaninit cleanplot cleanrun 

### temporary targets
tmp.foamLog: log
	foamLog $< 2>&1 | tee $@

tmp.sample: log system/sampleDict tmp.foamCalc
	sample -latestTime 2>&1 | tee $@

tmp.foamCalc: log
	foamCalc mag U -latestTime 2>&1 | tee $@

tmp.setsLatestTime: tmp.sample
	(cd sets;rm -f latestTime;ln -s `ls -d [0-9]* |sort -n | tail -n 1` latestTime) 2>&1 | tee $@

### gnuplot figures
res.eps: tmp.foamLog

xtics.gp: plotOrder.csv makextics.R
	$R < makextics.R

velocityWithPlotOrder.gp: xtics.gp velocityCommon.gp velocity.gp
	echo set output \"${@:.gp=.eps}\" > $@
	cat xtics.gp velocityCommon.gp velocity.gp >> $@

velocityThermistorWithPlotOrder.gp: xtics.gp velocityCommon.gp velocityThermistor.gp
	echo set output \"${@:.gp=.eps}\" > $@
	cat xtics.gp velocityCommon.gp velocityThermistor.gp >> $@

velocityWithPlotOrder.eps velocityThermistorWithPlotOrder.eps: tmp.setsLatestTime
