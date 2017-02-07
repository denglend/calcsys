;Calcsys 1.3 for the TI-83 Plus and the TI-73 (and TI-83?)
;(c) 2000ish Detached Solutions, Dan Englender

;So what's new in 1.4?
;This is just a bug fix release, although the source has been released again 
; (the last release was 1.1).
;Bug fixes:
; Flag byte 20 now displays correctly
; Displays correct size information for archived variables
; Hex Editor now views RAM pages on 84P correctly


;So what's new in 1.3?
;Not too much in fact, this version is mostly just to add TI-83 Plus Silver Edition
; support (link console).  (Actually, it's turned into a more substantial update
; than I expected.  I kept finding more things to do)
;A new sub-section was added to the VAT section: Applications.  (Yes, I know that
; apps aren't in the VAT.  You think I could implement this if I didn't know?
; sheesh...).  In this sub-section you can quickly find info on loaded apps, and
; jump to the Hex Editor with Alpha+H.
;New Console commands:
; ROM - Displays address and page of the entry point address you provide
; DISROM (DR) - Disassembles the routine for the entry point address you provide
;Some bug fixes:
; Hopefully all disasembler bugs are gone.  These were all problems with the text
;  or size of IX/IY instructions.
; VAT types greater than 17 are reported as "Other"
; TI-73 only VAT types are now supported
; Menus now exit correctly with the CLEAR button.
; You can now set the L virtual register in the console
; SEARCH now searches page zero (thanks to Michael Vincent for that report)
; SEARCH now works correctly on the Silver Edition
; You can set/reset bit seven of flags

;So what's new in 1.2?  (Other than the previous sentence now ryhming....)
;Version 1.2 was completely rewritten from scratch.  This means there's a ton of
; cool new features, right?  Wrong...Oh well.
;Well, it's written for ZDS now.  A side effect of this is that there is now a
; TI-73 version of Calcsys.  Nifty huh?
;The TI-73 version is almost identical to the TI-83 Plus version.  There are a
; couple of differences, but nothing major.
;On to other things...You can no longer log stuff from Port Monitor.  I noticed
; that logging the ports had absolutely no use, so I took it out.
;The about screen has been completely changed.  It looks sort of cool now.  The
; calc info stuff that used to be at the end of the about screen is now in the
; console.
;There have been a few changes to the Console, most notably a much nicer input
; routine, but there's some other stuff too...
;You can no longer run BASIC programs from the Console, but you can run assembly
; programs.
;My favorite change is most likely the addition of the Search capability to the
; Console.  It lets you search the entire ROM for a string of values.
;A 16bit find has been added to the Hex Editor, and bookmarks added to both the
; Hex Editor and Disassembler.
;The Link Console now has a cursor and can bulk output.
;Hopefully the few bugs that were left in version 1.1 are now gone.
;Just about everything runs faster since I coded it better this time around.

;Contact Information
;Detached Solutions -- http://www.detachedsolutions.com
;Dan Englender -- dan@detachedsolutions.com
;Complaints about flash applications and signing -- 5th floor

 DEFINE TI83P
; DEFINE BETA 
; DEFINE TI73

 IFDEF TI83P
  include "../ti83plus.inc"
 ENDIF
 IFDEF TI73
  include "../ti73asm.inc"
 ENDIF
 IFDEF ION
  include "../squish.inc"
 ENDIF
 include "calcsyhd.inc"
 include "calcsequ.inc"
 GLOBALS ON
       jp     Init
       ld     hl,SCounter
       set    3,(hl)
       ret
 
Init:
                            ;Initialization Code
 IFDEF TI83P
       B_CALL SetTblGraphDraw
       B_CALL ForceFullScreen
       B_CALL EnableAPD
 ENDIF
 IFDEF ION
       set    apdAble,(iy+apdFlags)
 ENDIF
 IFDEF TI73
       AppOffErr
       B_CALL DisableAPI
       ld     hl,DummyReturn
       ld     (appRawKeyHandle),hl
       in     a,(6)
       ld     (appPage),a
       call   SetTblGraphDraw
       call   ForceFullScreen
       B_CALL EnableApd
 ENDIF
       ld     hl,HexAddr
       ld     bc,InitBlank
       B_CALL MemClear      ;Initialize memory variables
       ld     a,0C9h
       ld     (ConstRetAddr),a
MainLoop:
                            ;Main Menu (1)
       ld     hl,MainMenu
       jr     MainLoopCont
MainLoop2:
                            ;Main Menu (2)
       ld     hl,MainMenu2
MainLoopCont:
       res    appAutoScroll,(iy+appFlags)                            
       res    curAble,(iy+curFlags)
       res    textWrite,(iy+sGrFlags)
       ld     a,(flags+shiftFlags)
       and    7
       ld     (flags+shiftFlags),a
       ld     de,0800h
       ld     (winTop),de
       jp     HomeTextMenu




;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                Hex Editor               --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------

HexEditor:
                            ;Calcsys Hex Editor
       call   ClrLCDAndHomeUp
       call   DispHexScreen
HexEditorLoop:
       ld     hl,HexEditorKeys
       jp     ReactionMenu
HexBookMark:
       sub    k0
       ld     b,a
       add    a,a
       add    a,b
       ld     l,a
       ld     h,0
       ld     de,BookMarks
       add    hl,de
       in     a,(4)
       and    8
       jr     nz,HexBookMarkNoSet
       ld     de,(HexAddr)
       ld     (hl),e
       inc    hl
       ld     (hl),d
       inc    hl
       ld     a,(HexPage)
       ld     (hl),a
       jr     HexEditor
HexBookMarkNoSet:
       push   hl
       B_CALL LdHLInd
       ld     (HexAddr),hl
       pop    hl
       inc    hl
       inc    hl
       ld     a,(hl)
       ld     (HexPage),a
       jr     HexEditor
HexUp:
       ld     de,-4
       jr     HexMove
HexDown:
       ld     de,4
       jr     HexMove
HexLeft:
       ld     de,-1
       jr     HexMove
HexRight:
       ld     de,1
       jr     HexMove
HexAdd:
       ld     de,100h
       jr     HexMove
HexSub:
       ld     de,-100h
       jr     HexMove
HexMul:
       ld     de,1000h
       jr     HexMove
HexDiv:
       ld     de,-1000h
       jr     HexMove
HexBOL:
       ld     de,-10h
       jr     HexMove
HexEOL:
       ld     de,10h
HexMove:
       ld     hl,(HexAddr)
       add    hl,de
       ld     (HexAddr),hl
       jr     HexEditor
HexGoto:
       ld     hl,(HexAddr)
       call   GotoScreen
       ld     (HexAddr),hl
       jp     HexEditor
HexRomPage:
       ld     a,(HexPage)
       call   RomPageScreen
       ld     (HexPage),a
       jp     HexEditor
HexSwitchDis:
       ld     a,(HexPage)
       ld     (DisPage),a
       ld     hl,(HexAddr)
       ld     (DisAddr),hl
       jp     Disassemble
HexFind2:
       call   FindScreen2
       push   hl
 IFNDEF ION
       ld     hl,HexFindCode2
       ld     de,ramCode
       ld     bc,HexFindCode2Len
       ldir
 ENDIF
       ld     hl,(HexAddr)
       pop    de
       push   hl
       ld     hl,0DADAh
       or     a
       sbc    hl,de
       push   af
       pop    hl
       ld     a,l
       pop    hl
       and    64                  ; 7
       ld     b,a
       ld     a,(SCounter)
       or     b
       ld     (SCounter),a
       ld     bc,0
 IFNDEF ION
       call     ramCode
 ENDIF
 IFDEF ION
       call   HexFindCode2
 ENDIF
       jp    HexEditor
HexFindCode2:
 IFNDEF ION
       in     a,(6)
 ELSE
       in     a,(2)
 ENDIF
       push   af
       ld     a,(HexPage)
 IFNDEF ION
       out    (6),a
 ELSE
       or     88h
       out    (2),a
 ENDIF

HexFindCode2Loop:
       ld     a,d
       cpir
       jr     nz,HexFindCode2LoopDone
       ld     a,(hl)
       cp     e
       jr     nz,HexFindCode2Loop
       dec    hl
HexFindCode2LoopDone:
       ld     (HexAddr),hl
       pop    af
 IFNDEF ION
       out    (6),a
 ELSE 
       out    (2),a
 ENDIF
       ret
HexFindCode2Len      EQU    $-HexFindCode2
HexFind:
       call   FindScreen
 IFNDEF ION
       ld     hl,HexFindCode
       ld     de,8100h
       ld     bc,HexFindCodeLen
       ldir
 ENDIF
       ld     hl,(HexAddr)
       ld     bc,0
 IFNDEF ION       
       call     ramCode
 ELSE
       call   HexFindCode
 ENDIF
       jp     HexEditor
HexFindCode:
       ld     d,a
 IFNDEF ION
       in     a,(6)
 ELSE
       in     a,(2)
 ENDIF
       push   af
       ld     a,(HexPage)
 IFNDEF ION
       out    (6),a
 ELSE
       or     88h
       out    (2),a
 ENDIF
       ld     a,d
       cpir
       dec    hl
       ld     (HexAddr),hl
       pop    af
 IFNDEF ION
       out    (6),a
 ELSE
       out    (2),a
 ENDIF
       jp     HexEditor
HexFindCodeE:
HexFindCodeLen       EQU    HexFindCodeE - HexFindCode

HexEdit:
       ld     hl,(HexAddr)
       ld     de,8000h
       or     a
       sbc    hl,de
       jp     c,HexEditorLoop
       ld     hl,0500h
       ld     (curRow),hl
       call   GetHexA
       ld     hl,(HexAddr)
       ld     de,SCounter
       B_CALL CpHLDE
       jp     z,HexEditor
       ld     (hl),a
       jp     HexEditor


DispHexScreen:
                                   ;Display Hex Editor
       ld     hl,(HexAddr)
       ld     b,4
DispHexScreenLoop:
       ld     a,4
       sub    b
       add    a,a
       ld     e,a
       ld     d,0
       ld     (curRow),de   
       push   bc
       call   DispHexRow
       pop    bc
       djnz   DispHexScreenLoop
       ret

DispHexRow:
                                   ;Display Hex Row (Really two rows)
       call   DispHexHL
       ld     a,':'
       B_CALL PutC
       ld     b,4              
DispHexRowLoop:
       push   bc
       call   GetHexVal
       push   hl
       cp     0D6h                 ;New Line char
       jr     nz,NoNewLine
       ld     a,Lcolon
NoNewLine:
       ld     hl,curRow
       inc    (hl)
       B_CALL PutMap
       dec    (hl)
       pop    hl
       call   GetHexVal
       call   DispHexA
       inc    hl
       ld     a,' '
       B_CALL PutC
       pop    bc
       djnz   DispHexRowLoop
       ret
GetHexVal:
                            ;Gets value from ROM/RAM
       ld     a,(HexPage)
       ld     b,a
 IFNDEF ION
 IFDEF TI73
       call LoadCIndPaged
 ELSE
;       B_CALL LoadCIndPaged
       bit    6,h
       jr     z,$f
       bit    7,h
       jr     nz,$f

       di
       in     a,(7)
       push   af
       ld     a,b
       out    (7),a
       set    7,h
       res    6,h
       ld     c,(hl)
       res    7,h
       set    6,h
       pop    af
       out    (7),a
       ei
       ld     a,c
       ret
$$:
       B_CALL LoadCIndPaged
 ENDIF
 ELSE
       ld     c,(hl)
 ENDIF
       ld     a,c
DummyReturn:
       ret


;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------             Shared Routines             --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
OldLine:
       push   hl
       ld     hl,curRow
       dec    (hl)
       inc    hl
       ld     (hl),0
       pop    hl
       ret


IGetKey:
                            ;Internal GetKey call
       push   hl
       push   de
       push   bc
       B_CALL GetKey
       pop    bc
       pop    de
       pop    hl
       res    onInterrupt,(iy+onFlags)
 IFDEF TI73
       cp     kMath
       jr     nz,IGNotkMath
       push   af
       ld     a,(flags+indicFlags)
       xor    1<<shiftAlpha
       ld     (flags+indicFlags),a
       and    1<<shiftAlpha
       jr     nz,IGNotAOff
       res    shiftALock,(iy+indicFlags)
IGNotAOff:
       pop    af
IGNotkMath:
       cp     kAlpha
       jr     nz,IGNotkText
       set    shiftAlpha,(iy+indicFlags)
       set    shiftALock,(iy+indicFlags)
IGNotkText:
 ENDIF
       cp     kQuit
       ret    nz
Quit:
       ld     a,' '
       ld     (curUnder),a
 IFNDEF ION
       B_JUMP JForceCmdNoChar
 ELSE
       B_CALL DelRes
       ret
 ENDIF

FindScreen2:
       ld     hl,FindScreenTXT2
       call   DispHomeTextC
       jp     GetHexHL

FindScreen:
       ld     hl,FindScreenTXT
       call   DispHomeTextC
       jp     GetHexA

RomPageScreen:
       push   af
       ld     hl,RomPageScreenTXT
       call   DispHomeTextC
       pop    af
       call   DispHexA
       B_CALL NewLine
       ld     hl,RomPageScreenTXT2
       call   PutSApp
       jp     GetHexA

GotoScreen:
       push   hl
       ld     hl,GotoScreenTXT
       call   DispHomeTextC
       pop    hl
       call   DispHexHL
       B_CALL NewLine
       ld     hl,GotoScreenTXT2
       call   PutSApp
       jp     GetHexHL

