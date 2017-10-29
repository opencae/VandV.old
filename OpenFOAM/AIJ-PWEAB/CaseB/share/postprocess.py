#!/usr/bin/env python
#    This file is part of caseB.
#
#    caseB is free software: you can redistribute it and/or modify it
#    under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    caseB is distributed in the hope that it will be useful, but
#    WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with caseB.  If not, see <http://www.gnu.org/licenses/>.

# postprocess.py - Reorder locations and calculate scalar velocity ratio.
# Copyright (c) 2010 Takuya OSHIMA <oshima@eng.niigata-u.ac.jp>.

from math import sqrt
from os import listdir
from sys import argv

V0 = 3.11 # velocity to normalize (m/s)

if (len(argv) != 2):
    print 'Turbulence model must be specified as an argument.'

model = argv[1]
#setsDir = 'sets.' + model
setsDir = 'postProcessing/sets'
measuredDir = '../share/measured'

def isnumber(x):
  try:
    float(x)
  except ValueError:
    return False
  return True

def latestTimeDir(directory):
    a = filter(isnumber, listdir(directory))
    a.sort(lambda x, y: cmp(float(x), float(y)))
    return a[-1]

################################################################################
# Plot normalized velocity at the observaton points
def reorderLocations(inData):
    originalLocations = []
    outData = []

    # Region 1
    for inLineI in range(1, 11):
        outData.append(inData[inLineI - 1])
        originalLocations.append(inLineI)
    # Region 2 (14 - 34)
    for inLineJ in range(14, 31, 8):
        for inLineI in range(inLineJ, inLineJ + 5):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    # Region 2 (42 - 86)
    for inLineJ in range(42, 82, 13):
        for inLineI in range(inLineJ, inLineJ + 6):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    # Region 3
    for inLineJ in range(38, 104, 13):
        for inLineI in range(inLineJ, inLineJ + 4):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    # Region 4 (11 - 13)
    for inLineI in range(11, 14):
        outData.append(inData[inLineI - 1])
        originalLocations.append(inLineI)
    # Region 4 (19 - 37)
    for inLineJ in range(19, 36, 8):
        for inLineI in range(inLineJ, inLineJ + 3):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    # Region 4 (48 - 89)
    for inLineJ in range(48, 88, 13):
        for inLineI in range(inLineJ, inLineJ + 3):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    # Region 5
    for inLineJ in range(94, 108, 13):
        for inLineI in range(inLineJ, inLineJ + 9):
            outData.append(inData[inLineI - 1])
            originalLocations.append(inLineI)
    return originalLocations, outData

def calcNormalizedScalarVelocity(outDataI):
    return sqrt(sum(x * x for x in map(float, outDataI.split()[3:6]))) / V0

# Process experiment data
inExpFile = open(measuredDir + '/UMeasuredHorizontal.txt')
inExpData = inExpFile.readlines()
inExpFile.close()
originalLocations, outExpData = reorderLocations(inExpData)
outExpData = map(calcNormalizedScalarVelocity, outExpData)

# Process CFD data
inCFDFile = open(setsDir + '/' + latestTimeDir(setsDir) + '/horizontal_U.xy')
inCFDData = inCFDFile.readlines()
inCFDFile.close()
originalLocations, outCFDData = reorderLocations(inCFDData)
outCFDData = map(calcNormalizedScalarVelocity, outCFDData)

# write line number, original location, experiment data and CFD data
outFile = open('horizontal_U_processed_' + model + '.txt', 'w')
for lineI in range(len(outCFDData)):
    outFile.write(str(lineI + 1) + ' ' + str(originalLocations[lineI]) + ' '
                  + str(outExpData[lineI]) + ' ' + str(outCFDData[lineI])
                  + '\n')
outFile.close()

################################################################################
# Plot vertical profile
def calcVertProf(outExpData, outCFDData, inExpData, inCFDData,
                               line1, line2, factor):
    for lineI in range(line1, line2):
        expUx = float(inExpData[lineI].split()[3])
        cfdDataI = inCFDData[lineI].split()
        x, z, Ux = (float(cfdDataI[0]), float(cfdDataI[2]), float(cfdDataI[3]))
        outExpData.append(str(x + expUx * factor) + ' ' + str(z) + '\n')
        outCFDData.append(str(x + Ux * factor) + ' ' + str(z) + '\n')

    outExpData.append('\n')
    outCFDData.append('\n')

def verticalProfile(cfdFileName, expFileName, factor):
    inExpFile = open(measuredDir + '/' + expFileName + '.txt')
    inExpData = inExpFile.readlines()
    inExpFile.close()

    inCFDFile = open(setsDir + '/' + latestTimeDir(setsDir) + '/' + cfdFileName
                     + '.xy')
    inCFDData = inCFDFile.readlines()
    inCFDFile.close()

    outExpData = []
    outCFDData = []
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 0, 13, factor)
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 19, 25, factor)
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 44, 57, factor)
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 57, 70, factor)
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 70, 83, factor)
    calcVertProf(outExpData, outCFDData, inExpData, inCFDData, 83, 96, factor)

    outExpFile = open(expFileName + '_processed_' + model + '.txt', 'w')
    outExpFile.writelines(outExpData)
    outExpFile.close()
    outCFDFile = open(cfdFileName + '_processed_' + model + '.txt', 'w')
    outCFDFile.writelines(outCFDData)
    outCFDFile.close()

verticalProfile('vertical_U', 'UMeasuredVertical', 0.03 / V0)
verticalProfile('vertical_k', 'kMeasuredVertical', 0.03)

################################################################################
# Calculate reattachment distance
inCenterFile = open(setsDir +  '/' + latestTimeDir(setsDir) + '/center_U.xy')
inCenterData = inCenterFile.readlines()
inCenterFile.close()
inExpFile = open(measuredDir + '/UMeasuredHorizontal.txt')
inExpData = inExpFile.readlines()
inExpFile.close()

xOld, UxOld = (0., 0.)
for lineI in inCenterData:
    dataI = lineI.split()
    x, Ux = (float(dataI[0]), float(dataI[1]))
    if (Ux > 0.):
        b = 0.05 # width of the block
        Xf = (UxOld * x - Ux * xOld) / (UxOld - Ux) - b / 2.
        print 'Reattachment distance X_F = ', Xf, '[m]'
        break
    xOld, UxOld = (x, Ux)
