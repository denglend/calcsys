HomeTextMenu:
                            ;HL -> Menu Structure
                            ;Displays menu and waits for option to be chosen
                            ;Jumps to appropriate address
       push   hl
       B_CALL ClrLCDFull
       B_CALL HomeUp
       pop    hl
       ld     b,(hl)
       inc    hl
       push   hl
       ld     e,b
       sla    e
       ld     d,0
       add    hl,de         ;HL -> to text strings
       inc    b             ;Number of Text Strings to display
       push   bc
       call   DispHomeText
       pop    bc
       dec    b
       pop    hl
HomeTextMenuLoop:
       push   hl
       push   bc
       call   IGetKey
       pop    bc
       pop    hl
 IFDEF CALCSYS
       cp     kClear
       jr     nz,HomeTextNotClear
       ld     a,b
       add    a,k0
HomeTextNotClear:
 ENDIF
       sub    k1
       cp     b
       jr     nc,HomeTextMenuLoop
       add    a,a
       ld     e,a
       ld     d,0
       add    hl,de
       B_CALL LdHLInd
       jp     (hl)

DispHomeText:
                            ;displays B number of texts on homescreen
       ld     c,b
DispHomeTextLoop:
       ld     a,c
       sub    b
       ld     d,0
       ld     e,a
       ld     (curRow),de
       call   PutSApp
       djnz   DispHomeTextLoop
       ret


GetHexHL:
       call   GetHexA
       push   af
       call   GetHexA
       ld     l,a
       pop    af
       ld     h,a
       ret

GetHexA:
		; lets user input an 8 bit number in hexadecimal
		; prompt is at currow,curcol
		; number is returned in a
              ; requires two bytes at GetHexATemp
       set    curAble,(iy+curFlags)
       ld     a,' '
       ld     (curUnder),a
       ld     b,2
       ld     hl,GetHexATemp
GetHexALoop:
       push   bc
       push   hl
       call   IGetKey
       pop    hl
       pop    bc
       cp     2
       jr     nz,GetHexANotBack
       ld     a,b
       cp     2
       jr     z,GetHexANotBack
       ld     a,' '
       B_CALL PutMap
       ld     hl,curCol
       dec    (hl)
       jr     GetHexA
GetHexANotBack:
       sub    142
       cp     10
       jr     c,GetHexANum
       sub    12
       cp     6
       jr     c,GetHexALet
       jr     GetHexALoop
GetHexANum:
       ld     (hl),a
       inc    hl
       add    a,48
       B_CALL PutC
       djnz   GetHexALoop
       jr     GetHexADone
GetHexALet:
       add    a,10
       ld     (hl),a
       inc    hl
       add    a,55
       B_CALL PutC
       djnz   GetHexALoop
GetHexADone:
       dec    hl
       ld     b,(hl)
       dec    hl
       ld     a,(hl)
       rlca
       rlca
       rlca
       rlca
       or     b
       res    curAble,(iy+curFlags)
       ret

		 DispHomeTextC:
                            ;Clears screen, and loads B from structure
       push   hl
       B_CALL ClrLCDFull
       B_CALL HomeUp
       pop    hl
       ld     b,(hl)
       inc    hl



DispHexHL:
       ld     a,h
       call   DispHexA
       ld     a,l

DispHexA:
       push   hl
       push   bc
       call   HexToASCII
       ld     a,h
       B_CALL PutC
       ld     a,l
       B_CALL PutC
       pop    bc
       pop    hl
       ret
 
HexToASCII:
       push   af
       rrca
       rrca
       rrca
       rrca
       call   HTAConv
       ld     h,a
       pop    af
       call   HTAConv
       ld     l,a
       ret
HTAConv:
       and    15
       cp     10
       jr     nc,HTAConvLet
       add    a,48
       ret
HTAConvLet:
       add    a,55
       ret


PutSApp:				;display a string of large text
	ld	a,(hl)
	inc	hl
	or	a
	ret	z
	B_CALL	PutC
	jr	PutSApp  


RandNum:
	push	hl
	push	de
	ld	hl,(0FFFFh-370)
	ld	a,r
	ld	d,a
	ld	e,(hl)
	add	hl,de
	add	a,l
	xor	h
	ld	(0FFFFh-370),hl
	ld	hl,0
	ld	e,a
	ld	d,h
