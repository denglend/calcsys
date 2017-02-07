;Text (and other sorts of) data file for Calcsys
MainMenu:
       db     7
       dw     HexEditor
       dw     Disassemble
       dw     PortMon
       dw     SysFlags
       dw     Console
       dw     MainLoop2
       dw     Quit
 IFDEF TI83P
       db     " TI83+ Sys Info",0
 ELSE
       db     " TI-73 Sys Info",0
 ENDIF
       db     "1. Hex Editor",0
       db     "2. Disassembler",0
       db     "3. Port Monitor",0
       db     "4. System Flags",0
       db     "5. Console",0
       db     "6. More",0
       db     "7. Quit",0
MainMenu2:
       db     7
       dw     DoVAT
       dw     CharSet
       dw     KeyVals
       dw     LinkConsole
       dw     About
       dw     MainLoop
       dw     Quit
 IFDEF TI83P
       db     " TI83+ Sys Info",0
 ELSE
       db     " TI-73 Sys Info",0
 ENDIF
       db     "1. VAT",0
       db     "2. Character Set",0
       db     "3. Key Values",0
       db     "4. Link Console",0
       db     "5. About",0
       db     "6. More",0
       db     "7. Quit",0

KeyValMenu:
       db     4
       dw     KeyValGetKey
       dw     KeyValGetCSC
       dw     KeyValDI
       dw     MainLoop2
       db     "   Key Values",0
       db     "1. GetKey",0
       db     "2. GetCSC",0
       db     "3. Direct Input",0
       db     "4. Back",0

DoVATMenu:
       db     6
       dw     DoVATProg
       dw     DoVATOther
       dw     DoVATApp
       dw     DoVATHexProg
       dw     DoVATHexOther
       dw     MainLoop2
       db     "       VAT",0
       db     "1. Prog/List VAT",0
       db     "2. Symbol VAT",0
       db     "3. Applications",0
       db     "4. Hex ProgPtr",0
       db     "5. Hex SymTable",0
       db     "6. Back",0

FlashPageTXT:
       db     "Flash Page: ",0

VATTXT2:
       db     "6. Next         "
       db     "7. Back",0

VATTopTXT:
       db     "       VAT",0
DoVATKeys:
       db     8
       db     k1
       db     k2
       db     k3
       db     k4
       db     k5
       db     k6
       db     k7
       db     kClear
       dw     DoVAT1
       dw     DoVAT2
       dw     DoVAT3
       dw     DoVAT4
       dw     DoVAT5
       dw     DoVAT6
       dw     DoVAT
       dw     DoVAT

CharSetMenu:
       db     3
       dw     CharSetFont
       dw     CharSetToken
       dw     MainLoop2
       db     "  Character Set",0
       db     "1. Font",0
       db     "2. Token",0
       db     "3. Back",0

CharSetFontTXT:
       db     "  Get Character Number: ",0

CharSetTokenScreenTXT:
       db     3
       db     "    Get Token",0
       db     "First Byte:",0
       db     "Second Byte:",0

KeyValDITXT:
       db     "Grp: ",0
KeyValDITXT2:
       db     "Val: ",0       

AboutTXT:
       db     "CalcSys v1.4",0
       db     0
       db     "Released",0
       db     "XX/XX/XX",0
 IFDEF TI83P
       db     "Platform",0
       db     "TI-83 Plus",0
 ENDIF
 IFDEF TI73
       db     "Platform",0
       db     "TI-73",0
 ENDIF
 IFDEF ION
       db     "Platform",0
       db     "TI-83",0
 ENDIF
 IFDEF BETA
       db     "BETA",0
 ENDIF
       db     0,0,0
       db     "Made By",0
       db     "Detached Solutions",0
       db     "detachedsolutions",0
       db     "                      .com",0
       db     0,0,0
       db     "Coded By",0
       db     "Dan Englender",0
       db     "dan@det...ions.com",0
       db     0,0,0
       db     "Thanks",0
       db     "Scott Dial",0
       db     "Paul Fischer",0
       db     "Jason Kovacs",0
       db     "Matthew Landry",0
       db     "Andrew Magness",0
       db     "Michael Vincent",0
       db     "Joe Wingbermuehle",0
       db     0,0
       db     "(c) 2003",0
       db     "Detached Solutions",0
       db     0,0,0,0
       db     0FFh
