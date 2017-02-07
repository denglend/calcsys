RefAddrs:
       dw     _AnsName             ;AnsName
 IFNDEF ION
       dw     _ApdSetup            ;ApdSetup
 ENDIF
 IFDEF TI83P
       dw     _Arc_Unarc           ;ArcUnarc
 ENDIF
       dw     _ChkFindSym          ;ChkFindSym
       dw     _ClrLCDFull          ;ClrLCDFull
       dw     _ClrScrnFull         ;ClrScrnFull
       dw     _ClrTxtShd           ;ClrTxtShd
       dw     _CpHLDE              ;CpHLDE
       dw     _CreateProg          ;CreateProg
 IFDEF TI83P
       dw     _CreateProtProg      ;CreateProtProg
 ENDIF
       dw     _DelMem              ;DelMem
       dw     _DelRes
       dw     _DelVar
 IFDEF TI83P
       dw     _DelVarArc
 ENDIF
 IFNDEF ION
       dw     _DisableAPD
 ENDIF
       dw     _DispHL
       dw     _DispOP1A
       dw     _DivHLByA
 IFNDEF ION
       dw     _EnableAPD
 ENDIF
       dw     _EnoughMem
       dw     _FindSym
 IFDEF TI83P
       dw     _FlashToRam
 ENDIF
       dw     _GetCSC
       dw     _GetKey
       dw     _GrBufClr
       dw     _GrBufCpy
       dw     _HTimesL
       dw     _HomeUp
       dw     _InsertMem
       dw     _LdHLInd
 IFDEF TI83P
       dw     _LoadCIndPaged
       dw     _LoadDEIndPaged
 ENDIF
       dw     _MemChk
 IFNDEF ION
       dw     _MemClear
       dw     _MemSet
 ENDIF
       dw     _NewLine
       dw     _ParseInp
       dw     _PutC
       dw     _PutMap
       dw     _PutPS
       dw     _PutS
       dw     _RclAns
       dw     _StoAns
       dw     _SetXXOP1
       dw     _SetXXOP2
       dw     _SetXXXXOP2
       dw     _StrCopy
       dw     _StrLength
       dw     _VPutMap
       dw     _VPutS
       dw     _VPutSN
 IFNDEF ION
       dw     ramCode
       dw     tempSwapArea
 ENDIF
       dw     kbdScanCode
       dw     contrast
       dw     curRow
       dw     curCol
       dw     OP1
       dw     OP2
       dw     OP3
       dw     OP4
       dw     OP5
       dw     OP6
       dw     textShadow
       dw     penCol
       dw     penRow
       dw     flags
       dw     statVars
       dw     plotSScreen
       dw     cmdShadow
       dw     pTemp
       dw     progPtr
 IFNDEF ION
       dw     appBackUpScreen
 ENDIF
       dw     symTable
       dw     saveSScreen
NumRefAddrs   equ      ($-RefAddrs)/2

RefDescs:
       db     "ANSNAME",0
 IFNDEF ION
       db     "APDSETUP",0
 ENDIF
 IFDEF TI83P
       db     "ARCUNARC",0
 ENDIF
       db     "CHKFINDSYM",0
       db     "CLRLCDFULL",0
       db     "CLRSCRNFULL",0
       db     "CLRTXTSHD",0
       db     "CPHLDE",0
       db     "CREATEPROG",0
 IFDEF TI83P
       db     "CREATEPROTPROG",0
 ENDIF
       db     "DELMEM",0
       db     "DELRES",0
       db     "DELVAR",0
 IFDEF TI83P
       db     "DELVARARC",0
 ENDIF
 IFNDEF ION
       db     "DISABLEAPD",0
 ENDIF
       db     "DISPHL",0
       db     "DISPOP1A",0
       db     "DIVHLBYA",0
 IFNDEF ION
       db     "ENABLEAPD",0
 ENDIF
       db     "ENOUGHMEM",0
       db     "FINDSYM",0
 IFDEF TI83P
       db     "FLASHTORAM",0
 ENDIF
       db     "GETCSC",0
       db     "GETKEY",0
       db     "GRBUFCLR",0
       db     "GRBUFCPY",0
       db     "HTIMESL",0
       db     "HOMEUP",0
       db     "INSERTMEM",0
       db     "LDHLIND",0
 IFDEF TI83P
       db     "LOADCINDPAGED",0
       db     "LOADDEINDPAGED",0
 ENDIF
       db     "MEMCHK",0
 IFNDEF ION
       db     "MEMCLEAR",0
       db     "MEMSET",0
 ENDIF
       db     "NEWLINE",0
       db     "PARSEINP",0
       db     "PUTC",0
       db     "PUTMAP",0
       db     "PUTPS",0
       db     "PUTS",0
       db     "RCLANS",0
       db     "SETXXOP1",0
       db     "SETXXOP2",0
       db     "SETXXXXOP2",0
       db     "STOANS",0
       db     "STRCOPY",0
       db     "STRLENGTH",0
       db     "VPUTMAP",0
       db     "VPUTS",0
       db     "VPUTSN",0
 IFNDEF ION
       db     "RAMCODE",0
       db     "TEMPSWAPAREA",0
 ENDIF
       db     "KBDSCANCODE",0
       db     "CONTRAST",0
       db     "CURROW",0
       db     "CURCOL",0
       db     "OP1",0
       db     "OP2",0
       db     "OP3",0
       db     "OP4",0
       db     "OP5",0
       db     "OP6",0
       db     "TEXTSHADOW",0
       db     "PENCOL",0
       db     "PENROW",0
       db     "FLAGS",0
       db     "STATVARS",0
       db     "PLOTSSCREEN",0
       db     "CMDSHADOW",0
       db     "PTEMP",0
       db     "PROGPTR",0
 IFNDEF ION
       db     "APPBACKUPSCREEN",0
 ENDIF
       db     "SYMTABLE",0
       db     "SAVESSCREEN",0