RandNumLoop:
       add	hl,de
	djnz	RandNumLoop
	ld	a,h
	pop	de
	pop	hl
	ret


FindIndexText:
                                   ;Finds string A in list HL
       or     a
       ret    z
       push   bc
       push   de
       ld     d,a
       xor    a
FindIndexTextLoop:
       ld     b,h
       cpir
       dec    d
       jr     nz,FindIndexTextLoop
       pop    de
       pop    bc
       ret

DispBinA:
       ld     b,8
       ld     c,a
DispBinALoop:
       rl     c
       ld     a,'0'
       adc    a,0
       B_CALL PutC
       djnz   DispBinALoop
       ret





;------------------------------------------------------------------
;------------------------------------------------------------------
;------------------------------------------------------------------
;			String Input			
;------------------------------------------------------------------
;------------------------------------------------------------------
;------------------------------------------------------------------


StringInput:                         
				;Input
				;hl -> where to save input
				;b = max characters
				;currow,curcol = cursor location
				;Output
				;hl is preserved
				;bc = number of characters inputted

	push	hl
	ld	de,(curRow)
	push	de
	set	curAble,(IY+curFlags)
	ld	c,b		;c = backup of max chars
	ld	d,0		;d = how many chars after current cursor location
				; last inpuuted char is
	ld	(hl),d      
	ld	a,Lspace
	ld	(curUnder),a  ;curUnder is the character that is shown during
				;cursor blink
	B_CALL	PutMap
siLoop:
	push	hl
	push	de
	push	bc
       call   IGetKey
	pop	bc
	pop	de
	pop	hl
	cp	kDel
	jr	z,siDel
	cp	kClear
	jr	z,siClear
	cp	kEnter
	jp	z,siEnter
	cp	kLeft
	jp	z,siLeft
	cp	kRight
	jp	z,siRight  
	cp	kDown
	jp	z,siDown
	cp	kUp
	jp	z,siUp
       cp     kSpace
       jp     z,siSpace
       cp     kComma
       jp     z,siComma
	sub	k0
	cp	10
	jp	c,siNumber
	sub	kCapA-k0
	cp	26
	jp	c,siLetter
	jr	nz,siLoop   
       ld     a,'X'-'A'
       jp     siLetter
siDel:						;delete a character
	inc	d
	dec	d				;are we at the end of the string?
	jr	z,siLoop
	push	de
	push	bc
	push	hl
	ld	b,d
	ld	de,(curRow)
	push	de  
	ld	d,h
	ld	e,l
	inc	de 
	dec	b				;are we deleting the last character?
	ld	c,Lspace
	jr	z,siDelLoopSkip  		;if so, we want to have curUnder=Lspace
						;and we don't need to display shifted
						;characters

;	ld	c,(hl)				;else, we want curUnder=next character
       ld     a,(de)
       ld     c,a                         ;err, actually, don't we want this?

siDelLoop:					;This loop displays all the remaining
						;characters after the one we're deleting,
						;but shifted back one position
	ld	a,(de)
	B_CALL	PutC
	ld	(hl),a
	inc	hl
	inc	de
	djnz	siDelLoop 
siDelLoopSkip:
       ld     (hl),0               ;needs to be zero terminated, right?
	ld	a,Lspace
	B_CALL	PutC
	ld	a,c
	ld	(curUnder),a
	pop	de
	ld	(curRow),de
	pop	hl
	pop	bc
	pop	de
	dec	d
	jp	siLoop

siClear:					;clear all characters
	ld	a,c
	sub	b
	add	a,d
	or	a				;nothing to clear?
	jp	z,siLoop
	ld	e,d
	ld	d,0
	add	hl,de
	ld	(hl),0				;zero terminate current text
	pop	de
	ld	(curRow),de			;restore original cursor location
	pop	hl
	push	bc
	B_CALL	StrLength			;get length of string
	inc	c				;need to erase cursor too
	push	hl
	push	de
