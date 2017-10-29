#!/usr/bin/python
import commands
commands.getstatusoutput('rm constant/polyMesh')
commands.getstatusoutput('mkdir constant/polyMesh')
nx = 0
ny = 0
nz = 0
xfile = open('x.dat','r')
for xline in xfile:
   nx = nx + 1
yfile = open('y.dat','r')
for yline in yfile:
   ny = ny + 1
zfile = open('z.dat','r')
for zline in zfile:
   nz = nz + 1
nxny = nx * ny
nynz = ny * nz
nxnz = nx * nz
all = nx * ny * nz

print "set points"
pointFile = open('constant/polyMesh/points','w')
pointFile.write("FoamFile\n{ \n\
    version \t 2.0;\n\
    format \t ascii;\n\n\
    root \t \"\";\n\
    case \t \"\";\n\
    instance \t \"constant\";\n\
    local \t \"polyMesh\";\n\n\
    class \t vectorField;\n\
    object \t points;\n\
}\n")

#points

pointFile.write( repr(all)+"\n(\n" )
k=1
count=0
zfile.seek(0)
while k <= nz :
   z = zfile.readline()
   j = 1
   yfile.seek(0)
   while j <= ny :
      y = yfile.readline()
      i = 1
      xfile.seek(0)
      while i <= nx :
         x = xfile.readline()
         vertices="( "+x[:-1]+" "+y[:-1]+" "+z[:-1]+" )\n"
         pointFile.write(vertices)
         i = i + 1
         count = count + 1
      j = j + 1
   k = k + 1
pointFile.write( ")\n" )
pointFile.close()
print "end points"

print "set face - owner - neigubour"
allface = 3*all -2*(nxny+nynz+nxnz) + nx + ny +nz

faceFile = open('constant/polyMesh/faces','w')
faceFile.write("FoamFile\n{ \n\
    version \t 2.0;\n\
    format \t ascii;\n\n\
    root \t \"\";\n\
    case \t \"\";\n\
    instance \t \"constant\";\n\
    local \t \"polyMesh\";\n\n\
    class \t faceList;\n\
    object \t faces;\n\
}\n")
ownerFile = open('constant/polyMesh/owner','w')
ownerFile.write("FoamFile\n{ \n\
    version \t 2.0;\n\
    format \t ascii;\n\n\
    root \t \"\";\n\
    case \t \"\";\n\
    instance \t \"constant\";\n\
    local \t \"polyMesh\";\n\n\
    class \t labelList;\n\n\
    note \t \"nCells:"+repr((nx-1)*(ny-1)*(nz-1)) \
                +" nActiveFaces:"+repr(allface) \
                +" nActivePoints:"+repr(all)+"\";\n\n\
    object \t owner;\n\
}\n")
neighbourFile = open('constant/polyMesh/neighbour','w')
neighbourFile.write("FoamFile\n{ \n\
    version \t 2.0;\n\
    format \t ascii;\n\n\
    root \t \"\";\n\
    case \t \"\";\n\
    instance \t \"constant\";\n\
    local \t \"polyMesh\";\n\n\
    class \t labelList;\n\n\
    note \t \"nCells:"+repr((nx-1)*(ny-1)*(nz-1)) \
                +" nActiveFaces:"+repr(allface) \
                +" nActivePoints:"+repr(all)+"\";\n\n\
    object \t neighbour;\n\
}\n")

#faces
faceFile.write( repr(allface)+"\n(\n" )
ownerFile.write( repr(allface)+"\n(\n" )
neighbourFile.write( repr(allface)+"\n(\n" )
#faces x+
k = 1
while k < nz :
   j = 1
   while j < ny :
      i = 2
      while i < nx :
         p1 = nxny * ( k - 1 ) + nx * ( j - 1 ) + i -1
         p2 = nxny * ( k - 1 ) + nx * j + i -1
         p3 = nxny * k + nx * j + i -1
         p4 = nxny * k + nx * ( j - 1 ) + i -1

         faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

         p = (nx-1)*(ny-1) * ( k - 1 ) + (nx-1) * ( j - 1 ) + i -2 
         ownerFile.write( repr(p)+"\n" )
         np = (nx-1)*(ny-1) * ( k - 1 ) + (nx-1) * ( j - 1 ) + i -1 
         neighbourFile.write( repr(np)+"\n" )

         i = i + 1
      j = j+ 1
   k = k + 1

