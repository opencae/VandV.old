#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import numpy as np
import argparse
import math
import os

# constants
SMALL=1e-15
turbulentFiles=['k','epsilon','omega']

# common header
commonHeader = """\
/*--------------------------------*- C++ -*----------------------------------*\\
| =========                 |                                                 |
| \\\\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\\\    /   O peration     | Version:  x.x                                   |
|   \\\\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\\\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
"""
commonFooter = """\

// ************************************************************************* //
"""

def parser():
    p = argparse.ArgumentParser()
    p.add_argument('-w','--windDirectionDegree',help='Wind direction in degree', type=float, default=0.0)
    p.add_argument('inflowFilename')
    p.add_argument('-x','--xmin',help='Minimum x of boundary patch', type=float, default=0.0)
    p.add_argument('-X','--xmax', help='Maximum x of boundary patch', type=float, default=1.0)
    p.add_argument('-y','--ymin', help='Minimum y of boundary patch', type=float, default=0.0)
    p.add_argument('-Y','--ymax', help='Maximum y of boundary patch', type=float, default=1.0)
    p.add_argument('-d','--writeChangeDictionaryDict', help='Write changeDictionaryDict'
                       , action="store_true", default=False)
    p.add_argument('-z','--scalez', help='Scaling factor for z', type=float, default=1)
    p.add_argument('-U','--scaleU', help='Scaling factor for U', type=float, default=1)
    p.add_argument('-k','--scalek', help='Scaling factor for k', type=float, default=1)
    p.add_argument('-C','--Cmu', help='Cmu', type=float, default=0.09)
    p.add_argument('-s','--skipHeader'
                       , help='Number of lines to skip at the beginning of the file', type=int, default=0)
    p.add_argument("--zAppendFirst", help='Append z at first', type=float, nargs='+')
    p.add_argument("--UAppendFirst", help='Append U at first', type=float, nargs='+')
    p.add_argument("--kAppendFirst", help='Append k at first', type=float, nargs='+')
    p.add_argument("--zAppendLast", help='Append z at last', type=float, nargs='+')
    p.add_argument("--UAppendLast", help='Append U at last', type=float, nargs='+')
    p.add_argument("--kAppendLast", help='Append k at last', type=float, nargs='+')
    p.add_argument('--zColumnNuber', help='Column number of z', type=int, default=1)
    p.add_argument('--UColumnNuber', help='Column number of U', type=int, default=2)
    p.add_argument('--kColumnNuber', help='Column number of k', type=int, default=3)
    return p.parse_args()

def getInflowData(args):
    # read inflow.csv
    inflow=np.genfromtxt(args.inflowFilename, delimiter=',', dtype='float', skip_header=args.skipHeader)

    # scaling
    z=inflow[:,args.zColumnNuber-1]*args.scalez
    U=inflow[:,args.UColumnNuber-1]*args.scaleU
    k=inflow[:,args.kColumnNuber-1]*args.scalek

    # append data
    if (args.zAppendFirst is not None) \
            and (args.UAppendFirst is not None) \
            and (args.kAppendFirst is not None):
        nzFirst=len(args.zAppendFirst)
        nUFirst=len(args.UAppendFirst)
        nkFirst=len(args.kAppendFirst)
        if nzFirst != nUFirst or nzFirst != nkFirst:
            print "Error: number of append data mismatch."
            exit(1)
        z=np.insert(z,0,args.zAppendFirst)
        U=np.insert(U,0,args.UAppendFirst)
        k=np.insert(k,0,args.kAppendFirst)

    if (args.zAppendLast is not None) \
            and (args.UAppendLast is not None) \
            and (args.kAppendLast is not None):
        nzLast=len(args.zAppendLast)
        nULast=len(args.UAppendLast)
        nkLast=len(args.kAppendLast)
        if nzLast != nULast or nzLast != nkLast:
            print "Error: number of append data mismatch."
            exit(1)
        z=np.insert(z,0,args.zAppendLast)
        U=np.insert(U,0,args.UAppendLast)
        k=np.insert(k,0,args.kAppendLast)

    # calculate dU/dz    
    dUdz=np.gradient(U,z,edge_order=1)

    # estimate epsilon and omega
    epsilon=math.sqrt(args.Cmu)*k*dUdz
    omega=np.zeros(len(k))
    for i in range(len(k)):
        if k[i]>SMALL:
            omega[i]=epsilon[i]/(args.Cmu*k[i])

    return z,U,[k,epsilon,omega]