siClearLoop:					;clear all previously entered text
	ld	a,Lspace
	B_CALL	PutC
	dec	c
	jr	nz,siClearLoop
	pop	de
	ld	(curRow),de
	pop	hl
	pop	bc
	ld	b,c				;restore backup of max # of chars
	jp	StringInput 

siEnter:
	ld	a,(curUnder)
	B_CALL	PutMap				;Display character under cursor, so we
						;don't get a black box
;	ld	e,d
;	ld	d,0
;	add	hl,de   ;wait...what was this for?
       ld     hl,curRow
       dec    d
       inc    d
       jr     z,siEnterLoopSkip
siEnterLoop:                              ;Updates cursor position to end
       ld     a,(curCol)
       inc    a
       and    15
       ld     (curCol),a
       or     a
       jr     nz,siEnterLoopCont
       inc    (hl)
siEnterLoopCont:
       dec    d
       jr     nz,siEnterLoop
siEnterLoopSkip:
	pop	de
;	ld	(curRow),de			;restore original cursor location
	pop	hl
	B_CALL	StrLength			;find string length
	inc	bc  				;add one for zero terminator
	res	curAble,(IY+curFlags)	;turn of cursor
	ret

siNumber:
	add	a,L0	
	jr	siLetCont  
siLetter: 
	add	a,LcapA
siLetCont:
	dec	b
	inc	b				;Have we displayed the maximum # of
						;characters?
	jp	z,siLoop
	ld	(hl),a 
	B_CALL	PutC
	inc	hl     
	ld	a,d  
	dec	d
	dec	b
	or	a
	ld	a,(hl)
	ld	(curUnder),a			;reset curUnder to next character
	jp	nz,siLoop
	inc	d
	ld	a,Lspace
	ld	(curUnder),a      
	ld	(hl),0
	jp	siLoop
siSpace:
       ld     a,' '
       jr     siLetCont
siComma:
       ld     a,','
       jr     siLetCont
siLeft:					;move left
	ld	a,b
	cp	c				;are we all the way to the left?
	jp	z,siLoop
	inc	b
	ld	a,d
	inc	d				;we've moved farther away from the end
	call	siLDAHL
	B_CALL	PutMap
	dec	hl
	ld	a,(hl)
	ld	(curUnder),a

	ld	a,(curCol)
	dec	a				;cursor location one to the left
	ld	(curCol),a
	jp	p,siLoop			;jumps if there was no overflow			
	ld	a,15
	ld	(curCol),a
	ld	a,(curRow)
	dec	a
	ld	(curRow),a
	jp	siLoop 

siUp: 						;move up
	ld	a,b
	add	a,15
	cp	c				;have we typed more than 15 characters?
	jp	nc,siLoop			;if not, we can't move up
	ld	b,a  
	inc	b
	ld	a,d
	add	a,16
	ld	d,a
	call	siLDAHL
	B_CALL	PutMap
	push	de
	ld	de,16
	sbc	hl,de				;text pointer up a row (row=16 bytes)
	pop	de
	ld	a,(curRow)
	dec	a				;move cursor up a row
	ld	(curRow),a
	ld	a,(hl)  
	ld	(curUnder),a
	jp	siLoop    

siLDAHL:
						;loads a character from (hl) and
						;converts it to Lspace if it is 0
	ld	a,(hl)
	or	a
	ret	nz
	ld	a,Lspace
	ret

siDown:       				;move down     
	ld	e,16
	ld	a,d
	sub	e				;are there are least 16 after cursor?
	jp	c,siLoop			;if not, we can't move down
	ld	d,a
	ld	a,b
	sub	e
	ld	b,a
	ld	a,(hl)
	B_CALL	PutMap
	push	de
	ld	d,0
	add	hl,de
	pop	de  
	call	siLDAHL
	ld	(curUnder),a
	ld	a,(curRow)
	inc	a
	ld	(curRow),a
	jp	siLoop

siRight:					;move right
	ld	a,d
	or	a				;are there any more chars after cursor?
	jp	z,siLoop
	dec	b
	ld	a,(hl)
	B_CALL	PutMap
	inc	hl
	dec	d 
	call	siLDAHL
	ld	(curUnder),a 
	ld	a,(curCol)
	inc	a				;move cursor over
	ld	(curCol),a
	cp	16				;did we scroll
	jp	nz,siLoop
	xor	a
	ld	(curCol),a
	ld	a,(curRow)
	inc	a
	ld	(curRow),a
	jp	siLoop





