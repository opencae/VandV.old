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
    class       ascii;
    object      ascii;
}
  patchNames <- c("_x")
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
patchNames

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
internal true;
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
internal true;
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
internal true;
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

#
# write changeDictionaryDict
#
fixedValueVector <- "{
  type            fixedValue;
  value           uniform (0 0 0);
}"

fixedValueScalar <- "{
  type            fixedValue;
  value           uniform 0;
}"

zeroGradient <- "{
  type            zeroGradient;
}"

slip <- "{
  type            slip;
}"

out <- file("changeDictionaryDict","w")

#
# write header
#
header <- "FoamFile
{
version 2.0;
format  ascii;
class   dictionary;
object  changeDictionaryDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

dictionaryReplacement
{"

writeLines(header,out,sep="\n")

#
# U
#
Uheader="U
{
boundaryField
{"

writeLines(Uheader,out,sep="\n")
writeLines(sprintf("%s\n%s",patchNames,fixedValueVector),out,sep="\n")
if ( Wx == 0 ) {
  writeLines(sprintf("%s\n%s",c("x_","_x"),slip),out,sep="\n")
} else if ( Wy == 0 ) {
  writeLines(sprintf("%s\n%s",c("y_","_y"),slip),out,sep="\n")
} 
writeLines("}\n}",out,sep="\n")

#
# k
#
kheader="k
{
boundaryField
{"

writeLines(kheader,out,sep="\n")
writeLines(sprintf("%s\n%s",patchNames,fixedValueScalar),out,sep="\n")
if ( Wx == 0 ) {
  writeLines(sprintf("%s\n%s",c("x_","_x"),slip),out,sep="\n")
} else if ( Wy == 0 ) {
  writeLines(sprintf("%s\n%s",c("y_","_y"),slip),out,sep="\n")
} 
writeLines("}\n}",out,sep="\n")

#
# epsilon
#
epsilonheader="epsilon
{
boundaryField
{"

writeLines(epsilonheader,out,sep="\n")
writeLines(sprintf("%s\n%s",patchNames,fixedValueScalar),out,sep="\n")
if ( Wx == 0 ) {
  writeLines(sprintf("%s\n%s",c("x_","_x"),slip),out,sep="\n")
} else if ( Wy == 0 ) {
  writeLines(sprintf("%s\n%s",c("y_","_y"),slip),out,sep="\n")
} 
writeLines("}\n}",out,sep="\n")

#
# p
#
pheader="p
{
boundaryField
{"

writeLines(pheader,out,sep="\n")
writeLines(sprintf("%s\n%s",patchNames,zeroGradient),out,sep="\n")
if ( Wx == 0 ) {
  writeLines(sprintf("%s\n%s",c("x_","_x"),slip),out,sep="\n")
} else if ( Wy == 0 ) {
  writeLines(sprintf("%s\n%s",c("y_","_y"),slip),out,sep="\n")
} 
writeLines("}\n}",out,sep="\n")

#
# write footer and close outputfile
#
footer <- "}

// ************************************************************************* //"
writeLines(footer,out,sep="\n")

close(out)
