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
    object      setDiscreteFieldsDict;
}
  patchNames <- c(patchNames,"_x")
} else {
  Wx <- 0
}
if (Wy > SMALL) {
  patchNames <- c(patchNames,"y_")
} else if (Wy < -SMALL ) {
  patchNames <- c(patchNames,"_y")
} else {
  Wy <- 0
}

#
# write setDiscreteFieldsDict
#
out <- file("setDiscreteFieldsDict","w")

#
# write header
#
header <- "FoamFile
{
version 2.0;
format  ascii;
class   dictionary;
object  setDiscreteFieldsDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

Fields
("

writeLines(header,out,sep="\n")

#
# write Uprofile
#
Uprofile <- "Uprofile
{
field U;
type vector;
direction \"z\";
internal false ;
patchNames
("

writeLines(Uprofile,out,sep="\n")
writeLines(patchNames,out,sep="\n")

Uprofile2 <- ");
profile
("

writeLines(Uprofile2,out,sep="\n")

for (i in 1:length(U)) {
  Ux <- Wx * U[i]
  Uy <- Wy * U[i]
  writeLines(sprintf("(0 0 %g %g %g 0)",z[i],Ux,Uy),out,sep="\n")
}

Uprofile3 <- ");
}"

writeLines(Uprofile3,out,sep="\n")

#
# write kProfile
#
kProfile <- "kProfile
{
field k;
type scalar;
direction \"z\";
internal false ;
patchNames
("

writeLines(kProfile,out,sep="\n")
writeLines(patchNames,out,sep="\n")

kProfile2 <- ");
profile
("

writeLines(kProfile2,out,sep="\n")

for (i in 1:length(U)) {
  writeLines(sprintf("(0 0 %g %g)",z[i],k[i]),out,sep="\n")
}

kProfile3 <- ");
}"

writeLines(kProfile3,out,sep="\n")

#
# write epsilonProfile
#
epsilonProfile <- "epsilonProfile
{
field epsilon;
type scalar;
direction \"z\";
internal false ;
patchNames
("

writeLines(epsilonProfile,out,sep="\n")
writeLines(patchNames,out,sep="\n")

epsilonProfile2 <- ");
profile
("

writeLines(epsilonProfile2,out,sep="\n")

for (i in 1:length(U)) {
  writeLines(sprintf("(0 0 %g %g)",z[i],epsilon[i]),out,sep="\n")
}

epsilonProfile3 <- ");
}"

writeLines(epsilonProfile3,out,sep="\n")

#
# write footer and close outputfile
#
footer <- ");

// ************************************************************************* //"
writeLines(footer,out,sep="\n")

close(out)