#faces y+
k = 1
while k < nz :
   j = 2
   while j < ny :
      i = 1
      while i < nx :
         p1 = nxny * ( k - 1 ) + nx * ( j - 1 ) + i -1
         p2 = nxny * k + nx * ( j - 1 ) + i -1
         p3 = nxny * k + nx * ( j - 1 ) + i
         p4 = nxny * ( k - 1 ) + nx * ( j - 1 ) + i

         faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )
         p = (nx-1)*(ny-1) * (k - 1) + (nx-1) * ( j - 2 ) + i -1
         ownerFile.write( repr(p)+"\n" )
         np= (nx-1)*(ny-1) * (k - 1) + (nx-1) * ( j - 1 ) + i -1         
         neighbourFile.write( repr(np)+"\n" )

         i = i + 1
      j = j+ 1
   k = k + 1

#faces z+
k = 2
while k < nz :
   j = 1
   while j < ny :
      i = 1
      while i < nx :
         p1 = nxny * ( k - 1 ) + nx * ( j - 1 ) + i -1
         p2 = nxny * ( k - 1 ) + nx * ( j - 1 ) + i
         p3 = nxny * ( k - 1 ) + nx * j + i
         p4 = nxny * ( k - 1 ) + nx * j + i -1

         faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )
         p = (nx-1)*(ny-1) * (k - 2) + (nx-1) * ( j - 1 ) + i -1
         ownerFile.write( repr(p)+"\n" )
         np= (nx-1)*(ny-1) * (k - 1) + (nx-1) * ( j - 1 ) + i -1
         neighbourFile.write( repr(np)+"\n" )

         i = i + 1
      j = j+ 1
   k = k + 1

#patches
np = -1
#patches x-
k = 1
while k < nz :
   j = 1
   while j < ny :
      p1 = nxny * (k -1) + nx * (j -1)
      p2 = nxny * k + nx * (j -1)
      p3 = nxny * k + nx * j
      p4 = nxny * (k -1) + nx * j
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p= (nx-1)*(ny-1) * (k - 1) + (nx-1) * ( j - 1 ) 
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1)*(ny-1) * (k - 1) + (nx-1) * ( j - 1 ) 
      neighbourFile.write( repr(np)+"\n" )

      j = j+ 1
   k = k + 1

#patches x+
k = 1
while k < nz :
   j = 1
   while j < ny :
      p1 = nxny * (k -1) + nx * j -1
      p2 = nxny * (k -1) + nx * (j + 1) -1
      p3 = nxny * k + nx * (j +1) -1
      p4 = nxny * k + nx * j -1
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p = (nx-1)*(ny-1) * (k -1) + (nx-1) * j -1
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1)*(ny-1) * (k -1) + (nx-1) * j -1
      neighbourFile.write( repr(np)+"\n" )

      j = j+ 1
   k = k + 1

#patches y-
k = 1
while k < nz :
   i = 1
   while i < nx :
      p1 = nxny * (k -1) + (i -1)
      p2 = nxny * (k -1) + i
      p3 = nxny * k + i
      p4 = nxny * k + (i -1)
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p = (nx-1)*(ny-1) * (k -1) + (i -1)
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1)*(ny-1) * (k -1) + (i -1)
      neighbourFile.write( repr(np)+"\n" )

      i = i+ 1
   k = k + 1