AboutTXT2:
       db     "Have a Nice Day",0
       db     0,0,0,0FFh

;AboutSecretKeys:
;       db     4,1,2,3,2Fh,27h,36h,30h

DisKeys:
       db     16
       db     kClear
       db     kUp
       db     kDown
       db     kCapH
       db     kCapG
       db     kCapR
       db     k0
       db     k1
       db     k2
       db     k3
       db     k4
       db     k5
       db     k6
       db     k7
       db     k8
       db     k9
       dw     MainLoop
       dw     DisUp
       dw     DisDown
       dw     DisSwitchHex
       dw     DisGoto
       dw     DisRomPage
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark
       dw     DisBookMark

HexEditorKeys:
       db     27
       db     kCapD
       db     kCapG
       db     kCapF
       db     kCapR
       db     kEnter
       db     kAdd
       db     kSub
       db     kMul
       db     kDiv
       db     kBOL
       db     kEOL
       db     kUp
       db     kDown
       db     kLeft
       db     kRight
       db     kClear
       db     k0
       db     k1
       db     k2
       db     k3
       db     k4
       db     k5
       db     k6
       db     k7
       db     k8
       db     k9
       db     kCapE
       dw     HexSwitchDis
       dw     HexGoto
       dw     HexFind
       dw     HexRomPage
       dw     HexEdit
       dw     HexAdd
       dw     HexSub
       dw     HexMul
       dw     HexDiv
       dw     HexBOL
       dw     HexEOL
       dw     HexUp
       dw     HexDown
       dw     HexLeft
       dw     HexRight
       dw     MainLoop
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexBookMark
       dw     HexFind2

FindScreenTXT:
       db     2
       db     "Find Value 8bit",0
       db     "Value: ",0

FindScreenTXT2:
       db     2
       db     "Find Value 16bit",0
       db     "Value: ",0


RomPageScreenTXT:
       db     2
       db     "   Flash Page",0
       db     "Cur: ",0
RomPageScreenTXT2:
GotoScreenTXT2:
       db     "New: ",0
GotoScreenTXT:
       db     2
       db     "  Goto Address",0
       db     "Cur: ",0

DoVATTXT:
       db     5
       db     "Type:",0
       db     "Name:",0
       db     "VAT Loc:",0
       db     "Data Loc:",0
       db     "Size:",0

DoVATTXTApp:
       db     7
       db     "Page:",0
       db     "Name:",0
       db     "Size:",0
       db     "Pages:",0
       db     "Type:",0
       db     "ID:",0
       db     "Build:",0

VATTypeTXT:
 IFDEF TI73
      db     "Real",0
       db     "List",0
       db     "Matrix",0
       db     "Equation",0
       db     "String",0
       db     "Program",0
       db     "Prot Prog",0
       db     "Picture",0
       db     "GBD",0
       db     "Unknown",0
       db     "UnknownEqu",0
       db     "New Equ",0
       db     "Complex",0
       db     "Cmplx List",0
       db     "Undefined",0
       db     "Window",0
       db     "ZSto",0
       db     "Tbl Range",0
       db     "LCD",0
       db     "Backup",0
       db     "Frac",0
       db     "RSimp Frac",0
       db     "RMix Frac",0
       db     "Simp Frac",0
       db     "Mix Frac",0
       db     "Name",0
       db     "App",0
       db     "Appvar",0
       db     "Temp Const",0
 ELSE
       db     "Real",0
       db     "List",0
       db     "Matrix",0
       db     "Equation",0
       db     "String",0
       db     "Program",0
       db     "Prot Prog",0
       db     "Picture",0
       db     "GBD",0
       db     "Unknown",0
       db     "UnknownEqu",0
       db     "New Equ",0
       db     "Complex",0
       db     "Cmplx List",0
       db     "Undefined",0
       db     "Window",0
       db     "ZSto",0
       db     "Tbl Range",0
       db     "LCD",0
       db     "Backup",0
       db     "App",0
       db     "Appvar",0
       db     "Temp Prog",0
       db     "Group",0
       db     "Other",0
 ENDIF

