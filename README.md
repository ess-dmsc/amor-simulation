# EPICS ioc for the AMOR Selene guide PLC

This repository contains:
 - `s7plc.cmd` the IOC script to run the PLC
	- `s7plcFW.db` the EPICS database
	- documentation for the motors and the PLC implementation
 - python scripts to compose the fetch (`create_read.py`) and write (`create_write.py`) part of the DB

## Usage
Configure the IOC script, then
```
./s7plc.cmd
```
To enable debug use `var s7plcFWDebug <level>` where level can be
 - **-1**: fatal errors only
 - **0**: errors only
 - **1** startup messages
 - **2** + output record processing
 - **3** + inputput record processing
 - **4** + driver calls
 - **5** + io printout

## Configure s7plcFW.db

:warning: The driver works using WORDS, not BYTES.

### write

We have to ignore the firt two bytes of the DB. Then starts the status of P1..4. 
:warning: Sice we have to use WORDS:
- Pitch 1:  00000000 00000001 -> field(OUT, "@$(SPS-W)/2+1 T=WORD B=0")       [[0x0][0x1]] 
- Pitch 2:  00000000 00000010 -> field(OUT, "@$(SPS-W)/2+1 T=WORD B=1")       [[0x0][0x2]]
- ...
- Pitch 8:  00000000 10000000 -> field(OUT, "@$(SPS-W)/2+1 T=WORD B=8 :question: ")
- Pitch 9:  00000001 00000000 -> field(OUT, "@$(SPS-W)/2+0 T=WORD B=0")       [[0x1][0x0]] :question: 
- ...

The transition happens when the SPS receives "1" at the correct bit. I.e. acts as a toggle, not as a set.
This can raise a mismatch w/ EPICS: 

| Px_t | Command |  Selected    |Px_t+1  |
| ---  |  -----  | ------------ |------- |
|  0   |     1   |     1        |  1     |
|  1   |     0   |     1        |  0     |   
|  1   |     1   |     0        |  1     |
|  0   |     0   |     0        |  0     |


### TODO
- [ ] use mbbo instead of bo?
- [ ] fix al other addresses of Select:Px


## s7plcFW EPICS driver

- source: https://git.psi.ch/epics_driver_modules/s7plcFW
- documentation: https://intranet.psi.ch/pub/Controls/S7plcFW/s7plcFW.html