#patches y+
k = 1
while k < nz :
   i = 1
   while i < nx :
      p1 = nxny * k -nx + (i -1)
      p2 = nxny *( k + 1) -nx + (i -1)
      p3 = nxny * (k + 1) -nx + i
      p4 = nxny * k -nx + i
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p = (nx-1)*(ny-1) * k -(nx-1) + (i -1)
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1)*(ny-1) * k -(nx-1) + (i -1)
      neighbourFile.write( repr(np)+"\n" )

      i = i+ 1
   k = k + 1

#patches z-
j = 1
while j < ny :
   i = 1
   while i < nx :
      p1 = nx * ( j - 1 ) + i -1
      p2 = nx * j + i -1
      p3 = nx * j + i 
      p4 = nx * ( j - 1 ) + i 
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p = (nx-1) * ( j - 1 ) + i -1
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1) * ( j - 1 ) + i -1
      neighbourFile.write( repr(np)+"\n" )

      i = i+ 1
   j = j + 1

#patches z+
j = 1
while j < ny :
   i = 1 
   while i < nx :
      p1 = nxny * (nz -1) + nx * ( j - 1 ) + i -1
      p2 = nxny * (nz -1) + nx * ( j - 1 ) + i 
      p3 = nxny * (nz -1) + nx * j + i 
      p4 = nxny * (nz -1) + nx * j + i -1
      faceFile.write( "4("+repr(p1)+" "+repr(p2)+" "+repr(p3)+" "+repr(p4)+")\n" )

      p = (nx-1)*(ny-1)*(nz -2) + (nx-1) * ( j - 1 ) + i -1
      ownerFile.write( repr(p)+"\n" )
#      np = (nx-1)*(ny-1)*(nz -2) + (nx-1) * ( j - 1 ) + i -1
      neighbourFile.write( repr(np)+"\n" )

      i = i+ 1
   j = j + 1
faceFile.write( ")\n" )
ownerFile.write( ")\n" )
neighbourFile.write( ")\n" )

faceFile.close()
ownerFile.close()
neighbourFile.close()
print "end face - owner - neigubour"
print "set boundary"
##boundary
boundaryFile = open('constant/polyMesh/boundary','w')
boundaryFile.write("FoamFile\n{ \n\
    version \t 2.0;\n\
    format \t ascii;\n\n\
    root \t \"\";\n\
    case \t \"\";\n\
    instance \t \"constant\";\n\
    local \t \"polyMesh\";\n\n\
    class \t polyBoundaryMesh;\n\
    object \t boundary;\n\
}\n")
#faces
boundaryFile.write("6\n(\n")
startFace=(nx-2)*(ny-1)*(nz-1)+(nx-1)*(ny-2)*(nz-1)+(nx-1)*(ny-1)*(nz-2)
#patches x-
nfaces=(ny-1)*(nz-1)
boundaryFile.write( "x_\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" ) 
#patches x+
startFace +=  nfaces
nfaces=(ny-1)*(nz-1)
boundaryFile.write( "_x\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" )
#patches y-
startFace +=  nfaces
nfaces=(nx-1)*(nz-1)
boundaryFile.write( "y_\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" )
#patches y+
startFace +=  nfaces
nfaces=(nx-1)*(nz-1)
boundaryFile.write( "_y\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" )
#patches z-
startFace +=  nfaces
nfaces=(nx-1)*(ny-1)
boundaryFile.write( "z_\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" )
#patches z+
startFace +=  nfaces
nfaces=(nx-1)*(ny-1)
boundaryFile.write( "_z\n{\n\t type patch;\n\t nFaces "+repr(nfaces)+";\n\t startFace "+repr(startFace)+";\n}\n\n" )
boundaryFile.write(")\n")

boundaryFile.close()
print "make Mesh end"
##print "renumbering Mesh"

##commands.getstatusoutput('renumberMesh > log.renumerMesh 2>&1 ')
##commands.getstatusoutput('checkMesh > log.checkMesh 2>&1 ')
##commands.getstatusoutput('gzip constant/polyMesh/*')
print "end"