PortMonTXT:
       db     5
       db     "  Port Monitor",0
       db     "Port:",0
       db     "Dec:",0
       db     "Hex:",0
       db     "Bin:",0
PortMonTXT2:
       db     "Output: ",0

BlankTXT:
       db     "          ",0

PortNames:
       db     "Link",0
       db     "Key",0
       db     0
       db     "Status",0
       db     "Interrupt",0
       db     0
       db     "Mem Bank 1",0
       db     "Mem Bank 2",0
       db     0
       db     0
       db     0
       db     0,0,0,0,0
       db     "LCD Instr",0
       db     "LCD Data",0

ConsoleTXT:
       db     "Welcome",0
ConErrCommandTXT:
       db     " ERR:COMMAND",0
ConErrArgumentTXT:
       db     " ERR:ARGUMENT",0
ConErrArchivedTXT:
       db     " ERR:ARCHIVED",0
ConErrMemoryTXT:
       db     " ERR:MEMORY",0

ConAddrs:
       dw     ParseHexAdd
       dw     ParseBCall
       dw     ParseClear
       dw     ParseCall
       dw     ParseHexDiv
       dw     ParseExec
       dw     ParseInfo
       dw     ParseJump
       dw     ParseHexMul
       dw     MainLoop
       dw     ParseRun
       dw     ParseSet
       dw     ParseShow
       dw     ParseHexSub
       dw     ParseSearch
ConHelpNum    EQU    ($-ConAddrs)/2
       dw     ParseShow
       dw     ParseSet
       dw     MainLoop
       dw     ParseSmile
       dw     ParseGatos
       dw     ParseHelp
       dw     ParseHelp
       dw     ParseCall
       dw     ParseBCall
       dw     ParseJump
       dw     ParseWhom
       dw     ParseExec
       dw     ParseRun
       dw     ParseOff
       dw     ParseErr
       dw     Init
       dw     ParseHex
       dw     ParseASCII
       dw     ParseMouse
       dw     ControlRemote
       dw     ParseRace
       dw     ParseDump
       dw     ParseRef
       dw     ParseROM
       dw     ParseDisROM
       dw     ParseDisROM

ConAddrsE:
NumConComs           EQU (ConAddrsE-ConAddrs)/2
ConTXT:
       db     "ADD",0
       db     "BCALL",0
       db     "CLR",0
       db     "CALL",0
       db     "DIV",0
       db     "EXEC",0
       db     "INFO",0
       db     "JUMP",0
       db     "MUL",0
       db     "QUIT",0
       db     "RUN",0
       db     "SET",0
       db     "SHOW",0
       db     "SUB",0
       db     "SEARCH",0
       db     "SH",0
       db     "ST",0
       db     "Q",0
       db     "SMILE",0
       db     "GATOS",0
       db     "HELP",0
       db     "H",0
       db     "C",0
       db     "BC",0
       db     "J",0
       db     "WHOAMI",0
       db     "X",0
       db     "R",0
       db     "OFF",0
       db     "ERR",0
       db     "INIT",0
       db     "HEX",0
       db     "ASCII",0
       db     "MOUSE",0
       db     "CONTROLREMOTE",0
       db     "GREENLIGHTGO",0
       db     "DUMP",0
       db     "REF",0
       db     "ROM",0
       db     "DISROM",0
       db     "DR",0

ConsoleHelpTXT:
       db     "Help (command)  "
       db     "ADD, BCALL, CLR,"
       db     "CALL, DIV, EXEC,"
       db     "INFO, JUMP, MUL,"
       db     "QUIT, RUN, SHOW,"
       db     "SEARCH, SET, SUB",0
