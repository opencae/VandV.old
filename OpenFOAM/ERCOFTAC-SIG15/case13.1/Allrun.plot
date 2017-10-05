#!/bin/sh

for dir in */
do
    echo $dir
    (cd $dir
	./Allrun.plot $*
	)
done

# ----------------------------------------------------------------- end-of-file