ASCIIToHex:
                            ;Converts two ASCII bytes @ HL to a number in A
                            ;CA = 0 = invalid digit
                            ;If valid digit, HL=HL+2
       ld     a,(hl)
       call   IsHexDigit
       ret    nc
       rrca
       rrca
       rrca
       rrca
       ld     b,a
       inc    hl
       ld     a,(hl)
       inc    hl
       call   IsHexDigit
       ret    nc
       or     b
       scf
       ret

IsHexDigit:
                            ;Checks if A is a ASCII nibble
                            ;CA = 1 = Yes, value in lower 4 bits of A
                            ;CA = 0 = NO
       sub    '0'
       cp     10
       jr     c,IsHexDigitNum
       sub    'A'-'0'
       cp     6
       ret    nc
       add    a,10
IsHexDigitNum
       scf
       ret


DispBlank:
       push   af
       ld     a,' '
       B_CALL PutC
       pop    af
       ret



GetByteTIOS:
				;receives a byte in tios protocol through the link port
				;input
				;(none)
				;output
				;nz=error, can't recieve
				;a=byte
       AppOnErr      RetNZ
 IFDEF TI83P
       B_CALL RecAByteIO              
 ELSE
 IFDEF TI73
       ld     a,22
       ld     (asm_Ind_Call),a
       B_CALL Exec_IO
 ENDIF
 IFNDEF TI73      
       call   TIOSModLinkGet
 ERROR "Other Link Routines"
 ENDIF
 ENDIF
	ld	(RecByteBuffer),a
	AppOffErr
	ld	a,(RecByteBuffer)
	cp	a
	ret



RetNZ:
	xor	a
	inc	a
	ret


DelayS:
       xor    a
       out    (1),a
       in     a,(1)
       inc    a
       ret    nz

DelayB:
					;delay routine
					;input
					;b=delay amount
					;output
					;delays for a bit
	ei
DelayL:
	halt
	djnz	DelayL
	ret










ScrollingCredits:
                                   ;hl -> list of credits, 0hFF terminated
                                   ;requires 121 byte ScrollingCBuf
       push   hl
       B_CALL ClrLCDFull
       B_CALL GrBufClr
       pop    hl              
       ei
       set    textWrite,(iy+sGrFlags)
ScrollingCLoop:
       ld     a,8
       ld     (ScrollingCBuf),a
       push   hl
       ld     a,56
       call   CenterText
ScrollingCLoop2:
       call   ScrollingCDispS
       ld     b,15
       call   DelayS
       ld     a,(ScrollingCBuf)
       dec    a
       ld     (ScrollingCBuf),a
       jr     nz,ScrollingCLoop2
       pop    hl
       call   NextString
       ld     a,(hl)
       inc    a
       jr     nz,ScrollingCLoop
       ld     b,200
       res    textWrite,(iy+sGrFlags)
       jp     DelayS

ScrollingCDispS:
       ld     b,54
       ld     hl,plotSScreen
       B_CALL RestoreDisp
       ei
       ld     hl,plotSScreen+648
       ld     bc,120
       ld     de,ScrollingCBuf+1
       push   bc
       push   hl
       push   de
       ldir
       ld     bc,108
       ld     hl,plotSScreen+660
       B_CALL MemClear
;       ld	b,0              BC = 0 after MemClear
ScrollingCDispSL:
       push   bc
       ld     a,b
       ld     e,54
       call   GetPixel
       ld     d,a
       and    (hl)
       pop    bc
       jr     z,ScrollingCDispSS
       push   bc    
       ld     c,d
       ld     b,9
       ld     de, 12
ScrollingCDispSBL:
       ld     a, (hl)
       or     c
       ld     (hl), a
       add    hl, de
       DJNZ   ScrollingCDispSBL
       pop    bc