ConsoleHelpTXTIndex:
       dw     HelpHelpAdd
       dw     HelpHelpBcall
       dw     HelpHelpClr
       dw     HelpHelpCall
       dw     HelpHelpDiv
       dw     HelpHelpExec
       dw     HelpHelpInfo
       dw     HelpHelpJump
       dw     HelpHelpMul
       dw     HelpHelpQuit
       dw     HelpHelpRun
       dw     HelpHelpSet
       dw     HelpHelpShow
       dw     HelpHelpSub
       dw     HelpHelpSearch

HelpHelpSearch:
       db     3
       db     "SEARCH NN...",0
       db     "Search for value",0
       db     "NN... in ROM",0
HelpHelpAdd:
       db     2
       db     "ADD NNNN,NNNN",0
       db     "Adds two numbers",0
HelpHelpBcall:
       db     3
       db     "BCALL NNNN",0
       db     "Bcalls NNNN",0
       db     "Alt: BC",0
HelpHelpClr:
       db     1
       db     "Clears Screen",0
HelpHelpCall:
       db     3
       db     "CALL NNNN",0
       db     "Calls NNNN",0
       db     "Alt: C",0
HelpHelpDiv:
       db     4
       db     "DIV NNNN,NNNN",0
       db     "Divides numbers.",0
       db     "Second high byte",0
       db     "is ignored",0
HelpHelpExec:
       db     4
       db     "EXEC NN...",0
       db     "Execute a string",0
       db     "of Z80 commands",0
       db     "Alt: X",0
HelpHelpInfo:
       db     1
       db     "System Info",0
HelpHelpJump:
       db     3
       db     "JUMP NNNN",0
       db     "Jumps to NNNN",0
       db     "Alt: J",0
HelpHelpMul:
       db     4
       db     "MUL NNNN,NNNN",0
       db     "Multiply two",0
       db     "numbers.  High",0
       db     "byte is ignored",0
HelpHelpQuit:
       db     1
       db     "Exits Console",0
HelpHelpRun:
       db     3
       db     "RUN PROGNAME",0
       db     "Runs a program",0
       db     "Alt: R",0
HelpHelpSet:
       db     7
       db     "SET r,NN(NN) or",0
       db     "SET NNNN,NN...",0
       db     "Set register r",0
       db     "to value NN(NN)",0
       db     "or mem addr NNNN",0
       db     "to value NN...",0
       db     "Alt: ST",0
HelpHelpShow:
       db     5
       db     "SHOW (r or NNNN)",0
       db     "Disp (NNNN) or",0
       db     "reg r.  No args=",0
       db     "disp all regs",0
       db     "Alt: SH",0
HelpHelpSub:
       db     3
       db     "SUB NNNN,NNNN",0
       db     "Subtract two",0
       db     "numbers",0
SmileWinTXT:
       db     "You Got It!!!",0
SmileLoseTXT:
       db     "Hou Lost :(",0
SmileBigTXT:
       db     "Too High!",0
SmileSmallTXT:
       db     "Too Low!",0
SmileGuessTXT:
       db     "Guess? ",0
SmileTXT:
       db     "Guess Number",0
ParseExecTXT:
       db     "Executed",0
ParseSearchTXT:
       db     "Search Complete",0
ParseDumpPageTXT:
       db     "Read Page: ",0
ParseDumpFromTXT:
       db     "Read Addr: ",0
ParseDumpToTXT:
       db     "Load Addr: ",0
ParseDumpSizeTXT:
       db     "Size: ",0     
VirAFTXT:
       db     "AF:",0
       db     "BC:",0
       db     "DE:",0
       db     "HL:",0
       db     "IX:",0
       db     "Run Away!",0
       db     "Booooinnng",0
ParseInfoTXT:
       db     "Mem Free:",0
       db     "ROM Code:",0
       db     "Contrast:",0
       db     "VAT Size:",0
       db     "Prog VAT:",0
       db     "ROM Page:",0
