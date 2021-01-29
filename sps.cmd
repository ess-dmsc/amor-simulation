#!/usr/local/bin/iocsh

require s7plcFW

< envPaths

## Template
#s7plcFWConfigure (sps7-1, IPaddr, "fetchPort,fetchOrg,fetchDb,fetchOffsetInDb,fetchSizeOfDb" , "writePort,writeOrg,writeDb,writeOffsetInDb,writeSizeOfDb", bigEndian,recvTimeout, recvDelay, outIOintDelay)

## Debug + sockspy
#s7plcFWConfigure ("spss7-read1", "127.0.0.1", "8090,1,200,0,5034", "8080,1,200,0,0", 0,1000, 1000,1000)
#s7plcFWConfigure ("spss7-read2", "127.0.0.1", "8091,1,201,0,5034", "8081,1,201,0,0", 0,1000, 1000,1000)
#s7plcFWConfigure ("spss7-write", "127.0.0.1", "8092,1,210,0,8", "8082,1,210,0,8", 0,1000, 1000,1000)


s7plcFWConfigure ("SPS-R1", "172.28.65.35", "2000,1,200,0,5034", "2001,1,200,0,0", 0,1000, 200,1000)
s7plcFWConfigure ("SPS-R2", "172.28.65.35", "2000,1,201,0,5034", "2001,1,201,0,0", 0,1000, 200,100)
s7plcFWConfigure ("SPS-W", "172.28.65.35", "2000,1,210,0,8", "2001,1,210,0,8 writeall", 0,1000, 200,100)

dbLoadTemplate("$(TOP)/sps.substitutions")
dbLoadRecords("$(TOP)/db/s7plcFW_mcu1.db")
dbLoadRecords("$(TOP)/db/s7plcFW_read1.db","PREFIX=SQ:AMOR:SEL2:")