ScrollingCDispSS:
       inc    b
       ld     a,b
       cp     96
       jr     nz,ScrollingCDispSL
       B_CALL GrBufCpy
       ld     b,10
       call   DelayS
       pop    hl
       pop    de
       pop    bc
       ldir
       ld     hl,plotSScreen+12
       ld     de,plotSScreen
       ld     bc,756
       ldir
       ret
CenterText:
					;hl=string
					;a=penrow to disp at
					;Needs buffer, CenterTextBuf
       ld     (penRow),a
       ld     de,CenterTextBuf+1
       push   de
       B_CALL StrCopy
       pop    hl
       B_CALL StrLength
       dec    hl
       ld     (hl),c
       B_CALL SStringLength
       sra    b
       ld     a,48
       sub    b
       ld     (penCol),a
       inc    hl
       jp     VPutSApp
NextString:
       push   af
       push   bc
       xor    a
       ld     b,h
       cpir
       pop    bc
       pop    af
       ret

; input:	e=y coordinate
;		a=x coordinate
; output:	a holds data for pixel (e.g. %00100000)
;		hl->byte where pixel is on the gbuf
GetPixel:
       ld     d,00
       ld     h,d
       ld     l,e
       add    hl,de
       add    hl,de
       add    hl,hl
       add    hl,hl
       ld     de,plotSScreen
       add    hl,de
       ld     b,00
       ld     c,a
       and    00000111b
       srl    c
       srl    c
       srl    c
       add    hl,bc
       ld     b,a
       inc    b
       ld     a,00000001b
getPixelLoop:
       rrca
       djnz   getPixelLoop
		ret



VPutSApp:				;display text in small font
	ld	a,(hl)
	inc	hl
	inc	a
	dec	a			;use inc and dec to preserve carry
	ret	z
	push	hl           
	push	de
	B_CALL	VPutMap
	pop	de
	pop	hl
	jr	VPutSApp



SendByteTIOS:
				;sends a byte in tios protocol through link port
				;input
				;a=byte
				;output
				;nz=error, can't send
       AppOnErr      RetNZ
 IFDEF TI83P
       B_CALL SendAByte
 ELSE
 IFDEF TI73
       ld     a,11
       ld     (asm_Ind_Call),a
       B_CALL Exec_IO
 ENDIF
 IFNDEF TI73
 ERROR "SendByteBlahBlah"
       call   TIOSModLinkSend
 ENDIF
 ENDIF
       AppOffErr
	cp	a
	ret




linkwait     EQU    6000h
TIOSModLinkGet:
       in     a,(2)
       and    80h
       jr     nz,TIOSModLinkGetSE
	in	a,(0)
	and	d0d1_bits
	cp	d0d1_bits
       jp      z,noio
TIOSModLinkGetSE:
       jp      GetByteTIOS

TIOSModLinkSend:
       ld     b,a
       in     a,(2)
       and    80h
       ld     a,b
       jp     nz,SendByteTIOS
	di
	push	af
	ld	a,d0hd1h
	out	(0),a
	pop	af
	set 	indicOnly,(iy+indicFlags)
       AppOnErr    linkfail
	call	sendit
endexio:
	res	indicOnly,(iy+indicFlags)
	ld	(iodata),a
	AppOffErr
	ld	a,d0hd1h
	out	(0),a
	ld	a,(iodata)
	cp	a
	ei
	ret
linkfail:
	ld	a,d0hd1h
	out	(0),a
noio:
	ei
	or	1
	ret

sendit:
	ld	c,a
	ld	b,8
l41e4:
	ld	de,linkwait
	rr	c
	jr	nc,l41f0
	ld	a,2
	jp	l41f2
l41f0:
	ld	a,1
l41f2:
	out	(0),a
l41f4:
	in	a,(0)
	and	3
	jp	z,l420b
	in	a,(0)
	and	3
	jp	z,l420b
	dec	de
	ld	a,d
	or	e
	jp	nz,l41f4
l4208
	B_CALL       ErrLinkXmit
l420b:
	ld	a,0
	out	(0),a
	ld	de,linkwait
l4212:
	dec	de
	ld	a,d
	or	e
	jr	z,l4208
	in	a,(0)
	and	3
	cp	3
	jp	nz,l4212
	djnz	l41e4
	ret