ParseErrTXT:
       db     " ERR:",0
ParseWhomTXT:
       db     "Jackie Chan?",0
SysFlagKeys:
       db     8
       db     k1
       db     k2
       db     k3
       db     k4
       db     k5
       db     k6
       db     k7
       db     kClear
       dw     SysFlag1
       dw     SysFlag2
       dw     SysFlag3
       dw     SysFlag4
       dw     SysFlag5
       dw     SysFlag6
       dw     MainLoop
       dw     MainLoop

SysFlagScreen:
       db     8
       db     "      Flags",0
       db     "1.",0
       db     "2.",0
       db     "3.",0
       db     "4.",0
       db     "5.",0
       db     "6. Next",0
       db     "7. Back",0
ParseGatosTXT:
       db     "Alfie and Felix",0
bitstrings:
	db	"indelete",0
	db	0
	db	"deg/rad",0
	db	"scn cde rdy",0
	db	"key pressed",0
	db	"disp done",0
	db	0
	db	0


	db	0
	db	0
	db	"ed buf open",0
	db	0
	db	"mon abandon",0
	db	0
	db	0
	db	0

	db	"trace disp",0
	db	"plot loc",0
	db	"plot disp",0
	db	0
	db	"function",0
	db	"polar",0
	db	"parametric",0
	db	"recursion",0

	db	"graph valid",0
	db	0
	db	"graph Cursr",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	"line/Dot",0
	db	"seq/Simul",0
	db	"grid",0
	db	"rect/Polar",0
	db	"disp coords",0
	db	"disp axis",0
	db	"disp label",0
	db	0
	db	0
	db	"erase below",0
	db	"scrn scroll",0
	db	"textinverse",0
	db	"insert mode",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"res in op1",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	"mode blink",0
	db	"prgm runing",0
	db	"APD enabled",0
	db	"APD clock",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	"calc on",0
	db	"on key req",0
	db	0
	db	"stats valid",0
	db	0

	db	"show expont",0
	db	"eng/sci not",0
	db	"hexadecimal",0
	db	"octal",0
	db	"binary",0
	db	"mode real",0
	db	"mode rect",0
	db	"mode ploar",0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"format num",0
	db	0
	db	"cursr flash",0
	db	"cursor show",0
	db	"cursor off",0
	db	0
	db	0
	db	0

	db	"want on int",0
	db	"save txtsdw",0
	db	"auto scroll",0
	db	"menu keys",0
	db	"ignore menu",0
	db	"gfx cursor",0
	db	"hilite word",0
	db	"handle exit",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"web mode",0
	db	"web vert",0
	db	"U vs V",0
	db	"V vs W",0
	db	"U vs W",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"prompt edit",0
	db	0
	db	0
	db	0
	db	0
	db	"prgm menu",0
	db	0
	db	0

	db	"runindic on",0
	db	"indicInUse",0
	db	"indic only",0
	db	0e1h," pressed",0
	db	0e2h," pressed",0
	db	0e2h," or ",0e3h,0
	db	0e2h," Lock",0
	db	"Keep ",0e2h, " on",0

	db	0
	db	0
	db	0
	db	0
	db	"auto fill",0
	db	"auto calc",0
	db	"tblRecalc",0
	db	0

	db	"horiz split",0
	db	"vert split",0
	db	"splitChange",0
	db	"ignoreSplit",0
	db	"writeOnGrph",0
	db	"graphStyles",0
	db	"modBox comp",0
	db	"text write",0

	db	"extra indic",0
	db	"sa indic",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"smart graph",0
	db	"smartr test",0
	db	0
	db	"smartr mask",0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	"batt good",0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	"fncFromExec",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"asm0",0
	db	"asm1",0
	db	"asm2",0
	db	"asm3",0
	db	"asm4",0
	db	"asm5",0
	db	"asm6",0
	db	"asm7",0

	db	"asm8",0
	db	"asm9",0
	db	"asm10",0
	db	"asm11",0
	db	"asm12",0
	db	"asm13",0
	db	"asm14",0
	db	"asm15",0

	db	"asm16",0
	db	"asm17",0
	db	"asm18",0
	db	"asm19",0
	db	"asm20",0
	db	"asm21",0
	db	"asm22",0
	db	"asm23",0

	db	0
	db	"com failed",0
	db	0
	db	"lower case",0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	"ingroup",0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
