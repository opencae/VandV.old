#!/usr/bin/env python2
import commands

print "read x.dat, y.dat, z.dat"

x = map(float, open('x.dat','r').read().split())
y = map(float, open('y.dat','r').read().split())
z = map(float, open('z.dat','r').read().split())

print "x : ",x
print "y : ",y
print "z : ",z

nx=len(x)
ny=len(y)
nz=len(z)

print "nx : ",nx
print "ny : ",ny
print "nz : ",nz

print "make blockMeshDict"

file = open('system/blockMeshDict','w')
file.write("\
FoamFile\n\
{\n\
    version     2.0;\n\
    format      ascii;\n\
    class       dictionary;\n\
    object      blockMeshDict;\n\
}\n\
convertToMeters 1;\n\
vertices\n\
(\n\
        (0 0 0) // 0\n\
        (1 0 0) // 1\n\
        (1 1 0) // 2\n\
        (0 1 0) // 3\n\
        (0 0 1) // 4\n\
        (1 0 1) // 5\n\
        (1 1 1) // 6\n\
        (0 1 1) // 7\n\
);\n\
blocks\n\
(\n\
    hex (0 1 2 3 4 5 6 7) ("+repr(nx-1)+" "+repr(ny-1)+" "+repr(nz-1)+") simpleGrading (1 1 1)\n\
);\n\
patches\n\
(\n\
    patch x_\n\
       ((0 4 7 3))\n\
    patch _x\n\
       ((2 6 5 1))\n\
    patch y_\n\
       ((1 5 4 0))\n\
    patch _y\n\
       ((3 7 6 2))\n\
    patch z_\n\
       ((0 3 2 1))\n\
    patch _z\n\
       ((4 5 6 7))\n\
);\n\
mergePatchPairs ();\n\
")
file.close()

print "run blockMesh"
commands.getstatusoutput('rm -rf constant/polyMesh/*')
ret=commands.getstatusoutput('blockMesh -noFunctionObjects 2>&1 > log.blockMesh')

if ret[0]!=0:
   print "Error in excuting blockMesh."
   exit(ret[0])

#points
print "replace points"
file=open('constant/polyMesh/points','w')
file.write("\
FoamFile\n\
{\n\
    version     2.0;\n\
    format      ascii;\n\
    class       vectorField;\n\
    location    \"constant/polyMesh\";\n\
    object      points;\n\
}\n\
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //\n\
")
file.write("\n"+str(nx*ny*nz)+"\n(\n")
for k in range(nz): 
   for j in range(ny): 
      for i in range(nx): 
         vertices="("+str(x[i])+" "+str(y[j])+" "+str(z[k])+")\n"
         file.write(vertices)
file.write( ")\n" )
file.close()

print "End"