ReactionMenu:
                            ;does stuff on key presses
                            ;A will hold the key press # (just in case you
                            ; want to have the same label for multiple key
                            ; presses)
       push   hl
       call   IGetKey
       pop    hl
       push   hl
       ld     c,(hl)
       inc    hl            ;hl->key codes
       ld     b,0
       push   bc
       cpir
       pop    de            ;de=~trials
       pop    hl
       jr     nz,ReactionMenu
       ex     de,hl
       or     a
       sbc    hl,bc
       ex     de,hl         ;de = real trials, hl -> structure
       ld     c,(hl)
       ld     b,0
       add    hl,bc
       inc    hl
       dec    e
       sla    e
       add    hl,de
       push   af
       B_CALL LdHLInd
       pop    af
       jp     (hl)

Race:
       B_CALL GrBufClr
       ld     hl,0
       ld     a,28
       ld     (RaceLast),a
RaceLoop:
       push   hl
       B_CALL GrBufCpy
       call   RaceAddRow
       ld     a,1
       ld     (plotSScreen+63*12+5),a
       rrca
       ld     (plotSScreen+63*12+6),a
       ld     a,0FEh
       out    (1),a
       in     a,(1)
       cp     0FDh
       call   z,RaceMoveLeft
       cp     0FBh
       call   z,RaceMoveRight
       call   RaceCheckHit
       pop    hl
       ret    nz
       inc    hl
       jr     RaceLoop
RaceAddRow:
       ld     de,plotSScreen+767
       ld     hl,plotSScreen+755
       ld     bc,756
       lddr
       inc    hl
       push   hl
       ld     bc,12
       B_CALL MemClear
       pop    hl
       dec    c
       ld     b,9
       call   RandNum
       sub    4
       ld     b,a
       ld     a,(RaceLast)
       add    a,b
       cp     240
       jr     c,RaceLastOK1
       xor    a
RaceLastOK1:
       cp     64
       jr     c,RaceLastOK2
       ld     a,63
RaceLastOK2:
       or     a
       jr     nz,RaceLastOK3
       inc    a
RaceLastOK3:
       ld     (RaceLast),a
       ld     b,a
       ld     c,8
RaceAddRowLoopy
       ld     (hl),255
       inc    hl
       dec    c
       jr     nz,RaceAddRowLoopy
RaceAddRowLoop:
       ld     hl,plotSScreen+11
       scf
       ld     c,12
RaceAddRowLoop2:
       rl     (hl)
       dec    hl
       dec    c
       jr     nz,RaceAddRowLoop2
       djnz   RaceAddRowLoop
       ret
RaceMoveLeft:
       ld     hl,plotSScreen+11
       ld     de,24
       ld     c,63
RaceMoveLeftLoop1:
       ld     b,12
       scf
RaceMoveLeftLoop2:
       rl     (hl)
       dec    hl
       djnz   RaceMoveLeftLoop2
       add    hl,de
       dec    c
       jr     nz,RaceMoveLeftLoop1
       ret
RaceMoveRight:
       ld     hl,plotSScreen
       ld     c,63
RaceMoveRightLoop1:
       ld     b,12
       scf
RaceMoveRightLoop2:
       rr     (hl)
       inc    hl
       djnz   RaceMoveRightLoop2
       dec    c
       jr     nz,RaceMoveRightLoop1
       ret
RaceCheckHit:
       ld     a,(plotSScreen+62*12+5)
       and    2
       ret    nz
       ld     a,(plotSScreen+62*12+6)
       and    64
       ret




       

              

;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------               Disassembler              --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------


Disassemble:
                            ;Calcsys Disassembler
       call   DisDispScreen
DisLoop:
       ld     hl,DisKeys
       jp     ReactionMenu
DisGetVal:
       ld     a,(DisPage)
       push   bc
       push   de
       ld     b,a
 IFNDEF ION
 IFDEF TI83P
       B_CALL LoadCIndPaged
 ELSE
       call   LoadCIndPaged
 ENDIF
 ELSE
       ld     c,(hl)
 ENDIF
       ld     a,c
       pop    de
       pop    bc
       ret
DisBookMark:
       sub    k0
       ld     b,a
       add    a,a
       add    a,b
       ld     l,a
       ld     h,0
       ld     de,BookMarks
       add    hl,de
       in     a,(4)
       and    8
       jr     nz,DisBookMarkNoSet
       ld     de,(DisAddr)
       ld     (hl),e
       inc    hl
       ld     (hl),d
       inc    hl
       ld     a,(DisPage)
       ld     (hl),a
       jr     Disassemble
DisBookMarkNoSet:
       push   hl
       B_CALL LdHLInd
       ld     (DisAddr),hl
       pop    hl
       inc    hl
       inc    hl
       ld     a,(hl)
       ld     (DisPage),a       
       jr     Disassemble
DisSwitchHex:
       ld     hl,(DisAddr)
       ld     (HexAddr),hl
       ld     a,(DisPage)
       ld     (HexPage),a
       jp     HexEditor
DisGoto:
       ld     hl,(DisAddr)
       call   GotoScreen
       ld     (DisAddr),hl
       jr     Disassemble
DisRomPage:
       ld     a,(DisPage)
       call   RomPageScreen
       ld     (DisPage),a
       jr     Disassemble

DisUp:
       ld     hl,(DisAddr)
       dec    hl
       ld     (DisAddr),hl
       jr     Disassemble
DisDown:
       ld     hl,(DisAddr)
       call   DisGetLength
       ld     e,a
       ld     d,0
       add    hl,de
       ld     (DisAddr),hl
       jp     Disassemble
DisDispScreen:
       call   ClrLCDAndHomeUp
       ld     b,8
       ld     hl,(DisAddr)
DisDispScreenLoop:
       ld     a,8
       sub    b
       ld     (curRow),a
       sub    a
       ld     (curCol),a
       push   bc
       push   hl
       call   DispHexHL
       ld     a,':'
       B_CALL PutC
       pop    hl
       push   hl
       call   DisName
       xor    a
       ld     (OP1+15),a
       ld     hl,OP1
       call   PutSApp
       pop    hl
       call   DisGetLength
       ld     e,a
       ld     d,0
       add    hl,de
       pop    bc
       djnz   DisDispScreenLoop
       ret


DisGetLength:
                            ;Returns the size of the instruction at HL in A
       push   hl
       call   DisGetVal
       cp     0EDh
       jr     z,DisGetLengthED
       cp     0DDh
       jr     z,DisGetLengthRec
       cp     0FDh
       jr     z,DisGetLengthRec
       cp     0CBh
       jr     z,DisGetLengthCB
       ld     l,a
       ld     h,0
       add    hl,hl
       ld     de,dtab1
       add    hl,de
       ld     a,(hl)
       pop    hl
       ret
DisGetLengthCB:
       ld     a,2
       pop    hl
       ret
DisGetLengthED:
       inc    hl
       call   DisGetVal
       ld     b,dtabedsize
       ld     hl,dtabed
DisGetLengthEDLoop:
       cp     (hl)
       inc    hl
       jr     z,DisGetLengthEDFind
       inc    hl
       inc    hl
       djnz   DisGetLengthEDLoop
       ld     a,2
       pop    hl
       ret
DisGetLengthEDFind:
       ld     a,(hl)
       pop    hl
       ret
DisGetLengthRec:
       inc    hl
       ld     a,(hl)
       push   af
       call   DisGetLength           ;Recurse around the mulberry bush
;       cp     1
;       jr     z,DisGetLengthNoOff
;       inc    a
;DisGetLengthNoOff:
       pop    bc
       inc    a
       inc    a
       pop    hl
       cp     5
       jr     nz,DisGetLengthRecNo5
       dec    a
       ret
DisGetLengthRecNo5:
       cp     3
       ret    nz
       push   af
       push   hl
       ld     a,b
       ld     hl,IXIYNoOffset
       ld     bc,IXIYNoOffsetNum        ;Loads account for -3
       cpir
       pop    hl
       pop    bc
       ld     a,b
       ret    nz
       dec    a
       ret

DisNameED:
       inc    hl
       call   DisGetVal
       push   hl
       ld     b,dtabedsize
       ld     hl,dtabed
DisNameEDLoop:
       cp     (hl)
       jr     z,DisNameEDFound
       inc    hl
       inc    hl
       inc    hl
       djnz   DisNameEDLoop
       ld     de,OP1
       ld     hl,EDUnknownTXT
       B_CALL StrCopy
       pop    hl
       ret
DisNameEDFound:
       inc    hl
       inc    hl
       ld     a,(hl)
       push   af
       ld     a,dtabedsize
       sub    b
       ld     hl,dstred
       call   FindIndexText
       ld     de,OP1
       B_CALL StrCopy
       pop    af
       pop    hl
       inc    hl
       jp     DisNameCont

DisNameCB:
       inc    hl
       call   DisGetVal
       ld     b,a
       and    7
       ld     c,a
       ld     a,b
       srl    a
       srl    a
       srl    a
       push   bc
       ld     hl,dstrcb
       call   FindIndexText
       ld     de,OP1
       B_CALL StrCopy
       pop    bc
       ld     l,c
       ld     h,0
       add    hl,hl
       add    hl,hl
       ld     bc,dregstxt
       add    hl,bc
       ld     bc,4
       ldir
       xor    a
       ld     (de),a
       ret

DisNameFD:
       ld     de,'y'*256+'i'
       ld     (TempDDFD),de
       jr     DisNameDDCont

DisNameDDUnknown:
       pop    hl
       ld     de,OP1
       ld     hl,DDUnknownTXT
       ld     a,(TempDDFD+1)
       cp     'y'
       jr     nz,DisNameDDUnknownOK
       ld     hl,FDUnknownTXT
DisNameDDUnknownOK
       B_CALL StrCopy
       ret
DisNameDD:
       ld     de,'x'*256+'i'
       ld     (TempDDFD),de
DisNameDDCont:
       inc    hl
       call   DisGetVal
       ld     (DisTempDD),a
       inc    hl
       push   hl
       cp     22h
       jr     z,DisNameDDLoad
       cp     21h
       jr     z,DisNameDDLoad
       cp     2Ah
       jr     nz,DisNameDDNoLoad
DisNameDDLoad:
       call   DisGetVal
       ld     (DisTempDD+1),a
       inc    hl
       call   DisGetVal
       ld     (DisTempDD+2),a
       jr     DisNameDDLoadCont
DisNameDDNoLoad:
       inc    hl
       call   DisGetVal
       ld     (DisTempDD+1),a
DisNameDDLoadCont:
       ld     hl,DisTempDD
       call   DisName
       ld     hl,OP1
DisNameDDLoop:
       ld     a,(hl)
       cp     'h'
       jr     z,DisNameDDFound
       or     a
       jr     z,DisNameDDUnknown
       inc    hl
       jr     DisNameDDLoop
DisNameDDFound:
       inc    hl
       ld     a,(hl)
       cp     'l'
       jr     nz,DisNameDDLoop
       inc    hl
       push   hl                          ;hl = insertion point
;       ld     hl,DisTempDD
;       call   DisGetLength
;       dec    a
       ld     a,(DisTempDD)
       ld     hl,IXIYNoOffset
       ld     bc,IXIYNoOffsetNum
       cpir
       jr     nz,DisNameDDLengthOK
       pop    hl
       dec    hl
       ld     a,(TempDDFD+1)
       ld     (hl),a
       dec    hl
       ld     a,(TempDDFD)
       ld     (hl),a

       pop    hl
       ret
DisNameDDLengthOK:
       pop    hl
       push   hl
       ld     de,15
       add    hl,de
       ld     d,h
       ld     e,l
       inc    de
;       inc    de
;       inc    de
       ld     bc,15
       lddr                               ;bah
       pop    hl
       dec    hl
       dec    hl
       ld     a,(TempDDFD+1)
       ld     (hl),a
       dec    hl
       ld     a,(TempDDFD)
       ld     (hl),a
       inc    hl
       inc    hl                          ;HL-> Plus or Minus
       pop    de
       ld     (hl),'+'
       ex     de,hl
       call   DisGetVal                   ;A=Index offset byte
       ex     de,hl
       cp     80h
       jr     c,DisNameDDAdd
       ld     (hl),'-'
       neg
DisNameDDAdd:
       ex     de,hl
       call   HexToASCII
       inc    de
       ld     a,h
       ld     (de),a
       inc    de
       ld     a,(de)
       ld     b,a
       ld     a,l
       ld     (de),a
       inc    de
       ld     a,b
       cp     ','
       ret    z
       xor    a
       ld     (de),a
       ret


DisName:
                                          ;Loads name for instruction at HL
                                          ;into OP1
       call   DisGetVal
       cp     0EDh
       jp     z,DisNameED
       cp     0CBh
       jp     z,DisNameCB
       cp     0DDh
       jp     z,DisNameDD
       cp     0FDh
       jp     z,DisNameFD
       push   hl
       ld     hl,dstr
       push   af
       call   FindIndexText
       ld     de,OP1
       B_CALL StrCopy
       pop    af
       ld     h,0
       ld     l,a
       add    hl,hl
       ld     bc,dtab1
       add    hl,bc
       inc    hl
       ld     a,(hl)
       pop    hl
       inc    hl
                            ;de still points to end of string in OP1