def getInletPatchNames(args):
    # patchNames
    Wx=-math.cos((90-float(args.windDirectionDegree))/180*math.pi)
    Wy=-math.sin((90-float(args.windDirectionDegree))/180*math.pi)

    patchNames=[]
    slipPatcheNames=[]
    if Wx > SMALL:
        patchNames.append("x_")
    elif Wx < -SMALL:
        patchNames.append("_x")
    else:
        slipPatcheNames=["x_","_x"]

    if Wy > SMALL:
        patchNames.append("y_")
    elif Wy < -SMALL:
        patchNames.append("_y")
    else:
        slipPatcheNames=["y_","_y"]


    return patchNames, slipPatcheNames

def writeBoundaryData(args,patchNames,z,U,turbulent):
    for patchName in patchNames:
        writeBoundaryDataPatch(args,patchName,z,U,turbulent)

def writeBoundaryDataPatch(args,patchName,z,U,turbulent):
    
    # points
    header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       vectorField;
    object      points;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

(
"""

    path='constant/boundaryData'
    if not os.path.isdir(path):
        os.mkdir(path)
    path=path+'/'+patchName
    if not os.path.isdir(path):
        os.mkdir(path)
    pathTime=path+'/0'
    if not os.path.isdir(pathTime):
        os.mkdir(pathTime)
    file=open(path+'/points','w')
    file.write(commonHeader)
    file.write(header)
    file.write('// min\n')
    xmin=args.xmin
    xmax=args.xmax
    ymin=args.ymin
    ymax=args.ymax
    if patchName == 'x_':
        xmax=args.xmin
    elif patchName == '_x':
        xmin=args.xmax
    elif patchName == 'y_':
        ymax=args.ymin
    elif patchName == '_y':
        ymin=args.ymax
    for ztmp in z:
        file.write('(%g %g %g)\n' % (xmin, ymin, ztmp))
    file.write('// max\n')
    for ztmp in z:
        file.write('(%g %g %g)\n' % (xmax, ymax, ztmp))
    file.write(')\n')
    file.write(commonFooter)
    file.close()
    
    # U
    header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       vectorAverageField;
    object      values;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Average
(0 0 0)

// Data on points
"""
    
    file=open(pathTime+'/U','w')
    file.write(commonHeader)
    file.write(header)
    file.write(repr(len(U)*2)+'\n')
    file.write('(\n')
    file.write('// min\n')
    for Utmp in U:
        file.write('(%g 0 0)\n' % (Utmp))
    file.write('// max\n')
    for Utmp in U:
        file.write('(%g 0 0)\n' % (Utmp))
    file.write(')\n')
    file.write(commonFooter)
    file.close()
    
    # turbulent File
    header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       scalarAverageField;
    object      values;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Average
0

// Data on points
"""
    
    for i in range(len(turbulentFiles)):
       file=open(pathTime+'/'+turbulentFiles[i],'w')
       file.write(commonHeader)
       file.write(header)
       file.write(repr(len(turbulent[i])*2)+'\n')
       file.write('(\n')
       file.write('// min\n')
       for tmp in turbulent[i]:
           file.write('%g\n' % (tmp))
       file.write('// max\n')
       for tmp in turbulent[i]:
           file.write('%g\n' % (tmp))
       file.write(')\n')
       file.write(commonFooter)
       file.close()

def writeChangeDictionaryDict(patchNames,slipPatcheNames):
    file=open("system/changeDictionaryDict","w")
    
    # write header
    file.write(commonHeader)
    header = """\
FoamFile
{
    version 2.0;
    format  ascii;
    class   dictionary;
    object  changeDictionaryDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //"""
    file.write(header)

    for field in ['U','k','epsilon','omega','p']:
        file.write("\n\n%s\n{\n    boundaryField\n    {" % (field))
        if field == 'U':
            entry ="""\
            type            timeVaryingMappedFixedValue;
            setAverage      off;
            offset          (0 0 0);
            value           $internalField;
"""
        elif field == 'p':
            entry = """\
            type  zeroGradient;
"""
        else:
            entry ="""\
            type            timeVaryingMappedFixedValue;
            setAverage      off;
            offset          0;
            value           $internalField;
"""

        for patchName in patchNames:
            file.write('\n        %s\n        {\n%s        }' % (patchName, entry))

        for patchName in slipPatcheNames:
            file.write('\n        %s\n        {\n            type  slip;\n        }' % (patchName))

        file.write("\n    }\n}")

    file.write("\n")
    file.write(commonFooter)
    file.close()
    
if __name__ == '__main__':
    args=parser()

    z,U,turbulent = getInflowData(args)

    patchNames,slipPatcheNames = getInletPatchNames(args)

    writeBoundaryData(args, patchNames,z,U,turbulent)

    if args.writeChangeDictionaryDict:
        writeChangeDictionaryDict(patchNames,slipPatcheNames)
