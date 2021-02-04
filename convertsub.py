#!/usr/bin/python
"""
This is a little program which generates soft motor initialisation lines and iocsh morsels
from a motor substitutions file. 

Mark Koennecke, December 2019 
"""
import sys
import pdb
import os

if len(sys.argv) < 2:
    print('Usage:\n\tconvertsub XXXX.substitutions')
    sys.exit(1)

subLen = 0
motors = []
port = None

with open(sys.argv[1], 'r') as fin:
    line = fin.readline()
    while line:
        line = line.replace(' ', '')
        line = line.strip('{}')
        l = line.split(',')
        if line.find('DHLM') > 0:  # that is the index discovery line
            lowlimidx = l.index('DLLM')
            highlimidx = l.index('DHLM')
            mresidx = l.index('MRES')
            addridx = l.index('ADDR')
            prefix = l[0]
            subLen = len(l)
            portIdx = l.index('PORT')
        elif subLen > 0:
            l = line.split(',')
            if subLen == len(l):
                motors.append(
                    (l[addridx], l[mresidx], l[lowlimidx], l[highlimidx]))
                port = l[portIdx]
        else:
            pass
        line = fin.readline()

print('%d motors found' % len(motors))

fname = os.path.splitext(sys.argv[1])[0] + '.cmd'

out = open(fname, 'w')
out.write('motorSimCreateController(\"%s\",%d)\n' % (port, len(motors)+2))
for mot in motors:
    mres = float(mot[1])
    highlim = int(float(mot[3])/mres)
    lowlim = int(float(mot[2])/mres)
    out.write('motorSimConfigAxis(\"%s\",%s,%d,%d,0,0)\n' %
              (port, mot[0], highlim, lowlim))
out.write('dbLoadTemplate(\"$(TOP)/%s\")\n' % (sys.argv[1]))
out.close()
print(fname + ' written')