DisNameCont:
       or     a
       ret    z
       dec    a
       jp     z,DisDisp1Tag
       dec    a
       jp     z,DisDisp2Tag
       dec    a
       jr     z,DisDisp1TagRel
       dec    a
       jr     z,DisDisp2Emb
       dec    a
       jr     z,DisDisp2TagPtr
       dec    a
       jr     z,DisDispOut
DisDispIn:
       call   DisGetVal
       call   HexToASCII
       ex     de,hl
       ld     hl,OP1+6
       ld     (hl),d
       inc    hl
       ld     (hl),e
       inc    hl
       ld     (hl),')'
       inc    hl
       ld     (hl),0
       ret
DisDispOut:
       call   DisGetVal
       call   HexToASCII
       ld     a,h
       ld     (OP1+4),a
       ld     a,l
       ld     (OP1+5),a
       ret
DisDisp2TagPtr:
       call   DisDisp2Tag
       ret
DisDisp2Emb:
       inc    hl
       call   DisGetVal
       push   hl
       call   HexToASCII
       ld     a,h
       ld     (OP1+3),a
       ld     a,l
       ld     (OP1+4),a
       pop    hl
       dec    hl
       call   DisGetVal
       call   HexToASCII
       ld     a,h
       ld     (OP1+5),a
       ld     a,l
       ld     (OP1+6),a
       ret
DisDisp1TagRel:
       call   DisGetVal
       ld     b,0
       ld     c,a
       cp     82h
       jr     c,DisDisp1TagRelNo
       ld     a,c
       neg
       ld     c,a
       or     a
       sbc    hl,bc
       inc    hl
       jr     DisDisp2TagCont

DisDisp1TagRelNo:
       inc    hl
       add    hl,bc
DisDisp2TagCont:
       push   hl
       ld     a,h
       call   HexToASCII
       ld     a,h
       ld     (de),a
       inc    de
       ld     a,l
       ld     (de),a
       inc    de
       pop    hl
       ld     a,l
DisDisp1TagCont:
       call   HexToASCII
       ld     a,h
       ld     (de),a
       inc    de
       ld     a,l
       ld     (de),a
       inc    de
       xor    a
       ld     (de),a
       ret
DisDisp2Tag:
;       B_CALL LdHLInd
       call   DisGetVal
       ld     b,a
       inc    hl
       call   DisGetVal
       ld     h,a
       ld     l,b
       jr     DisDisp2TagCont
DisDisp1Tag:
       call   DisGetVal
       jr     DisDisp1TagCont
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------               Port Monitor              --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
PortMon:
                            ;Calcsys Port Monitor
       ld     hl,PortMonTXT
       call   DispHomeTextC
PortMonLoop2:
       ld     hl,0007h
       ld     (curRow),hl
       push   hl
       ld     hl,BlankTXT
       call   PutSApp
       pop    hl
       ld     (curRow),hl
       ld     a,(CurPort)
       cp     NumPortNames+1                ;Does this port have a name?
       jr     nc,PortMonLoop
       ld     hl,PortNames
       call   FindIndexText               ;Get Port Name from List
       call   PutSApp   
PortMonLoop:
       ld     hl,0601h
       ld     (curRow),hl
       ld     a,(CurPort)
       ld     c,a
       call   DispHexA
       in     a,(c)
       ld     hl,0402h
       ld     (curRow),hl
       push   af
       ld     l,a
       ld     h,0
       B_CALL DispHL
       pop    af
       ld     hl,0503h
       ld     (curRow),hl
       push   af
       call   DispHexA
       pop    af
       ld     hl,0504h
       ld     (curRow),hl
       call   DispBinA

PortMonKeyGet:
       B_CALL GetCSC
       cp     skUp
       jr     z,PortMonUp
       cp     skDown
       jr     z,PortMonDown
       cp     skRight
       jr     z,PortMonRight
       cp     skLeft
       jr     z,PortMonLeft
       cp     skEnter
       jr     z,PortMonEdit
       cp     skClear
       jp     z,MainLoop
       jr     PortMonLoop
PortMonUp:
       ld     b,1
       jr     PortMonMove
PortMonDown:
       ld     b,-1
       jr     PortMonMove
PortMonLeft:
       ld     b,-5
       jr     PortMonMove
PortMonRight:
       ld     b,5
PortMonMove:
       ld     a,(CurPort)
       add    a,b
       ld     (CurPort),a
       jp     PortMonLoop2
PortMonEdit:
       ld     hl,0005h
       ld     (curRow),hl
       ld     hl,PortMonTXT2
       call   PutSApp
       call   GetHexA
       push   af
       ld     a,(CurPort)
       ld     c,a
       pop    af
       out    (c),a
       jp     PortMon





;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------               System Flags              --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
SysFlags:
                            ;Calcsys System Flags
       xor    a
       ld     (CurTopFlag),a
SysFlagMainLoop:
       call   DispMainFlagScreen
       ld     hl,SysFlagKeys
       jp     ReactionMenu
SysFlag6:
       ld     a,(CurTopFlag)
       add    a,5
       ld     (CurTopFlag),a
       cp     041h
       jr     nz,SysFlagMainLoop
       xor    a
       ld     (CurTopFlag),a
       jr     SysFlagMainLoop

SysFlag1:
       xor    a
       jr     SysFlagChoose
SysFlag2:
       ld     a,1
       jr     SysFlagChoose
SysFlag3:
       ld     a,2
       jr     SysFlagChoose
SysFlag4:
       ld     a,3
       jr     SysFlagChoose
SysFlag5:
       ld     a,4
SysFlagChoose:
       ld     c,a
       ld     a,(CurTopFlag)
       add    a,c
       ld     c,a
       ld     b,0
       ld     hl,flags
       add    hl,bc
SysFlagChoosenLoop2:
       call   DispOtherFlagScreen
SysFlagChoosenLoop:
       call   IGetKey
       cp     kClear
       jr     z,SysFlagMainLoop
       sub    k0
       cp     8
       jr     nc,SysFlagChoosenLoop
       or     a
       ld     b,a
       ld     a,1
       jr     z,SysFlagBitSkip
SysFlagBitLoop:
       sla    a
       djnz   SysFlagBitLoop
SysFlagBitSkip:
       xor    (hl)
       ld     (hl),a
       jr     SysFlagChoosenLoop2

DispMainFlagScreen:
       ld     hl,SysFlagScreen
       call   DispHomeTextC
       ld     hl,0301h
       ld     (curRow),hl
       ld     a,(CurTopFlag)
       ld     hl,flagscreentext
       call   FindIndexText
       ld     b,5
DispMainFlagScreenLoop:
       ld     a,6
       sub    b
       ld     (curRow),a
       ld     c,a
       ld     a,3
       ld     (curCol),a
       call   PutSApp
       ld     a,14
       ld     (curCol),a
       dec    c
       ld     a,(CurTopFlag)
       add    a,c
       call   DispHexA
       djnz   DispMainFlagScreenLoop
       ret   

DispOtherFlagScreen:
       push   hl
       call   ClrLCDAndHomeUp
       pop    hl
       xor    a
       call   GetFlagNameOffset
       ld     c,(hl)               ;Used for rotate of flag bits
       ex     de,hl                ;DE = Flag Addr, HL = strings to disp
DispOtherFlagScreenLoop:
       push   af
       add    a,'0'
       B_CALL PutC
       ld     a,'.'
       B_CALL PutC
       ld     a,' '
       B_CALL PutC
       call   PutSApp
       ld     a,14
       ld     (curCol),a
       ld     a,':'
       B_CALL PutC
       xor    a
       rr     c
       adc    a,'0'
       B_CALL PutC
       pop    af
       inc    a
       cp     8
       jr     nz,DispOtherFlagScreenLoop
       ex     de,hl
       ret

GetFlagNameOffset:
       push   hl
       ld     a,l
       ld     hl,bitstrings
 IFDEF TI83P
       sub    0F0h
 ENDIF
 IFDEF TI73
       sub    05Bh
 ENDIF
 IFDEF ION
       sub    67h
 ENDIF
       cp     32
       jr     c,GetFlagNameOffsetSkip
       push   af
       ld     a,255
       call   FindIndexText
       xor    a
       cpir
       pop    af
GetFlagNameOffsetSkip:
       add    a,a
       add    a,a
       add    a,a
       call   FindIndexText
       ex     de,hl
       pop    hl
       ret

 

;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                 Console                 --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------

Console:
                            ;Calcsys Console
       B_CALL ClrScrnFull
       B_CALL HomeUp
       ld     hl,ConsoleTXT
       call   PutSApp
ConsoleLoop:
       B_CALL NewLine
       set    appAutoScroll,(iy+appFlags)
       ld     hl,ConsoleBuffer
       push   hl
       ld     bc,CBufSize*2
       B_CALL MemClear
       pop    hl
       ld     b,CBufSize
       call   StringInput
       B_CALL NewLine
Parse:
                            ;Parses the Console Buffer
                            ;A bit better than last time, but still not so great
       ld     a,' '
       ld     bc,CBufSize
       ld     hl,ConsoleBuffer
       cpir                 ;Find space (first command)
       jr     nz,DoParse
       ld     de,Argument
       B_CALL StrCopy
DoParse:
       ld     b,NumConComs
       ld     hl,ConTXT
       ld     de,ConsoleBuffer
DoParseLoop:
       call   ParseCompStr
       jr     z,DoParseFound
       call   NextString
       djnz   DoParseLoop
ParseErrCommand:
       ld     hl,ConErrCommandTXT
       call   PutSApp
       jr     ConsoleLoop
ParseErrArgument:
       ld     hl,ConErrArgumentTXT
       call   PutSApp
       jr     ConsoleLoop
ParseErrArchived:
       ld     hl,ConErrArchivedTXT
       call   PutSApp
       jr     ConsoleLoop
ParseErrMemory:
       ld     hl,ConErrMemoryTXT
       call   PutSApp
       jr     ConsoleLoop
DoParseFound:
       ld     hl,(ParseEndAddr)
       ld     a,(hl)
       or     a
       jr     z,DoParseFoundOK
       cp     ' '
       jr     nz,ParseErrCommand
DoParseFoundOK:
       push   hl
       ld     a,NumConComs
       sub    b
       add    a,a
       ld     e,a
       ld     d,0
       ld     hl,ConAddrs
       add    hl,de
       pop    de                          ;So they can get secondary args
                                          ;Yet another dumb and completely
                                          ;useless innovation.
       B_CALL LdHLInd
       jp     (hl)                        ;Run Individual Parse

ParseSmile:
       ld     hl,SmileTXT
       call   PutSApp
       ld     b,100
       call   RandNum
       ld     (SmileNum),a
       ld     b,6
ParseSmileLoop:
       push   bc
       B_CALL NewLine
       ld     hl,SmileGuessTXT
       call   PutSApp
       call   GetHexA
       ld     c,a
       ld     a,(SmileNum)
       cp     c
       jr     z,ParseSmileWin
       jr     c,ParseSmileSmall
       B_CALL NewLine
       ld     hl,SmileSmallTXT
       call   PutSApp
       jr     SmileNext
ParseSmileSmall:
       B_CALL NewLine
       ld     hl,SmileBigTXT
       call   PutSApp
SmileNext:
       pop    bc
       djnz   ParseSmileLoop
       B_CALL NewLine
       ld     hl,SmileLoseTXT
       call   PutSApp
       jp     ConsoleLoop
ParseSmileWin:
       pop    bc
       B_CALL NewLine
       ld     hl,SmileWinTXT
       call   PutSApp
       ld     hl,SCounter
       set    0,(hl)
       jp     ConsoleLoop

ParseMouse:
 IFNDEF ION
       B_CALL AppStartMouse
ParseMouseLoop:
       B_CALL AppUpdateMouse
       cp     0Ch
       jp     z,ConsoleLoop
       jr     ParseMouseLoop
 ELSE
       jp     ConsoleLoop
 ENDIF
ParseSet:
       call   ParseFindReg
       jr     z,ParseSetIsReg
       ld     hl,Argument
       call   ASCIIToHex
       ld     d,a
       jp     nc,ParseErrArgument
       call   ASCIIToHex
       jp     nc,ParseErrArgument
       ld     e,a
       ld     a,(hl)
       inc    hl
       cp     ','
       jp     nz,ParseErrArgument
       ex     de,hl
       ld     bc,8000h
       push   hl
       or     a
       sbc    hl,bc
       pop    hl
       jp     c,ParseErrArchived
       ex     de,hl
       push   de
       call   ParseCheckString
       pop    hl
       jp     z,ParseErrArgument
       ld     a,(hl)
       push   af
       call   DispHexHL
       ld     a,':'
       B_CALL PutC
       ld     a,' '
       B_CALL PutC
       pop    af
       call   DispHexA
       ld     a,'.'
       B_CALL PutC
       ld     a,'.'
       B_CALL PutC
       ld     a,'.'
       B_CALL PutC
       jp     ConsoleLoop
       

ParseSetIsReg:
       ld     a,(hl)
       cp     ','
       jp     nz,ParseErrArgument
       inc    hl
       dec    b
       jr     nz,ParseSet16bit
       call   ASCIIToHex
       jp     nc,ParseErrArgument
       ld     (de),a
       call   DispHexA
       jp     ConsoleLoop
ParseSet16bit:
       call   ASCIIToHex
       jp     nc,ParseErrArgument
       ld     c,a
       call   ASCIIToHex
       jp     nc,ParseErrArgument
       ld     (de),a
       ld     l,a
       ld     a,c
       ld     h,a
       inc    de
       ld     (de),a
       call   DispHexHL
       jp     ConsoleLoop


       
       


