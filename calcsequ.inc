;Calcsys memory equates and defines
 DEFINE CALCSYS
 DEFINE LHOMETEXTMENU
 DEFINE LPUTSAPP
 DEFINE LSCROLLINGCREDITS
 DEFINE LDISPHOMETEXTC
 DEFINE LGETHEXA
 DEFINE LDISPHEXA
 DEFINE LDISPHEXHL
 DEFINE LGETHEXHL
 DEFINE LFINDINDEXTEXT
 DEFINE LDISPBINA
 DEFINE LSTRINGINPUT
 DEFINE LRANDNUM
 DEFINE LASCIITOHEX
 DEFINE LRETNZ
 DEFINE LDISPBLANK
 DEFINE LTIOSMODLINK
 DEFINE LSENDBYTETIOS
 DEFINE LGETBYTETIOS
; DEFINE LSECRETKEYS
 IFDEF ION
appBackUpScreen     EQU    statVars
 ENDIF

CBufSize                    EQU           127
NumPortNames                EQU           17
ProgVAT                     EQU           0
AppVAT                      EQU           1
CalcsysFlags                EQU           asm_Flag1

ScrollingCBuf               EQU           saveSScreen
CenterTextBuf               EQU           OP1


HexAddr                     EQU           appBackUpScreen+0
HexPage                     EQU           appBackUpScreen+2
DisAddr                     EQU           appBackUpScreen+3
DisPage                     EQU           appBackUpScreen+5
CurPort                     EQU           appBackUpScreen+6
VirF                        EQU           appBackUpScreen+7
VirA                        EQU           appBackUpScreen+8
VirAF                       EQU           appBackUpScreen+7
VirC                        EQU           appBackUpScreen+9
VirB                        EQU           appBackUpScreen+10
VirBC                       EQU           appBackUpScreen+9
VirE                        EQU           appBackUpScreen+11
VirD                        EQU           appBackUpScreen+12
VirDE                       EQU           appBackUpScreen+11
VirL                        EQU           appBackUpScreen+13
VirH                        EQU           appBackUpScreen+14
VirHL                       EQU           appBackUpScreen+13
VirIX                       EQU           appBackUpScreen+15                        
DINoKey                     EQU           appBackUpScreen+17
CurTopFlag                  EQU           appBackUpScreen+18
SmileNum                    EQU           appBackUpScreen+19
BookMarks                   EQU           appBackUpScreen+20
VATAddr                     EQU           appBackUpScreen+50
;DisTempDD                   EQU           appBackUpScreen+52
TempDDFD                    EQU           appBackUpScreen+54
SCounter                    EQU           appBackUpScreen+56
LinkBotCur                  EQU           appBackUpScreen+57
LinkConFlag                 EQU           appBackUpScreen+59
RaceLast                    EQU           appBackUpScreen+61
Yadda                       EQU           appBackUpScreen+62
InitBlank                   EQU           Yadda-DisPage
RelocCallAddr               EQU           appBackUpScreen+100
ConstRetAddr                EQU           appBackUpScreen+104
ParseEndAddr                EQU           appBackUpScreen+105
GetHexATemp                 EQU           appBackUpScreen+107
RecByteBuffer               EQU           appBackUpScreen+108
NumFires                    EQU           appBackUpScreen+109
FireTable                   EQU           appBackUpScreen+110  ; 16 bytes
NumParts                    EQU           appBackUpScreen+126
FireSpeed                   EQU           appBackUpScreen+127
FireExplode                 EQU           appBackUpScreen+128
PartAccel                   EQU           appBackUpScreen+129
PartVeloc                   EQU           appBackUpScreen+130
ExplodeSize                 EQU           appBackUpScreen+131
InterDelay                  EQU           appBackUpScreen+132
VAppSize                    EQU           appBackUpScreen+133 ; 4 bytes
VAppType                    EQU           appBackUpScreen+137 ; 3 bytes
VAppID                      EQU           appBackUpScreen+140
VAppBuild                   EQU           appBackUpScreen+141
VAppName                    EQU           appBackUpScreen+142 ; 9 bytes
VAppPages                   EQU           appBackUpScreen+151
DisTempDD                   EQU           appBackUpScreen+152 ; 3 bytes
CurVATEntry                 EQU           appBackUpScreen+156 ; 2 bytes
PartTable                   EQU           appBackUpScreen+200
ConsoleBuffer               EQU           appBackUpScreen+200
Argument                    EQU           ConsoleBuffer+CBufSize
ExecCodeSpace               EQU           Argument+CBufSize

 IFDEF TI83P
  warning "TI83 Plus"
 ENDIF
 IFDEF TI73
  warning "TI73"
 ENDIF
 IFDEF ION
  warning "Ion"
 ENDIF
