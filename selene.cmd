#!/usr/local/bin/iocsh

require sinq, koennecke

< envPaths

#-------------------- Configuration for Selene

#pmacAsynIPConfigure("portsel2","129.129.138.237:1025")
pmacAsynIPConfigure("portsel2","172.28.65.25:1025")

SeleneCreateController("sel2","portsel2",0,8,200,10000);
SeleneCreateAxis("sel2",8,1.1);
SeleneCreateAxis("sel2",7,1.1);
#LiftCreateAxis("sel2",1);
#LiftCreateAxis("sel2",2);
#LiftCreateAxis("sel2",3);
#LiftCreateAxis("sel2",4);
#LiftCreateAxis("sel2",5);
#LiftCreateAxis("sel2",6);

dbLoadTemplate("$(TOP)/sel2.substitutions")
dbLoadRecords("$(TOP)/db/asynRecord.db","P=SQ:AMOR:,R=SEL2,PORT=portsel2,ADDR=0,OMAX=80,IMAX=80")
