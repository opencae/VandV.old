all: sampleDict setDiscreteFieldsDict changeDictionaryDict

sampleDict: samplePoints.csv sampleDict.R
	/usr/bin/R --vanilla < $@.R

setDiscreteFieldsDict changeDictionaryDict: inflow.csv setDiscreteFieldsDict.conf setInflowBoundary.R
	/usr/bin/R --vanilla < setInflowBoundary.R