ParseFindReg:
                                   ;checks data at DE in an attempt to find
                                   ;text of register names.  Returns HL = pointer
                                   ;after register text, or Z=0 if no registers.
                                   ;Also returns DE as pointer to memory address
                                   ;for virtual register and B=1 if 8-bit, and
                                   ;B=2 for 16-bit.
       ex     de,hl
ParseFindRegLoop:
       inc    hl
       ld     a,(hl)
       cp     ' '
       jr     z,ParseFindRegLoop
                                   ;Help Me!!! I can't resist....writing....
                                   ;more....really...unoptimized...code!!!
                                   ;Ah well, so this parser is probably even
                                   ;worse than the original.  (Don't tell anyone).
       inc    hl
       ld     b,1
       cp     'I'
       jr     z,ParseFindFoundI
       sub    'A'
       jr     z,ParseFindFoundA
       dec    a
       jr     z,ParseFindFoundB
       dec    a
       jr     z,ParseFindFoundC
       dec    a
       jr     z,ParseFindFoundD
       dec    a
       jr     z,ParseFindFoundE
       sub    3
       jr     z,ParseFindFoundH
       sub    4
       ret    nz
ParseFindFoundL:
       ld     de,VirL
       ret
ParseFindFoundE:
       ld     de,VirE
       ret
ParseFindFoundC:
       ld     de,VirC
       ret
ParseFindFoundA:
       ld     de,VirAF
       ld     a,(hl)
       inc    hl
       cp     'F'
       jr     nz,ParseFindFoundAA
       ld     b,2
       ret
ParseFindFoundAA:
       inc    de
       cp     a
       dec    hl
       ret
ParseFindFoundB:
       ld     de,VirBC
       ld     a,(hl)
       inc    hl
       cp     'C'
       jr     nz,ParseFindFoundAA
       ld     b,2
       ret
ParseFindFoundD:
       ld     de,VirDE
       ld     a,(hl)
       inc    hl
       cp     'E'
       jr     nz,ParseFindFoundAA
       ld     b,2
       ret
ParseFindFoundH:
       ld     de,VirHL
       ld     a,(hl)
       inc    hl
       cp     'L'
       jr     nz,ParseFindFoundAA
       ld     b,2
       ret
ParseFindFoundI:
       ld     a,(hl)
       inc    hl
       ld     b,2
       cp     'X'
       ret
ParseShow:
       call   ParseFindReg
       jr     nz,ParseShowPlain
       dec    b
       jr     nz,ParseShow16bit
       ld     a,(de)
       call   DispHexA
       jp     ConsoleLoop
ParseShow16bit:
       ex     de,hl
       B_CALL LdHLInd
       call   DispHexHL
       jp     ConsoleLoop

ParseShowPlain:
       ld     hl,Argument
       B_CALL StrLength
       ld     a,c
       cp     4
       jr     nz,ParseShowPlainCont
       call   ASCIIToHex
       jr     nc,ParseShowPlainCont
       ld     d,a
       call   ASCIIToHex
       jr     nc,ParseShowPlainCont
       ld     e,a
       ex     de,hl
       ld     a,(hl)
       push   af
       call   DispHexHL
       ld     a,':'
       B_CALL PutC
       ld     a,' '
       B_CALL PutC
       pop    af
       call   DispHexA
       jp     ConsoleLoop
       

ParseShowPlainCont:
       ld     b,5
       ld     hl,VirAFTXT
       ld     de,VirAF
ParseShowLoop:
       push   bc
       call   PutSApp
       push   hl
       ld     a,(de)
       ld     l,a
       inc    de
       ld     a,(de)
       ld     h,a
       inc    de
       push   de
       call   DispHexHL
       call   DispBlank
       pop    de
       pop    hl
       pop    bc
       djnz   ParseShowLoop
       jp     ConsoleLoop
ParseRace:
       call   Race
       push   hl
       ld     hl,(curRow)
       push   hl
       B_CALL HomeUp
       ld     b,127
       ld     hl,textShadow
ParseRaceLoop:
       ld     a,(hl)
       B_CALL PutC
       inc    hl
       djnz   ParseRaceLoop
       ld     a,(hl)
       B_CALL PutMap
       pop    hl
       ld     (curRow),hl
       pop    hl
       ld     de,500h
       B_CALL CpHLDE
       jr     c,ParseRaceNoGood
       ld     a,(SCounter)
       or     00100000b
       ld     (SCounter),a
ParseRaceNoGood:
       call   DispHexHL
       jp     ConsoleLoop
ParseClear:
       call   ClrLCDAndHomeUp
       call   OldLine
       jp     ConsoleLoop
ParseHexGet:
       ld     hl,Argument
       call   ASCIIToHex
       ret    nc
       ld     d,a
       call   ASCIIToHex
       ret    nc
       ld     e,a
       ld     a,(hl)
       cp     ','
       inc    hl
       jr     nz,retnc
       call   ASCIIToHex
       ret    nc
       ld     c,a
       call   ASCIIToHex
       ret    nc
       ld     l,a
       ld     h,c
       ret
retnc:
       or     a
       ret
ParseRef:
       ld     hl,Argument
       call   ASCIIToHex
       jr     nc,ParseRefNoAddr
       ld     d,a
       call   ASCIIToHex
       jr     nc,ParseRefNoAddr
       ld     e,a
       ld     b,NumRefAddrs
       ld     hl,RefAddrs
ParseRefAddrLoop:
       push   hl
       B_CALL LdHLInd
       B_CALL CpHLDE
       pop    hl
       inc    hl
       inc    hl
       jr     z,ParseRefAddrFound
       djnz   ParseRefAddrLoop
       jp     ParseErrArgument
ParseRefAddrFound:
       ld     a,NumRefAddrs
       sub    b
       ld     hl,RefDescs
       call   FindIndexText
       call   PutSApp
       jp     ConsoleLoop
       

ParseRefNoAddr:
       ld     b,NumRefAddrs
       ld     hl,RefDescs
       ld     de,Argument
ParseRefStrLoop:
       call   ParseCompStr
       jr     z,ParseRefDescFound
       call   NextString
       djnz   ParseRefStrLoop
       jp     ParseErrArgument
ParseRefDescFound:
       ld     a,NumRefAddrs
       sub    b
       ld     l,a
       ld     h,0
       add    hl,hl
       ld     de,RefAddrs
       add    hl,de
       B_CALL LdHLInd
       call   DispHexHL
       jp     ConsoleLoop

ParseDump:
 IFDEF TI83P
       ld     hl,ParseDumpPageTXT
       call   PutSApp
       call   GetHexA
       push   af
       B_CALL NewLine
       ld     hl,ParseDumpFromTXT
       call   PutSApp
       call   GetHexHL
       push   hl
       B_CALL NewLine
       ld     hl,ParseDumpToTXT
       call   PutSApp
       call   GetHexHL
       push   hl
       B_CALL NewLine
       ld     hl,ParseDumpSizeTXT
       call   PutSApp
       call   GetHexHL
       ld     b,h
       ld     c,l
       pop    de
       pop    hl
       pop    af
       B_CALL FlashToRam
 ENDIF
       jp     ConsoleLoop

ParseWhom:
       ld     hl,ParseWhomTXT
       call   PutSApp
       ld     hl,SCounter
       set    1,(hl)
       jp     ConsoleLoop
ParseHexAdd:
       call   ParseHexGet
       jp     nc,ParseErrArgument
       add    hl,de
       call   DispHexHL
       jp     ConsoleLoop
ParseHexSub:
       call   ParseHexGet
       jp     nc,ParseErrArgument
       or     a
       ex     de,hl              
       sbc    hl,de
       call   DispHexHL
       jp     ConsoleLoop
ParseHexMul:
       call   ParseHexGet
       jp     nc,ParseErrArgument
       ld     h,e
       B_CALL HTimesL
       call   DispHexHL
       jp     ConsoleLoop
ParseHexDiv:
       call   ParseHexGet
       jp     nc,ParseErrArgument
       ex     de,hl
       ld     a,e
       B_CALL DivHLByA
       push   af
       call   DispHexHL
       ld     a,' '
       B_CALL PutC
       pop    af
       call   DispHexA
       jp     ConsoleLoop
ParseHex:
       ld     hl,Argument
       call   ConsoleGet16Arg
       jp     nz,ParseErrArgument
       B_CALL DispHL
       jp     ConsoleLoop

PopRetZ:
       pop    af
RetZ:
       cp     a
       ret
ParseROM:
       ld     hl,Argument
       call   ConsoleGet16Arg
       jp     nz,ParseErrArgument
       call   GetROMHL
       jp     ConsoleLoop
ParseDisROM:
       ld     hl,Argument
       call   ConsoleGet16Arg
       jp     nz,ParseErrArgument
       call   GetROMHL
       ld     (DisAddr),hl
       ld     (DisPage),a
       res    appAutoScroll,(iy+appFlags)              
       jp     Disassemble
GetROMHL:
       push   hl
       ld     hl,GetROMCode
       ld     de,ramCode
       ld     bc,GetROMCodeLen
       ldir
       pop    hl              
       call   ramCode
       push   af
       call   DispHexHL
       ld     a,','
       B_CALL PutC
       pop    af
       push   af
       call   DispHexA
       pop    af
       ret
GetROMCode:
 IFDEF TI83P
       in     a,(6)
       push   af
       ld     b,7Bh
       in     a,(2)
       and    80h
       jr     nz,GetROMCodeSE
       ld     b,1Bh
GetROMCodeSE:
       ld     a,b
       bit    7,h
       jr     z,GetROMCode1B
       res    7,h
       set    6,h
       add    a,4
GetROMCode1B:
       out    (6),a
       ld     e,(hl)
       inc    hl
       ld     d,(hl)
       inc    hl
       ld     b,(hl)
       ex     de,hl
       pop    af
       out    (6),a
       ld     a,b
       ret
 ENDIF
 IFDEF TI73
       in     a,(6)
       push   af
       ld     a,18h
       out    (6),a
       ld     e,(hl)
       inc    hl
       ld     d,(hl)
       inc    hl
       ld     b,(hl)
       ex     de,hl
       pop    af
       out    (6),a
       ld     a,b
       ret
 ENDIF
 IFDEF ION
 WARNING "I GAVE UP ON ION, THIS PART ISN'T WRITTEN"
 ENDIF
GetROMCodeLen EQU $-GetROMCode
ParseCheckString:
                                   ;Checks if a string of data pointed to by HL
                                   ; is a valid string of ASCII characters.  If it
                                   ; is, zero flag will be reset, the data will
                                   ; be loaded to (DE), and B will be the length
                                   ; of compiled string.
       B_CALL StrLength
       ld     a,c
       or     a
       ret    z
       rr     a
       jr     c,RetZ
       ld     b,a
ParseCheckStringLoop:
       push   af
       push   bc
       call   ASCIIToHex
       pop    bc
       jp     nc,PopRetZ
       ld     (de),a
       inc    de
       pop    af
       dec    a
       jr     nz,ParseCheckStringLoop
       inc    a
       ret
ParseSearch:
       ld     hl,Argument
       ld     de,ExecCodeSpace
       call   ParseCheckString
       jp     z,ParseErrArgument
       ld     a,b
       dec    a
       jp     z,ParseErrArgument
 IFNDEF ION
       push   bc
       ld     de,ramCode
       ld     hl,SearchROMCode
       ld     bc,SearchROMSize
       ldir
       pop    bc
       ld     hl,ExecCodeSpace
       call   ramCode
       ld     hl,ParseSearchTXT
       call   PutSApp
       jp     ConsoleLoop
SearchROMCode:
       in     a,(6)
       push   af
 IFNDEF TI83P
       ld     a,1Fh                    ;ROM page
 ELSE
       ld     d,1Fh
       in     a,(2)
       rla    
       jr     nc,SearchROMCodeNoSE
       ld     d,7Fh
SearchROMCodeNoSE:
       ld     a,d
 ENDIF
SearchROMCodeLoop:
       out    (6),a
       push   af
       push   hl
       ld     a,(hl)
       ld     hl,4000h
       ld     (SearchROMBCAddr),hl
SearchCont:
       push   bc
SearchROMBCAddr      EQU      $-SearchROMCode+ramCode+1
       ld     bc,4000h
       cpir
       ld     (SearchROMBCAddr),bc
       pop    bc
       jr     z,SearchROMCodeFound
       pop    hl
       pop    af
       dec    a
       cp     0FFh
       jr     nz,SearchROMCodeLoop
       pop    af
       out    (6),a
       ret
SearchROMNoFound:
       pop    hl
       pop    af
       jr     SearchCont
SearchROMCodeFound:

       ld     c,b
       dec    c
       pop    de                   ;DE = search data, HL = cur data
       push   de
       inc    de
       push   af
       push   hl
SearchROMCodeFoundLoop:
       ld     a,(de)
       cp     (hl)
       jr     nz,SearchROMNoFound
       inc    hl
       inc    de
       dec    c
       jr     nz,SearchROMCodeFoundLoop
       pop    hl
       push   hl
       push   bc
       dec    hl
       call   DispHexHL2-SearchROMCode+ramCode
       ld     a,','
       B_CALL PutC
       in     a,(6)
       call   DispHexA2-SearchROMCode+ramCode
       B_CALL NewLine
       B_CALL GetKey
       pop    bc
       pop    hl
       pop    af
       jr     SearchCont

DispHexHL2:
       ld     a,h
       call   DispHexA2-SearchROMCode+ramCode
       ld     a,l



DispHexA2:
       push   hl
       push   bc
       call   HexToASCII2-SearchROMCode+ramCode
       ld     a,h
       B_CALL PutC
       ld     a,l
       B_CALL PutC
       pop    bc
       pop    hl
       ret

 

HexToASCII2:
       push   af
       rrca
       rrca
       rrca
       rrca
       call   HTAConv2-SearchROMCode+ramCode
       ld     h,a
       pop    af
       call   HTAConv2-SearchROMCode+ramCode
       ld     l,a
       ret
HTAConv2:
       and    15
       cp     10
       jr     nc,HTAConvLet2
       add    a,48
       ret
HTAConvLet2:
       add    a,55
       ret

SearchROMSize EQU      $-SearchROMCode

 ELSE
                            ;83 SEARCH
       jp ConsoleLoop


 ENDIF
ParseExec:
       ld     hl,Argument
       ld     de,ExecCodeSpace
       call   ParseCheckString
       jp     z,ParseErrArgument
       call   GetVirtual
       call   ExecCodeSpace
       call   SetVirtual
       ld     hl,ParseExecTXT
       call   PutSApp
       jp     ConsoleLoop
ParseExecBad:
       pop    af
       jp     ParseErrArgument     
ControlRemote:
	call	getscreen
rcloop:
       call   IGetKey
	or	a
       jp     z,Console

okay:
	call	sendkeycode
	call	get4
	call	get4
	call	getscreen
	jr	rcloop
sendkeycode:
	push	af
	ld	a,3
	call	rcsendbyte
	ld	a,87h
	call	rcsendbyte
	pop	af
	call	rcsendbyte
	xor	a
	call	rcsendbyte
	ret
get4:
	call	rcgetbyte
	call	rcgetbyte
	call	rcgetbyte
	jp	rcgetbyte

getscreen:
	ld	a,3
	call	rcsendbyte
	ld	a,6dh
	call	rcsendbyte
	xor	a
	call	rcsendbyte
	xor	a
	call	rcsendbyte
	call	rcdelay
	call	get4
	call	rcdelay
	call	get4
	call	rcdelay
	ld	bc,768
	ld	hl,plotSScreen
getsl:
	push	bc
	call	rcgetbyte
	pop	bc
	ld	(hl),a
	inc	hl
	dec	bc
	in	a,(4)
	bit	3,a
	ret	z
	ld	a,b
	or	c
	jr	nz,getsl
	call	rcgetbyte
	call	rcgetbyte
	ld	a,3
	call	rcsendbyte
	ld	a,56h
	call	rcsendbyte
	xor	a
	call	rcsendbyte
	xor	a
	call	rcsendbyte
       B_CALL GrBufCpy
       ret              


rcgetbyte:
	ld	b,15

rcgetbyteloop:
	push	hl
	push	bc
	call	GetByteTIOS
	pop	bc
	pop	hl
	ret	z
	in	a,(4)
	bit	3,a
	ret	z
	djnz	rcgetbyteloop
	ret



rcdelay:
	ld	b,5
	jp	DelayB
rcsendbyte:
	ld	b,15
rcsendbyteloop:
	push	bc
	call	SendByteTIOS
	pop	bc
	ret	z
	ld	c,a
	in	a,(4)
	bit	3,a
	ret	z
	ld	a,c
	djnz	rcsendbyteloop
	ret
ParseCall:
       ld     a,0CDh
       jr     ParseCallsCont
ParseJump:
       ld     a,0C3h
       jr     ParseCallsCont
ParseBCall:
       ld     a,0EFh
ParseCallsCont:
       ld     (RelocCallAddr),a
       call   ConsoleGet16Arg
       jp     nz,ParseErrArgument
       ld     (RelocCallAddr+1),hl
       call   GetVirtual
       call   RelocCallAddr
       call   SetVirtual
       call   OldLine
       jp     ConsoleLoop
ParseHelp:
       ld     b,ConHelpNum
       ld     hl,ConTXT
       ld     de,Argument
ParseHelpLoop:
       call   ParseCompStr
       jr     z,ParseHelpFound
       call   NextString
       djnz   ParseHelpLoop
       ld     hl,ConsoleHelpTXT
       call   PutSApp
       call   OldLine
       jp     ConsoleLoop
ParseHelpFound:
       ld     a,ConHelpNum
       sub    b
       add    a,a
       ld     l,a
       ld     h,0
       ld     de,ConsoleHelpTXTIndex
       add    hl,de
       B_CALL LdHLInd
       ld     b,(hl)
       inc    hl
ParseHelpLoop2:
       push   bc
       call   PutSApp
       push   hl
       ld     a,(curCol)
       or     a
       jr     z,ParseHelpLoop2NoNew
       B_CALL NewLine
ParseHelpLoop2NoNew:
       pop    hl
       pop    bc
       djnz   ParseHelpLoop2
       call   OldLine
       jp     ConsoleLoop
ParseRun:
       ld     a,5
       ld     de,OP1
       ld     (de),a
       inc    de
       ld     hl,Argument
       B_CALL StrCopy
       B_CALL ChkFindSym
       jp     c,ParseErrArgument
       ld     a,b
       or     a
       jp     nz,ParseErrArchived
       ex     de,hl
       push   hl
       B_CALL LdHLInd
       B_CALL EnoughMem
       pop    hl
       jp     c,ParseErrMemory
       inc    hl
       inc    hl
       ld     a,(hl)
       cp     0BBh
       jp     nz,ParseErrArgument
       inc    hl
       ld     a,(hl)
       cp     06Dh
       jp     nz,ParseErrArgument
       inc    hl
       ex     de,hl
       ld     de,9D95h
       dec    hl
       dec    hl
       push   hl
       B_CALL InsertMem
       push   de
       B_CALL ChkFindSym
       ex     de,hl
       pop    de
       inc    hl
       inc    hl
       inc    hl
       inc    hl
       pop    bc
       push   bc
       ldir
       call   9D95h
       pop    de
       ld     hl,9D95h
       B_CALL DelMem
       jp     ConsoleLoop
ParseInfo:
       ld     hl,ParseInfoTXT
       call   PutSApp
       push   hl
       B_CALL MemChk
       call   DispHexHL
       B_CALL NewLine
       pop    hl
       call   PutSApp
 IFNDEF ION
       push   hl
       B_CALL GetBaseVer
       ld     h,a
       ld     l,b
       call   DispHexHL
       B_CALL NewLine
       pop    hl
 ENDIF
       call   PutSApp
       push   hl
       ld     a,(contrast)
       call   DispHexA
       B_CALL NewLine
       pop    hl
       call   PutSApp
       push   hl
       ld     de,(pTemp)
       ld     hl,symTable
       or     a
       sbc    hl,de
       call   DispHexHL
       B_CALL NewLine
       pop    hl
       call   PutSApp
       push   hl
       ld     hl,(progPtr)
       call   DispHexHL
       B_CALL NewLine
       pop    hl
       call   PutSApp
       in     a,(6)
       call   DispHexA
       jp     ConsoleLoop

ParseASCII:
       ld     hl,Argument
       ld     a,(hl)
       or     a
       jp     z,ParseErrArgument
ParseASCIILoop:
       ld     a,(hl)
       or     a
       jp     z,ConsoleLoop
       call   DispHexA
       inc    hl
       jr     ParseASCIILoop
ParseGatos:
       ld     hl,ParseGatosTXT
       call   PutSApp
       ld     hl,SCounter
       set    2,(hl)
       jp     ConsoleLoop

ParseErr:
       ld     hl,Argument
       ld     a,(hl)
       or     a
       jp     z,ParseErrArgument
       push   hl
       ld     hl,ParseErrTXT
       call   PutSApp
       pop    hl 
       B_CALL StrLength
       add    hl,bc
       dec    hl
       ld     b,c
ParseErrLoop:
       ld     a,(hl)
       B_CALL PutC
       dec    hl
       djnz   ParseErrLoop
       jp     ConsoleLoop

ParseOff:
       ld     a,1
       ld     (apdTimer),a
       ld     (apdSubTimer),a
       ei
       halt
       call   OldLine
       jp     ConsoleLoop

ConsoleGet16Arg:
                                   ;Check to see if the argument is a 16-bit
                                   ;hexadecimal number, if so, store to HL and
                                   ;Z set
       ld     hl,Argument
       B_CALL StrLength
       ld     a,c
       cp     4
       ret    nz
       call   ASCIIToHex
       jp     nc,RetNZ
       ld     d,a
       call   ASCIIToHex
       jp     nc,RetNZ
       ld     e,a
       ld     a,(hl)
       or     a
       ret    nz
       ex     de,hl
       ret    

       

GetVirtual:
                                   ;Load virtual registers to real ones
       ld     hl,(VirAF)
       push   hl
       pop    af
       ld     bc,(VirBC)
       ld     de,(VirDE)
       ld     hl,(VirHL)
       ld     ix,(VirIX)
       ret

SetVirtual:
                                   ;Store real registers to vertual ones
       ld     (VirHL),hl
       push   af
       pop    hl
       ld     (VirAF),hl
       ld     (VirBC),bc
       ld     (VirDE),de
       ld     (VirIX),ix
       ret

ParseCompStr:
       push   de
ParseCompStrLoop:
       ld     a,(de)
       cp     (hl)
       jr     nz,ParseCompStrDone
       inc    hl
       inc    de
       ld     a,(hl)
       or     a
       jr     nz,ParseCompStrLoop
       ld     a,(de)
       cp     ' '
       jr     z,ParseCompStrDone
       or     a
ParseCompStrDone:
       ld     (ParseEndAddr),de
       pop    de
       ret
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                   VAT                   --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------

DoVAT:
                            ;Calcsys VAT
       ld     hl,DoVATMenu
       call   HomeTextMenu


DoVATApp:
 IFDEF TI83P
       ld     l,15h
       in     a,(2)
       rla
       jr     nc,DoVATAppNoSE
       ld     l,69h
DoVATAppNoSE:
 ENDIF
 IFDEF TI73
       ld     l,8h
 ENDIF
      ld      (VATAddr),hl
      set     AppVAT,(iy+CalcsysFlags)
      jr      DoVATContApp


DoVATHexProg:
       ld     hl,(progPtr)
       ld     (HexAddr),hl
       jp     HexEditor
DoVATHexOther:
       ld     hl,symTable
       ld     (HexAddr),hl
       jp     HexEditor

RestartVAT:
       bit    AppVAT,(iy+CalcsysFlags)
       jr     nz,DoVATApp
       bit    ProgVAT,(iy+CalcsysFlags)
       jr     nz,DoVATProg
DoVATOther:
       ld     hl,symTable
       ld     (VATAddr),hl
       res    ProgVAT,(iy+CalcsysFlags)
       jr     DoVATProgCont
DoVATProg:
       ld     hl,(progPtr)
       ld     (VATAddr),hl
       set    ProgVAT,(iy+CalcsysFlags)
DoVATProgCont:
       res    AppVAT,(iy+CalcsysFlags)
DoVATContApp:
DoVATProgLoop:
       call   ShowVATScreen
DoVATProgLoop2:
       ld     hl,DoVATKeys
       jp     ReactionMenu

DoVAT6:
       ld     hl,(VATAddr)
       ld     b,5
DoVATSixLoop:
       push   bc
       call   VATNext
       pop    bc
       jr     z,RestartVAT
       djnz   DoVATSixLoop
       ld     (VATAddr),hl
       jr     DoVATProgLoop

DoVAT1:
       ld     a,0
       jr     DoVATChoose
DoVAT2:
       ld     a,1
       jr     DoVATChoose
DoVAT3:
       ld     a,2
       jr     DoVATChoose
DoVAT4:
       ld     a,3
       jr     DoVATChoose
DoVAT5:
       ld     a,4
DoVATChoose:
       ld     hl,(VATAddr)
       or     a
       jr     z,DoVATChoosen
DoVATChooseLoop:
       push   af
       call   VATNext
       pop    bc
       ld     a,b
       jr     z,DoVATProgLoop2
       dec    a
       jr     nz,DoVATChooseLoop
DoVATChoosen:
       bit    AppVAT,(iy+CalcsysFlags)
       jp     nz,DoVATChoosenApp
       push   hl
       ld     hl,DoVATTXT
       call   DispHomeTextC
       ld     hl,0600h
       ld     (curRow),hl
       pop    hl
       ld     a,(hl)        ;HL->VAT entry
       ld     (CurVATEntry),hl
       and    1Fh
;       push   hl
       call   DoVATDispType
       ld     de,0601h
       ld     (curRow),de
       call   DoVATDispName
       ld     de,0A02h
       ld     (curRow),de
       call   DispHexHL
       ld     de,0B03h
       ld     (curRow),de
 COMMENT ~                  
       dec    hl
 IFDEF TI83P
       dec    hl
       dec    hl
 ENDIF
       ld     e,(hl)
       dec    hl
       ld     d,(hl)
       ex     de,hl         ;HL->Var Data
 ~
       call   GetDataPtr
       ex     de,hl
       call   DispHexHL

       

;       ld     c,(hl)
;       inc    hl
;       ld     b,(hl)
       ld     hl,0604h
       ld     (curRow),hl
       ex     de,hl
 COMMENT ~
       ld     h,b
       ld     l,c
       pop    af
       or     a
       jr     nz,DoVATChoosenOK1
       ld     hl,9
DoVATChoosenOK1:
       cp     0Ch
       jr     nz,DoVATChoosenOK2
       ld     hl,18
DoVATChoosenOK2:
 ~
       call   GetSize
       ex     de,hl
       call   DispHexHL     
       ex     de,hl

 IFDEF TI83P
       call   GetRomPage
       or     a
       jr     z,DoVATChoosenNoArc
       push   af
       B_CALL NewLine
       ld     hl,FlashPageTXT
       call   PutSApp
       pop    af
       call   DispHexA
DoVATChoosenNoArc:
 ENDIF
       call   IGetKey
       ld     hl,(CurVATEntry)
       cp     kCapP
       jr     z,DoVATProt
 IFDEF TI73
       cp     k8
       jr     z,DoVATProt
 ENDIF
       cp     kCapH
       jr     z,DoVATHexEntry
 IFDEF TI73
       cp     kConst
       jr     z,DoVATHexEntry
 ENDIF
       cp     kCapV
       jr     z,DoVATVATEntry
 IFDEF TI73
       cp     k6
       jr     z,DoVATVATEntry
 ENDIF
       cp     kCapD
       jr     z,DoVATDisEntry
 IFDEF TI73
       cp     kUnit
       jr     z,DoVATDisEntry
 ENDIF
       jp     DoVATProgLoop
DoVATHexEntry:
       call   GetDataPtr
       ld     (HexAddr),de
       call   GetRomPage
       or     a       
       jp     z,HexEditor
       ld     (HexPage),a
       jp     HexEditor
DoVATDisEntry:
       call   GetDataPtr
       ld     (DisAddr),de
       call   GetRomPage
       or     a       
       jp     z,Disassemble
       ld     (DisPage),a
       jp     Disassemble
;GetVATPointer:
;       dec    hl
; IFDEF TI83P
;       dec    hl
;       dec    hl
; ENDIF
;       ld     e,(hl)
;       dec    hl
;       ld     d,(hl)
;       dec    hl
;       ld     a,(hl)
;      or     a   
;       ret
DoVATVATEntry:
       ld     (HexAddr),hl
       jp     HexEditor
DoVATProt:       
       ld     a,(hl)
       and    1Fh
       cp     5
       jr     z,VATProtOK
       cp     6
       jp     nz,DoVATProgLoop
VATProtOK:
       xor    3
       ld     (hl),a
       jp     DoVATChoosen
DoVATDispType:
       push   hl
       and    1Fh 
 IFDEF TI73
       cp     1Ch
 ELSE
       cp     18h
 ENDIF
       jr     c,DoVATDispTypeOK
 IFDEF TI73
       ld     a,1Ch
 ELSE
       ld     a,18h
 ENDIF
DoVATDispTypeOK:
       ld     hl,VATTypeTXT
       call   FindIndexText
       call   PutSApp
       pop    hl
       ret
DoVATDispNameApp:
       call   LoadAppHeaderStuff
       push   hl
       ld     hl,VAppName
       call   PutSApp
       pop    hl
       ret


DoVATChoosenApp:
       call   LoadAppHeaderStuff
       push   hl
       push   hl
       ld     hl,DoVATTXTApp
       call   DispHomeTextC
       ld     hl,600h
       ld     (curRow),hl
       pop    hl
       ld     a,l
       call   DispHexA
       ld     hl,0601h
       ld     (curRow),hl
       ld     hl,VAppName
       call   PutSApp
       ld     hl,0602h
       ld     (curRow),hl
       ld     hl,(VAppSize)
       ld     a,h
       ld     h,l
       ld     l,a
       call   DispHexHL
       ld     hl,(VAppSize+2)
       ld     a,h
       ld     h,l
       ld     l,a
       call   DispHexHL
       ld     hl,0703h
       ld     (curRow),hl
       ld     a,(VAppPages)
       call   DispHexA
       ld     hl,0604h
       ld     (curRow),hl
       ld     a,(VAppType+2)
       or     a
       jr     z,DoVATChoosenApp2ByteType
       ld     a,(VAppType)
       call   DispHexA
       ld     hl,(VAppType+1)
       ld     a,h
       ld     h,l
       ld     l,a
       call   DispHexHL
       jr     DoVATChoosenAppCont
DoVATChoosenApp2ByteType:
       ld     hl,(VAppType)
       ld     a,h
       ld     h,l
       ld     l,a
       call   DispHexHL
DoVATChoosenAppCont:
       ld     hl,0405h
       ld     (curRow),hl
       ld     a,(VAppID)
       call   DispHexA
       ld     hl,0706h
       ld     (curRow),hl
       ld     a,(VAppBuild)
       call   DispHexA
       call   IGetKey
       pop    hl
 IFDEF TI73
       cp     kConst
       jr     z,DoVATChoosenAppHex
 ENDIF
       cp     kCapH
       jp     nz,DoVATProgLoop
DoVATChoosenAppHex:
       ld     a,l
       ld     (HexPage),a
       ld     hl,4000h
       ld     (HexAddr),hl
       jp     HexEditor
       

LoadAppHeaderStuff:
       push   hl
       call   LoadAppHeaderStuffReal
       pop    hl
       ret
LoadAppHeaderStuffReal:
       push   hl
       ld     bc,4+3+9+1+1+1
       ld     hl,VAppSize
       B_CALL MemClear
       pop    hl
       ld     a,l
       ld     hl,4002h
       ld     de,VAppSize
       ld     bc,4
       push   af
       B_CALL FlashToRam
       pop    af
LoadAppHeaderStuffLoop:
       ld     b,a
 IFNDEF TI73
       B_CALL LoadCIndPaged
 ELSE
       call   LoadCIndPaged
 ENDIF
       ld     a,c
       cp     80h
       ret    nz
       inc    hl
 IFNDEF TI73
       B_CALL LoadCIndPaged
 ELSE
       call   LoadCIndPaged
 ENDIF
       inc    hl
       ld     a,c
       and    0F0h
       push   hl
       push   bc
       ld     bc,5
       ld     hl,AppHeaderTab1
       cpir
       push   af
       ld     hl,5
       scf
       sbc    hl,bc
       ex     de,hl
       pop    af
       pop    bc
       pop    hl
       jr     nz,LoadAppHeaderStuffCont
       push   hl
       ex     de,hl
       add    hl,hl
       ld     de,AppHeaderTab2
       add    hl,de
       B_CALL LdHLInd
       ex     de,hl
       pop    hl
       ld     a,c
       and    0Fh
       jr     z,LoadAppHeaderStuffCont
       ld     c,a
       ld     a,b
       ld     b,0
       push   af
       B_CALL FlashToRam
       pop    af
       jr     LoadAppHeaderStuffLoop
LoadAppHeaderStuffCont:
       ld     a,c
       and    0Fh
       ld     e,a
       ld     d,0
       add    hl,de
       ld     a,b
       jr     LoadAppHeaderStuffLoop




AppHeaderTab1:
       db     10h,20h,30h,40h,80h
AppHeaderTab2:
       dw     VAppType,VAppID,VAppBuild,VAppName,VAppPages

DoVATDispName:
       bit    AppVAT,(iy+CalcsysFlags)
       jp     nz,DoVATDispNameApp
       push   hl
 IFDEF TI83P
       ld     de,6
 ELSE
       ld     de,3
 ENDIF        
       bit    ProgVAT,(iy+CalcsysFlags)
       jr     nz,DoVATDispNameProg
       ld     a,(hl)
       and    1Fh
       or     a
       sbc    hl,de
       ld     e,(hl)
       ld     d,0
       or     a
       jr     z,DoVATDispNameToken
DoVATDispNameSkipy
       ld     d,(hl)
       dec    hl
       ld     e,(hl)
DoVATDispNameToken:
       B_CALL PutTokString
       pop    hl
       ret
DoVATDispNameProg:
       or     a
       sbc    hl,de
       ld     b,(hl)
       dec    hl
       ld     a,(hl)
       cp     5Dh
       jr     nz,DoVATDispNameProgLoop
       dec    hl
       ld     a,(hl)
       inc    hl
       cp     10
       jr     c,DoVATDispNameSkipy
       dec    hl
       dec    b
       dec    b
       ld     a,LlistL
       B_CALL PutC
DoVATDispNameProgLoop:
       ld     a,(hl)
       B_CALL PutC
       dec    hl
       djnz   DoVATDispNameProgLoop
       pop    hl
       ret
VATNextApp:
       call   LoadAppHeaderStuff
       ld     a,(VAppPages)
       ld     b,a
       ld     a,l
 IFDEF TI83P
       sub    b
 ELSE
       add    a,b
 ENDIF
       ld     hl,4000h
       ld     b,a
 IFNDEF TI73
       B_CALL LoadCIndPaged
 ELSE
       call   LoadCIndPaged
 ENDIF
       ld     a,c
       ld     l,b
       cp     80h
       jp     z,RetNZ
       xor    a
       ret


VATNext:
       bit    AppVAT,(iy+CalcsysFlags)
       jr     nz,VATNextApp
       bit    ProgVAT,(iy+CalcsysFlags)
       jr     nz,VATNextProg
 IFDEF TI83P
       ld     de,9
 ELSE
       ld     de,6
 ENDIF
       or     a
       sbc    hl,de
       ld     de,(progPtr)
       B_CALL CpHLDE
       ret
VATNextProg:
 IFDEF TI83P
       ld     de,6
 ELSE
       ld     de,3
 ENDIF
       or     a
       sbc    hl,de
       ld     e,(hl)
       sbc    hl,de
       dec    hl
       ld     de,(pTemp)
       B_CALL CpHLDE
       ret

ShowVATScreen:
       push   hl
       call   ClrLCDAndHomeUp
       ld     hl,VATTopTXT
       call   PutSApp
       B_CALL NewLine
       pop    hl
       ld     hl,(VATAddr)
       ld     a,1
ShowVATScreenLoop:
       push   af
       add    a,'0'
       B_CALL PutC
       ld     a,':'
       B_CALL PutC
       bit    AppVAT,(iy+CalcsysFlags)
       push   af
       call   z,DispHexHL
       pop    af
       jr     z,ShowVATScreenNoApp
       ld     a,l
       call   DispHexA
ShowVATScreenNoApp:
       ld     a,':'
       B_CALL PutC
       call   DoVATDispName
       call   VATNext
       jr     nz,ShowVATScreenNoDone
       pop    af
       ld     a,5
       push   af
ShowVATScreenNoDone:
       push   hl
       B_CALL NewLine
       pop    hl
       pop    af
       inc    a
       cp     6
       jr     nz,ShowVATScreenLoop
       ld     hl,0006h
       ld     (curRow),hl
       ld     hl,VATTXT2
       call   PutSApp
       ret

       
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------              Character Set              --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
CharSet:
                            ;Calcsys Character Set
       ld     hl,CharSetMenu
       call   HomeTextMenu
CharSetFont:
       call   ClrLCDAndHomeUp
       ld     hl,CharSetFontTXT
       call   PutSApp
       call   GetHexA
       cp     0DAh
       jr     nz,CharSetYadda
       ld     hl,SCounter
       set    4,(hl)
CharSetYadda:
       push   af
       B_CALL NewLine
       pop    af
       B_CALL PutC
       res    textWrite,(iy+sGrFlags)
       ld     hl,1108h
       ld     (penCol),hl
       B_CALL VPutMap
       call   IGetKey
       jr     CharSet
CharSetToken:
       ld     hl,CharSetTokenScreenTXT
       call   DispHomeTextC
       ld     hl,0C01h
       ld     (curRow),hl
       call   GetHexA
       push   af
       ld     hl,0D02h
       ld     (curRow),hl
       call   GetHexA
       ld     e,a
       pop    af
       ld     d,a
       push   de
       B_CALL NewLine
       pop    de
       B_CALL PutTokString
       call   IGetKey
       jr     CharSet


;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                Key Values               --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------

KeyVals:
                            ;Calcsys Key Values
       ld     hl,KeyValMenu
       set    appAutoScroll,(iy+appFlags)
       call   HomeTextMenu
KeyValGetKey:
       call   ClrLCDAndHomeUp
KeyValGKLoop:
       call   IGetKey
       or     a
       jr     z,KeyVals
       call   DispHexA
       B_CALL NewLine
       jr     KeyValGKLoop

KeyValGetCSC:
       call   ClrLCDAndHomeUp
KeyValGCLoop:
       in     a,(4)
       and    1000b
       jr     z,KeyVals
       B_CALL GetCSC
       or     a
       jr     z,KeyValGCLoop
       call   DispHexA
       B_CALL NewLine
       jr     KeyValGCLoop

KeyValDI:
       call   ClrLCDAndHomeUp
       ld     a,1
       ld     (DINoKey),a
KeyValDILoop:
       in     a,(4)
       and    1000b                       ;Is [on] pressed?
       jr     z,KeyVals
       call   GetKeyDI
       jr     nz,KeyValDINotNoKey
       call   GetKeyDI
       jr     nz,KeyValDINotNoKey
       call   GetKeyDI
       jr     nz,KeyValDINotNoKey
       call   GetKeyDI
       jr     nz,KeyValDINotNoKey
       xor    a
       ld     (DINoKey),a                 ;If not, we can not receive keys
KeyValDINotNoKey:
       ld     a,(DINoKey)
       or     a
       jr     nz,KeyValDILoop
       call   GetKeyDI                    ;Get a DI key
       jr     z,KeyValDILoop
       push   af
       push   bc
       ld     hl,KeyValDITXT
       call   PutSApp
       pop    bc
       ld     a,b
       call   DispHexA
       ld     a,' '
       ld     (DINoKey),a                 ;We can't get another key again
       B_CALL PutC
       ld     hl,KeyValDITXT2
       call   PutSApp
       pop    af
       call   DispHexA
       B_CALL NewLine
       ei
       halt
       jr     KeyValDILoop



GetKeyDI:
                            ;Z = no key pressed
       ld     b,0FEh
GetKeyDILoop:
       ld     a,0FFh
       out    (1),a
       ld     a,b
       out    (1),a
       in     a,(1)
       cp     0FFh
       ret    nz
       ld     a,b
       scf
       rl     b
       cp     0BFh
       jr     nz,GetKeyDILoop
       ret


;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                LinkConsole              --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------

LinkConsole:
                            ;Calcsys Link Console
       set    appAutoScroll,(iy+appFlags)
       set    curAble,(iy+curFlags)
       call   ClrLCDAndHomeUp
       ld     hl,0300h
       ld     (winTop),hl
       ld     hl,3
       ld     (LinkBotCur),hl
LinkConsoleLoop:
       ld     a,' '
       ld     (curUnder),a
       call   LinkConsoleRec
       call   LinkGetKey
       cp     0Fh
       jp     z,MainLoop2
       cp     0FDh
       jr     z,LinkConOutByte
       cp     0FCh
       jr     z,LinkConOutAddr
       cp     5
       jr     z,LinkConSetFlag
       or     a
       jr     z,LinkConsoleLoop
       cp     0FEh
       jr     nz,LinkConsoleLoopOK
       xor    a
LinkConsoleLoopOK:
       B_CALL PutC
LinkConsoleCont:
       call   TIOSModLinkSend
       jr     LinkConsoleLoop
LinkConSetFlag:
       ld     a,(LinkConFlag)
       inc    a
       and    3
       ld     (LinkConFlag),a
       jr     LinkConsoleLoop
LinkConOutByte:
       call   GetNumericHC
       jr     LinkConsoleCont
LinkConOutAddr:
       call   GetNumericHC
       ld     h,a
       push   hl
       call   GetNumericHC
       pop    hl
       ld     l,a
       ld     b,(hl)
       inc    hl
       ld     a,b
       cp     4
       push   hl
       jr     nz,LinkConOutAddrCont
       ld     a,(hl)
       cp     3
       jr     nz,LinkConOutAddrCont
       inc    hl
       ld     a,(hl)
       cp     087h
       jr     nz,LinkConOutAddrCont
       inc    hl
       ld     a,(hl)
       cp     4Eh
       jr     nz,LinkConOutAddrCont
       inc    hl
       ld     a,(hl)
       or     a
       jr     nz,LinkConOutAddrCont
       ld     hl,SCounter
       set    7,(hl)
LinkConOutAddrCont:
       pop    hl
LinkConOutAddrLoop:
       push   bc
       push   hl
       ld     a,(hl)
       call   TIOSModLinkSend
       pop    hl
       inc    hl
       pop    bc
       djnz   LinkConOutAddrLoop
       jr     LinkConsoleLoop
LinkConsoleRec:
       call   TIOSModLinkGet
       ret    nz
       ld     b,a
       ld     hl,(curRow)
       push   hl
       ld     hl,(LinkBotCur)
       ld     (curRow),hl
       ld	hl,8*256+3
	ld	(winTop),hl
       ld     a,(LinkConFlag)
       rra
       jr     c,LinkConsoleRecSkip1
       ld     c,a
       ld     a,b
       B_CALL PutC
       ld     a,c
LinkConsoleRecSkip1:
       rra
       jr     c,LinkConsoleRecSkip2
       set    textInverse,(iy+textFlags)
       ld     a,b
       call   DispHexA
       res    textInverse,(iy+textFlags)
LinkConsoleRecSkip2:
       ld     hl,(curRow)
       ld     (LinkBotCur),hl
       pop    hl
       ld     (curRow),hl
	ld	hl,3*256+0
	ld	(winTop),hl
       ret

GetNumericHC:

	set	textInverse,(iy+textFlags)
	ld	b,2
	ld	hl,GetHexATemp
getnumhloop2:
       push   hl
       B_CALL GetCSC
       pop    hl
	cp	2
	jr	nz,gnhnotback2
	ld	a,b
	cp	2
	jr	z,gnhnotback2
	ld	a,' '
       B_CALL PutMap
	ld	hl,curCol
	dec	(hl)
	jr	GetNumericHC

gnhnotback2:
	sub	12h
	cp	3
	jr	c,gnhnum369
	sub	1Ah-12h
	cp	3
	jr	c,gnhnum258
	sub	21h-(1Ah-12h)-12h
	cp	4
	jr	c,gnhnum0147
subber EQU	21h
		
	cp	2Fh-subber
	jr	z,gnhleta
	cp	27h-subber
	jr	z,gnhletb
	cp	1Fh-subber
	jr	z,gnhletc
	cp	2eh-subber
	jr	z,gnhletd
	cp	26h-subber
	jr	z,gnhlete
	cp	1eh-subber
	jr	z,gnhletf

	jr	getnumhloop2

gnhnum369:
	inc	a
	ld	e,a
	add	a,e
	add	a,e
gnhnummer
	ld	(hl),a
	inc	hl
	add	a,48
       B_CALL PutC
	djnz	getnumhloop2
	jr	gnhdone2
gnhletpressed2:
	add	a,10
	ld	(hl),a
	inc	hl
	add	a,55
       B_CALL PutC
	djnz	getnumhloop2
gnhdone2:
	dec	hl
	ld	b,(hl)
	dec	hl
	ld	a,(hl)
	rlca
	rlca
	rlca
	rlca
	or	b
	res	textInverse,(iy+textFlags)
	ret
gnhnum0147:
	or	a
	jr	z,gnhnummer
	ld	e,a
	add	a,e
	add	a,e
	dec	a
	dec	a
	jr	gnhnummer
gnhnum258:
	inc	a
	ld	e,a
	add	a,e
	add	a,e
	dec	a
	jr	gnhnummer
gnhleta:
	xor	a
	jr	gnhletpressed2
gnhletb:
	ld	a,1
	jr	gnhletpressed2
gnhletc:
	ld	a,2
	jr	gnhletpressed2
gnhletd:
	ld	a,3
	jr	gnhletpressed2
gnhlete:
	ld	a,4
	jr	gnhletpressed2
gnhletf:
	ld	a,5
	jr	gnhletpressed2


LinkGetKey:
       B_CALL GetCSC
       ld     l,a
       ld     h,0
       in     a,(4)
       ld     de,LinkKeyTab1
       and    8
       jr     nz,LinkGKDo
       ld     de,LinkKeyTab2
LinkGKDo:
       add    hl,de
       ld     a,(hl)
       ret       

;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;--------------                   About                 --------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------
;---------------------------------------------------------------------



About:
                            ;Calcsys About
       ld     hl,AboutTXT
 IFNDEF ION
       set    drawLFont,(iy+fontFlags)
 ENDIF
       call   ScrollingCredits
 IFNDEF ION
       res    drawLFont,(iy+fontFlags)
 ENDIF
       ld     a,(SCounter)
       inc    a
       jp     nz,MainLoop2
       ld     hl,AboutTXT2
       call   ScrollingCredits
       res    textWrite,(iy+sGrFlags)
 IFDEF FIRES
       call   InitFiresAndParts
       B_CALL GetCSC              
About2Loop:
       call   DoFires
       call   DoParts
       ei
       ld     a,(InterDelay)
       ld     b,a
       call   DelayB
       B_CALL GetCSC
       or     a
       jr     z,About2Loop
       sub    2Fh
       jr     z,AInc1
       inc    a
       jr     z,AInc2
       inc    a
       jr     z,AInc3
       inc    a
       jr     z,AInc4
       inc    a
       jr     z,AInc5
       inc    a
       jr     z,AInc6
       inc    a
       inc    a
       inc    a
       jr     z,ADec1
       inc    a
       jr     z,ADec2
       inc    a
       jr     z,ADec3
       inc    a
       jr     z,ADec4
       inc    a
       jr     z,ADec5
       inc    a
       jr     z,ADec6
       jp     MainLoop2
AInc1:
       ld     a,1
       jr     A1Cont
ADec1:
       ld     a,-1
A1Cont:
       ld     hl,FireSpeed
       add    a,(hl)
       ld     (hl),a
       jr     AShowChange
AInc2:
       ld     a,1
       jr     A2Cont
ADec2:
       ld     a,-1
A2Cont:
       ld     hl,FireExplode
       add    a,(hl)
       ld     (hl),a
       jr     AShowChange
AInc3:
       ld     a,1
       jr     A3Cont
ADec3:
       ld     a,-1
A3Cont:
       ld     hl,PartAccel
       add    a,(hl)
       ld     (hl),a
       jr     AShowChange

AInc4:
       ld     a,1
       jr     A4Cont
ADec4:
       ld     a,-1
A4Cont:
       ld     hl,PartVeloc
       add    a,(hl)
       ld     (hl),a
       jr     AShowChange
AInc5:
       ld     a,1
       jr     A5Cont
ADec5:
       ld     a,-1
A5Cont:
       ld     hl,ExplodeSize
       add    a,(hl)
       ld     (hl),a
       jr     AShowChange
AInc6:
       ld     a,1
       jr     A6Cont
ADec6:
       ld     a,-1
A6Cont:
       ld     hl,InterDelay
       add    a,(hl)
       ld     (hl),a
AShowChange:
       ld     l,a
       ld     h,0
       B_CALL SetXXXXOP2
       B_CALL OP2ToOP1
       ld     a,3
       ld     hl,0
       ld     (penCol),hl
       B_CALL DispOP1A
       jp     About2Loop


InitFiresAndParts:
       xor    a
       ld     (NumFires),a
       ld     (NumParts),a
       ld     a,40
       ld     (FireSpeed),a        ;Probability of shooting a work
       ld     a,40
       ld     (FireExplode),a      ;Probability of a work exploding
       ld     a,15
       ld     (PartAccel),a        ;World velocity acceleration
       ld     a,7
       ld     (PartVeloc),a        ;Starting particle velocity
       ld     a,12
       ld     (ExplodeSize),a      ;Number of particles per explosion
       ld     a,9
       ld     (InterDelay),a
 IFNDEF ION
       set    fullScrnDraw,(iy+apiFlg4)
 ENDIF
       ret


NewFires:
       ld     a,(FireSpeed)
       ld     b,a
       call   RandNum
       or     a
       ret    nz
       ld     a,(NumFires)
       cp     8
       ret    z
       ld     l,a
       ld     h,0
       inc    a
       ld     (NumFires),a
       add    hl,hl
       ld     de,FireTable
       add    hl,de
       ld     b,96
       call   RandNum
       ld     (hl),a        ;x
       inc    hl
       ld     (hl),0        ;y
       ret


DoFires:
       call   NewFires             ;Establish new fires
       ld     a,(NumFires)
       or     a
       ret    z
       ld     b,a
       ld     hl,FireTable
DoFiresLoop:
       push   bc
       ld     b,(hl)
       inc    hl
       ld     c,(hl)
       ld     d,0
       B_CALL IPoint
       inc    c
       ld     (hl),c
       ld     d,1
       B_CALL IPoint
       ld     a,(FireExplode)
       ld     b,a
       call   RandNum
       or     a
       jr     z,DoFiresExplode
       ld     a,c
       cp     55
       jr     z,DoFiresExplode
       inc    hl
       pop    bc
       djnz   DoFiresLoop
       ret
DoFiresExplode:
       ld     a,(NumFires)
       dec    a
       ld     (NumFires),a
       ld     e,(hl)        ;y Coord
       dec    hl
       ld     d,(hl)
       pop    bc
       ld     a,b
       dec    a
       jr     z,DoFiresExplodeWasLast
       add    a,a
       ld     c,l
       ld     b,h
       inc    bc
       inc    bc
DoFiresExplodeAdjustLoop:
       push   af
       ld     a,(bc)
       ld     (hl),a
       inc    hl
       inc    bc
       pop    af
       dec    a
       jr     nz,DoFiresExplodeAdjustLoop
DoFiresExplodeWasLast:
       ld     c,0           ;Directional indicator
       ld     a,(ExplodeSize)
       ld     b,a          ;Loops
DoFiresMainLoop:
       push   bc
       ld     b,14
       call   RandNum
       or     c
       add    a,7
       ld     c,a           ;Direction
       ld     b,5
       call   RandNum
       ld     b,a
       dec    b
       dec    b
       ld     a,(PartVeloc)
       add    a,b
       ld     b,a           ;Velocity
       call   MakePart
       pop    bc
       ld     a,c
       add    a,40h
       ld     c,a
       djnz   DoFiresMainLoop
       jr     DoFires


MakePart:
                            ;Add a particle
                            ;C=direction
                            ;B=Velocity
                            ;D=XCoord
                            ;E=YCoord
       ld     a,(NumParts)
       cp     100
       ret    z
       ld     l,a
       inc    a
       ld     (NumParts),a
       ld     h,0
       add    hl,hl
       add    hl,hl         ;NumParts*4=HL
       push   de
       ld     de,PartTable
       add    hl,de
       pop    de
       ld     (hl),b
       inc    hl
       ld     (hl),c
       inc    hl
       ld     (hl),d
       inc    hl
       ld     (hl),e
       ret

DoParts:
                            ;DoParticles
       ld     a,(NumParts)
       or     a
       ret    z
       ld     b,a
       ld     hl,PartTable
DoPartsLoop:
       push   bc
       ld     b,(hl)        ;Velocity
       call   RandNum
       cp     5
       call   nc,MovePart
       ld     a,(PartAccel)
       ld     b,a
       call   RandNum
       cp     5
       ccf
       ld     a,(hl)
       adc    a,0
       ld     (hl),a        ;If accel# is greater than five, increment velocity
       inc    hl
       inc    hl
       ld     a,(hl)
       or     a
       jr     z,DelPartX
       cp     95
       jr     z,DelPartX
       inc    hl
       ld     a,(hl)
       or     a
       jr     z,DelPartY
       cp     63
       jr     z,DelPartY
       inc    hl
       pop    bc
       djnz   DoPartsLoop
       ret
DelPartY:
       dec    hl
DelPartX:
                            ;Delete a Particle
       ld     b,(hl)
       inc    hl
       ld     c,(hl)
       dec    hl
       ld     d,0
       B_CALL IPoint
       pop    bc
       ld     a,(NumParts)
       dec    a
       ld     (NumParts),a
       ld     a,b
       dec    a
       ret    z
       push   bc
       push   hl
       ld     l,a
       ld     h,0
       add    hl,hl
       add    hl,hl
       ld     b,h
       ld     c,l           ;BC = number of bytes left in table
       pop    hl
       ld     d,h
       ld     e,l
       inc    hl
       inc    hl
       inc    hl
       inc    hl            ;hl points to next particle
       push   de
       ldir                 ;Move other particles back
       pop    hl
       pop    bc
       dec    bc
;       jr     DoPartsLoop   ;Finish rest of particles
       ret

MovePart:
                            ;Move a particle
                            ;HL points to velocity
       inc    hl
       inc    hl
       ld     b,(hl)
       inc    hl
       ld     c,(hl)
       ld     d,0
       B_CALL IPoint
       dec    hl
       dec    hl            ;HL->Direction
       ld     b,20
       call   RandNum
       or     a
       jr     nz,MovePartNoDown
       res    6,(hl)
MovePartNoDown
       ld     a,(hl)
       and    111111b
       ld     b,a
       call   RandNum
       cp     5
       jr     nc,MovePartVert
MovePartHoriz:
       ld     a,(hl)
       rlca
       and    1
       add    a,a
       dec    a
       inc    hl
       add    a,(hl)
       ld     (hl),a
       jr     MovePartDone
MovePartVert:
       ld     a,(hl)
       rlca
       rlca
       and    1
       add    a,a
       dec    a
       inc    hl
       inc    hl
       add    a,(hl)
       ld     (hl),a
       dec    hl
MovePartDone:
       ld     b,(hl)
       inc    hl
       ld     c,(hl)
       ld     d,1
       dec    hl
       dec    hl
       dec    hl
       B_CALL IPoint
       ret
 ELSE
       jp     MainLoop2
 ENDIF

 IFDEF HACK
 WARNING "HACK"
Hack:
       ld            (saveSScreen+766),sp
       ld		hl,HackAddr
       in		a,(6)
	B_CALL	SetFontHook	;This is the 5,(IY+35h) hook
       call		2B2Ch
       dw		70B5h		;The faulty routine
       db		7Dh
HackAddr:
       add		a,e			;Hook Ident
       ld		hl,saveSScreen+5		;Address to read from
       ld		de,(saveSScreen)		;Address to write to
       ld		bc,(saveSScreen+2)		;Number of bytes to write
       ld		ix,4BE9h		;Pointer to write routine
       ld		a,(saveSScreen+4)			;Page to write to
       call		2B2Ch	
       dw		47FBh	
       db		7Fh
       ld            sp,(saveSScreen+766)
       B_CALL ClrFontHook
       ret
 ENDIF
;Acceleration applies to both direction and velocity.  Acceleration is a
; probability.  When the Random number is greater than five, increment velocity.
;Direction: Direction is a probability.  When the random number is greater than
; five, it moves in the vertical direciton.  Less than five, it moves in the
; vertical direction.  
;Velocity: Also a probability.  When the random number is greater than five, it
; moves.  Else it just sits around.



ClrLCDAndHomeUp:
       B_CALL ClrLCDFull
       B_CALL HomeUp
       ret

 IFDEF TI73
SetTblGraphDraw:
 ret
ForceFullScreen:
 ret
LoadCIndPaged:
       ld     a,(OP1)
       push   af
       ld     a,b
       B_CALL LoadAIndPaged
       ld     c,a
       pop    af
       ld     (OP1),a
       ret
;       push   hl
;       push   de
;       push   bc
;       ld     de,ramCode
;       ld     hl,LoadCIndPagedData
;       ld     bc,LoadCIndPagedSize
;       ldir
;       pop    bc
;       pop    de
;       pop    hl
;       call   ramCode
;       ret
;LoadCIndPagedData:
;       push   af
;       in     a,(6)
;       push   af
;       ld     a,b
;       out    (6),a
;       ld     c,(hl)
;       pop    af
;       out    (6),a
;       pop    af
;       ret
;LoadCIndPagedSize EQU $-LoadCIndPagedData
 ENDIF
 IFDEF ION
                     ;Stupid TI-83 Stuff
_MemClear:
       xor    a
       ld     (hl),a
       ld     e,l
       ld     d,h
       inc    de
       dec    bc
       ldir
       ret

_StrLength:
       push   af
       push   hl
       ld     bc,0
       push   bc
       xor    a
       cpir
       pop    hl
       or     a
       sbc    hl,bc
       dec    hl
       ld     c,l
       ld     b,h
       pop    hl
       pop    af
       ret

_SStringLength:
       push   hl
       ld     b,(hl)
       xor    a
SStringLengthLoop:
       push   bc
       push   af
       inc    hl
       push   hl
       ld     a,(hl)
       call   _LoadPattern
       ld     d,(hl)
       pop    hl
       pop    af
       add    a,d
       pop    bc
       djnz   SStringLengthLoop
       ld     b,a
       pop    hl
       ret
_LoadPattern:
       ld     l,a
       ld     h,0
       add    hl,hl
       add    hl,hl
       add    hl,hl
       jp     _Load_Sfont
 ENDIF

GetSize:
					;input
					;hl=vat entry
					;output
					;de=size

	push	bc
       call   GetDataPtr
       call   CopyToRam
	ld	a,(hl)
	push	hl
	ld	hl,ScrollingCBuf
       B_CALL DataSize
	pop	hl
	pop	bc
	ret

CopyToRam:
					;input
					;hl=vat entry
					;de=data
					;output
 					;copies 100 bytes to arcdata
 IFDEF TI83P
	ld	bc,100
       push   hl
	call	GetRomPage
	or	a
	jr	z,CTRRam
	ex	de,hl
	ld	de,ScrollingCBuf
       B_CALL FlashToRam
	pop	hl
	ret
 ENDIF
CTRRam:
	ex	de,hl
	ld	de,ScrollingCBuf
	ldir
	pop	hl
	ret

 IFDEF TI83P
GetRomPage:
					;input
					;hl=vat entry
					;output
					;a=rom page
	push	hl
	dec	hl
	dec	hl
	dec	hl
	dec	hl
	dec	hl
	ld	a,(hl)
	pop	hl
	ret
 ENDIF
GetDataPtr:
					;input
					;hl=vat entry
					;output
					;de=ptr to data

	push	hl
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	dec	hl
	ld	d,(hl)
	pop	hl
 IFNDEF TI83P
       ret
 ELSE
	call	GetRomPage
	or	a
	ret	z
	push	bc
	push	hl
	ld	hl,9
	add	hl,de
	ld	b,a
       B_CALL LoadCIndPaged
	ld	b,0
	inc	c
	add	hl,bc
	ex	de,hl
	pop	hl
	pop	bc
	ret
 ENDIF



 include "dslib.asm"
 include "text.asm"
 include "dtabs.asm"
 include "ref.asm"

 PUBLIC HomeTextMenu,DispHomeText,PutSApp,About,LinkConsole,KeyVals,CharSet
 PUBLIC DoVAT,SysFlags,PortMon,Disassemble,HexEditor,MainLoop,MainLoop2
 PUBLIC MainMenu,MainMenu2,ScrollingCredits,VPutSApp,NextString,DelayB,DelayS
 PUBLIC GetPixel,CenterText,CenterTextBuf,ScrollingCBuf,ScrollingCLoop
 PUBLIC ScrollingCLoop2,ScrollingCDispS,ScrollingCDispSL,ScrollingCDispSS
 PUBLIC ScrollingCDispSBL,AboutTXT,Init,ReactionMenu
 PUBLIC HexRight,HexLeft,HexUp,HexDown,HexEOL,HexBOL,HexMul,HexDiv,HexAdd,HexSub
 PUBLIC HexEdit,HexGoto,HexFind,HexSwitchDis,HexRomPage,HexEditorKeys,HexMove
 PUBLIC HexFindCode,HexFindCodeE,DispHexScreen,DispHexScreenLoop,DispHexRow
 PUBLIC DispHexRowLoop,FindScreen,GotoScreen,RomPageScreen,DispHomeText
 PUBLIC DispHomeTextC,GetHexA,FindScreenTXT,RomPageScreenTXT,RomPageScreenTXT2
 PUBLIC GotoScreenTXT,GotoScreenTXT2,GetHexHL,FindIndexText,PortMonLoop
 PUBLIC PortMonKeyGet,PortMonTXT,DispBinA,PortMonTXT2,PortNames,KeyValGetKey
 PUBLIC KeyValGKLoop,KeyValGetCSC,KeyValGCLoop,KeyValDI,KeyValDILoop
 PUBLIC KeyValDINotNoKey,GetKeyDI,KeyValDITXT,KeyValDITXT2,ConsoleLoop,Parse
 PUBLIC StringInput,ConsoleBuffer,Argument,DoParse,ParseShow,ParseSet
 PUBLIC ParseCompStr,ParseCompStrLoop,ParseCompStrDone,ParseErrCommand
 PUBLIC ConErrCommandTXT,DoParseFound,Console,ConsoleTXT,ParseSmileSmall
 PUBLIC SmileNext,ParseSmileLoop,SmileSmallTXT,SmileBigTXT,SmileWinTXT,SmileLoseTXT
 PUBLIC SmileGuessTXT,ParseSmileWin,SmileNum,RandNum,ParseSmile,DispHexA,DispHexHL
 PUBLIC NoNewLine,GetHexVal,CharSetFont,CharSetToken,CharSetFontTXT
 PUBLIC CharSetTokenScreenTXT,KeyValDILoop,KeyValDINotNoKey
 PUBLIC ParseHelp,ParseCall,ParseJump,ParseBCall,ParseClear,ParseExec,ParseRun
 PUBLIC ParseOff,SetVirtual,GetVirtual,ParseErrArgument,ConErrArgumentTXT
 PUBLIC DoParseFoundOK,ConsoleGet16Arg,ASCIIToHex,IsHexDigit,IsHexDigitNum
 PUBLIC OldLine,RetNZ,DoVAT1,DoVAT2,DoVAT3,DoVAT4,DoVAT5,DoVAT6,ShowVATScreen
 PUBLIC ShowVATScreenLoop,VATNext,DoVATDispName,DoVATDispType,DoVATSixLoop
 PUBLIC DoVATProg,DoVATProgLoop,DoVATOther,RestartVAT,DoVATChoose
 PUBLIC DoVATChooseLoop,DoVATChoosen,GetFlagNameOffset,GetFlagNameOffsetSkip
 PUBLIC DispOtherFlagScreen,DispOtherFlagScreenLoop,DispMainFlagScreen
 PUBLIC DispMainFlagScreenLoop,SysFlag1,SysFlag2,SysFlag3,SysFlag4,SysFlag5
 PUBLIC SysFlag6,SysFlagChoose,SysFlagChoosenLoop,IGetKey,ParseHex
 PUBLIC ParseHexAdd,ParseHexSub,ParseHexMul,ParseHexDiv,ParseHexGet
 PUBLIC HexFind2,HexFindCode2,FindScreenTXT2,DisDispScreen,DisDispScreenLoop
 PUBLIC DisUp,DisDown,DisGetLength,DisName,DisNameDD,DisNameCB,FindScreen2
 PUBLIC DisDisp2Tag,DisDisp1Tag,DisDisp2Emb,DisDisp2TagPtr,DisDisp1TagRel
 PUBLIC HexToASCII,DisGetVal,DisNameED,DisNameFD,ParseErrArchived
 PUBLIC ParseSearch,ParseCheckString,siLoop,siDel,siDelLoop
 PUBLIC siDelLoopSkip,siClear,siClearLoop,LinkGetKey,LinkConsoleLoop
 PUBLIC LinkConsoleCont,LinkGKDo,GetNumericHC,LinkConsoleRec
 PUBLIC LinkConsoleRecSkip1,LinkConsoleRecSkip2,LinkConOutByte,LinkConOutAddr
 PUBLIC LinkConOutAddrLoop,LinkConSetFlag,TIOSModLinkSend,TIOSModLinkGet
 PUBLIC Race,RaceCheckHit,RaceMoveRight,RaceMoveRightLoop1,RaceMoveRightLoop2
 PUBLIC RaceMoveLeft,RaceMoveLeftLoop2,RaceLoop,RaceAddRow,RaceLastOK1,RaceLastOK2