;43
	db	0
	db	0
	db	"fullscrdrw",0
	db	0
	db	0
	db	0
	db	0
	db	0
;44
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
;45
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
flags46screen:
	db	"xApp 0",0  
	db	"xApp 1",0  
	db	"xApp 2",0  
	db	"xApp 3",0  
	db	"xApp 4",0  
	db	"xApp 5",0  
	db	"xApp 6",0  
	db	"xApp 7",0  
flags47screen:
	db	"xApp 8",0  
	db	"xApp 9",0 
	db	"xApp 10",0 
	db	"xApp 11",0 
	db	"xApp 12",0 
	db	"xApp 13",0 
	db	"xApp 14",0  
	db	"xApp 15",0 
flags48screen:
	db	"xApp 16",0 
	db	"xApp 17",0 
	db	"xApp 18",0 
	db	"xApp 19",0 
	db	"xApp 20",0 
	db	"xApp 21",0 
	db	"xApp 22",0 
	db	"xApp 23",0 
flags49screen:
	db	"xApp 24",0 
	db	"xApp 25",0 
	db	"xApp 26",0 
	db	"xApp 27",0 
	db	"xApp 28",0 
	db	"xApp 29",0 
	db	"xApp 30",0 
	db	"xApp 31",0 

	db	0
	db	0
	db	"draw lfont",0
	db	"tall lfont",0
	db	0
	db	0
	db	0
	db	"custom font",0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	"bufferonly",0
	db	0
	db	0
	db	0
	db	"fastcirc",0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0

flagscreentext:
	db	"key/trig",0
	db	"edit/mon",0
	db	"plot/graph",0
	db	"graph 2",0
	db	"graph 3",0
	db	"text",0
	db	"????",0
	db	"parser",0
	db	"deriv/apd",0
	db	"on/stat",0
	db	"num format",0
	db	"formatOver",0
	db	"edit/cursr",0
	db	"apps",0
	db	"????",0
	db	"seq graph",0
	db	"????",0
	db	"prmpt/menu",0
	db	"ind/shift",0
	db	"table",0
	db	"sgr",0
	db	"new indic",0
	db	"????",0
	db	"smart grph",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"complex",0
	db	"????",0
	db	"????",0
	db	"asm flags1",0
	db	"asm flags2",0
	db	"asm flags3",0
	db	"get/send",0
	db	"????",0
	db	"groupflags",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"apiflags3",0
	db	"apiflags4",0
	db	"????",0
	db	"????",0
	db	"xappFlags1",0
	db	"xappFlags2",0
	db	"xappFlags3",0
	db	"xappFlags4",0
	db	"font",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"plotflags3",0
	db	"????",0
	db	"????",0
	db	"????",0
	db	"????",0

LinkKeyTab1:
	db	0,0,0,0,0,0,0,0,0
	db	0,0,"WRMH",0fh
	db	0
	db	"?",5Bh,"VQLG",0
	db	0
	db	":ZUPKFC",0
	db	" YTOJEB",5
	db	0
	db	"XSNIDA",0FFh
	db	"!@#$%",0FEh,0FDh,0

LinkKeyTab2:
	db	0,58h,51h,54h,52h,0,0,0,0
	db	0dh,"+-*/^",0fh
	db	0
	db	1ah,"369)",0,0,0
	db	".258(",0,0,0
	db	"0147,",0,0,5
	db	0
	db	1ch,0,0,12h,11h,0,1
	db	"&_=<>",0FEh,0FCh,0


