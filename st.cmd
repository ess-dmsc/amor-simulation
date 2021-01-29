#!/usr/local/bin/iocsh

require s7plcFW
require sinq, koennecke
require pyDevSup, koennecke

epicsEnvSet("TOP","/ioc/sinq-ioc/amor-ioc-sim")

# mirrors 1-2, L1-6
#< sel1.cmd
#< sel2.cmd 

# Probentisch & Detector turm
< mota.cmd

# diaphragms
< mcu4.cmd

# slits
< blende.cmd

# Polarisator

# Analysator

# Deflektor

# proton current & charge
dbLoadRecords("$(TOP)/db/current.db","")
< sumIO.cmd

iocInit()

