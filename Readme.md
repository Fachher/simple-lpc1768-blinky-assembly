
Requirements (OSX)
==
- JLink_MacOSX_V510f.pkg

- Show all USB devices
ioreg -l -p  IOUSB


Location of JLink
/Applications/SEGGER/JLink/libjlinkarm.4.dylib

EGGER J-Link Commander V5.10f (Compiled Dec 22 2015 14:25:20)
DLL version V5.10f, compiled Dec 22 2015 14:25:14

Connecting to J-Link via USB...O.K.
Firmware: J-Link ARM-OB STM32 compiled Aug 22 2012 19:52:04
Hardware version: V7.00
S/N: 20090928
License(s): RDI,FlashDL,FlashBP,JFlash,GDBFull
Emulator has Trace capability
VTref = 3.300V


Type "connect" to establish a target connection, '?' for help
J-Link>device LPC1768
Please specify target interface:
  J) JTAG (Default)
    S) SWD
    TIF>S
    Specify target interface speed [kHz]. <Default>: 4000 kHz
    Speed>100
    Device "LPC1768" selected.


    Found SWD-DP with ID 0x2BA01477
    Found Cortex-M3 r2p0, Little endian.
    FPUnit: 6 code (BP) slots and 2 literal slots
    CoreSight components:
    ROMTbl 0 @ E00FF000
    ROMTbl 0 [0]: FFF0F000, CID: B105E00D, PID: 002BB000 SCS
    ROMTbl 0 [1]: FFF02000, CID: B105E00D, PID: 002BB002 DWT
    ROMTbl 0 [2]: FFF03000, CID: B105E00D, PID: 002BB003 FPB
    ROMTbl 0 [3]: FFF01000, CID: B105E00D, PID: 002BB001 ITM
    ROMTbl 0 [4]: FFF41000, CID: B105900D, PID: 002BB923 TPIU-Lite
    ROMTbl 0 [5]: FFF42000, CID: B105900D, PID: 002BB924 ETM-M3
    Cortex-M3 identified.
    J-Link>erase
    Erasing device (LPC1768)...
    Comparing flash   [100%] Done.
    Erasing flash     [100%] Done.
    Verifying flash   [100%] Done.
    J-Link: Flash download: Total time needed: 4.151s (Prepare: 0.716s, Compare: 0.000s, Erase: 3.331s, Program: 0.000s, Verify: 0.000s, Restore: 0.102s)
    Erasing done.
    J-Link>loadbin /tmp/led.bin, 0x0
    Downloading file [/tmp/led.bin]...Comparing flash   [100%] Done.
    Erasing flash     [100%] Done.
    Programming flash [100%] Done.
    Verifying flash   [100%] Done.
    J-Link: Flash download: Flash programming performed for 1 range (4096 bytes)
    J-Link: Flash download: Total time needed: 1.738s (Prepare: 1.060s, Compare: 0.025s, Erase: 0.000s, Program: 0.108s, Verify: 0.005s, Restore: 0.538s)
    O.K.
    J-Link>r
    Reset delay: 0 ms
    Reset type NORMAL: Resets core & peripherals via SYSRESETREQ & VECTRESET bit.
    J-Link>g
    J-Link>h
    PC = 0000001C, CycleCnt = 00000000
    R0 = 00000000, R1 = 0000001D, R2 = 00000000, R3 = 00000000
    R4 = 3456ABCD, R5 = 3456ABCD, R6 = 12345678, R7 = 6A3195CE
    R8 = 1EE6A01D, R9 = 0E94D50C, R10= 161CD99B, R11= FFF0A918
    R12= 00000107
    SP(R13)= 10004000, MSP= 10004000, PSP= 9F7D144C, R14(LR) = 1FFF0D5F
    XPSR = 61000000: APSR = nZCvq, EPSR = 01000000, IPSR = 000 (NoException)
    CFBP = 00000000, CONTROL = 00, FAULTMASK = 00, BASEPRI = 00, PRIMASK = 00
    J-Link>verifybin /tmp/led.bin, 0x0
    Loading binary file /tmp/led.bin
    Reading 100 bytes data from target memory @ 0x00000000.
    Verify failed @ address 0x0000001C.
    Expected 0C read 8AJ-Link>⏎                                                                                                                                                     fachhersyed@Fachhers-MBP ~/P/w/a/simple-led-example> cd ..
    fachhersyed@Fachhers-MBP ~/P/w/assembler_examples>
