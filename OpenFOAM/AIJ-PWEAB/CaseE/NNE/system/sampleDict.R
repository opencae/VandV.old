/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  2.1.x                                 |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      sampleDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

setFormat raw;

surfaceFormat foamFile;

interpolationScheme cellPointFace;

fields
(
    U
    magU
    k
);

sets
(

    measuringPoints
    {
        type cloud;
        axis xyz;
        points          
        ("

writeLines(header,out,sep="\n")

#
# write sample points
#

ptr=numeric(no[length(no)])
for (i in 1:length(no)) {
  ptr[no[i]] <- i 
}

writeLines(sprintf("(%g %g %g) // %d",x[ptr[order]],y[ptr[order]],z,order),out,sep="\n")

# write footer and close outputfile
#
footer <- ");
}
);

surfaces
(
);

// *********************************************************************** //"

writeLines(footer,out,sep="\n")

close(out)
