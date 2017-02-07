dtab1:
	; table of one byte op codes
	; table entries are
	; first byte = total size for op + op data
	; second byte = argurment type
		; 0 = no args
		; 1 = 1 byte tag arg
		; 2 = 2 byte tag arg
		; 3 = 1 byte tag relative arg
		; 4 = 2 byte embedded pointer arg
		; 5 = 2 byte tag pointer arg
		; 6 = out (*),a
		; 7 = in a,(*)

;0
	db	1,0			;nop
	db	3,2			;ld	bc,*
	db	1,0			;ld	(bc),a
	db	1,0			;inc	bc
	db	1,0			;inc	b
	db	1,0			;dec	b
	db	2,1			;ld	b,*
	db	1,0			;rlca
	db	1,0			;ex	af,af'
	db	1,0			;add	hl,bc
	db	1,0			;ld	a,(bc)
	db	1,0			;dec	bc
	db	1,0			;inc	c
	db	1,0			;dec	c
	db	2,1			;ld	c,*
	db	1,0			;rrca
;10
	db	2,3			;djnz	*
	db	3,2			;ld	de,*
	db	1,0			;ld	(de),a
	db	1,0			;inc	de
	db	1,0			;inc	d
	db	1,0			;dec	d
	db	2,1			;ld	d,*
	db	1,0			;rla
	db	2,3			;jr	*
	db	1,0			;add	hl,de
	db	1,0			;ld	a,(de)
	db	1,0			;dec	de
	db	1,0			;inc	e
	db	1,0			;dec	e
	db	2,1			;ld	e,*
	db	1,0			;rra
;20
	db	2,3			;jr	nz,*
	db	3,2			;ld	hl,*
	db	3,4			;ld	(*),hl
	db	1,0			;inc	hl
	db	1,0			;inc	h
	db	1,0			;dec	h
	db	2,1			;ld	h,*
	db	1,0			;daa
	db	2,3			;jr	z,*
	db	1,0			;add	hl,hl
	db	3,5			;ld	hl,(*)
	db	1,0			;dec	hl
	db	1,0			;inc	l
	db	1,0			;dec	l
	db	2,1			;ld	l,*
	db	1,0			;cpl
;30
	db	2,3			;jr	nc,*
	db	3,2			;ld	sp,*
	db	3,4			;ld	(*),a
	db	1,0			;inc	sp
	db	1,0			;inc	(hl)
	db	1,0			;dec	(hl)
	db	2,1			;ld	(hl),*
	db	1,0			;scf
	db	2,3			;jr	c,*
	db	1,0			;add	hl,sp
	db	3,5			;ld	a,(*)
	db	1,0			;dec	sp
	db	1,0			;inc	a
	db	1,0			;dec	a
	db	2,1			;ld	a,*
	db	1,0			;ccf
;40
	db	1,0			;ld	b,b
	db	1,0			;ld	b,c
	db	1,0			;ld	b,d
	db	1,0			;ld	b,e
	db	1,0			;ld	b,h
	db	1,0			;ld	b,l
	db	1,0			;ld	b,(hl)
	db	1,0			;ld	b,a
	db	1,0			;ld	c,b
	db	1,0			;ld	c,c
	db	1,0			;ld	c,d
	db	1,0			;ld	c,e
	db	1,0			;ld	c,h
	db	1,0			;ld	c,l
	db	1,0			;ld	c,(hl)
	db	1,0			;ld	c,a
;50
	db	1,0			;ld	d,b
	db	1,0			;ld	d,c
	db	1,0			;ld	d,d
	db	1,0			;ld	d,e
	db	1,0			;ld	d,h
	db	1,0			;ld	d,l
	db	1,0			;ld	d,(hl)
	db	1,0			;ld	d,a
	db	1,0			;ld	e,b
	db	1,0			;ld	e,c
	db	1,0			;ld	e,d
	db	1,0			;ld	e,e
	db	1,0			;ld	e,h
	db	1,0			;ld	e,l
	db	1,0			;ld	e,(hl)
	db	1,0			;ld	e,a
;60
	db	1,0			;ld	h,b
	db	1,0			;ld	h,c
	db	1,0			;ld	h,d
	db	1,0			;ld	h,e
	db	1,0			;ld	h,h
	db	1,0			;ld	h,l
	db	1,0			;ld	h,(hl)
	db	1,0			;ld	h,a
	db	1,0			;ld	l,b
	db	1,0			;ld	l,c
	db	1,0			;ld	l,d
	db	1,0			;ld	l,e
	db	1,0			;ld	l,h
	db	1,0			;ld	l,l
	db	1,0			;ld	l,(hl)
	db	1,0			;ld	l,a
;70
	db	1,0			;ld	(hl),b
	db	1,0			;ld	(hl),c
	db	1,0			;ld	(hl),d
	db	1,0			;ld	(hl),e
	db	1,0			;ld	(hl),h
	db	1,0			;ld	(hl),l
	db	1,0			;halt
	db	1,0			;ld	(hl),a
	db	1,0			;ld	a,b
	db	1,0			;ld	a,c
	db	1,0			;ld	a,d
	db	1,0			;ld	a,e
	db	1,0			;ld	a,h
	db	1,0			;ld	a,l
	db	1,0			;ld	a,(hl)
	db	1,0			;ld	a,a
;80
	db	1,0			;add	a,b
	db	1,0			;add	a,c
	db	1,0			;add	a,d
	db	1,0			;add	a,e
	db	1,0			;add	a,h
	db	1,0			;add	a,l
	db	1,0			;add	a,(hl)
	db	1,0			;add	a,a
	db	1,0			;adc	a,b
	db	1,0			;adc	a,c
	db	1,0			;adc	a,d
	db	1,0			;adc	a,e
	db	1,0			;adc	a,h
	db	1,0			;adc	a,l
	db	1,0			;adc	a,(hl)
	db	1,0			;adc	a,a
;90
	db	1,0			;sub	a,b
	db	1,0			;sub	a,c
	db	1,0			;sub	a,d
	db	1,0			;sub	a,e
	db	1,0			;sub	a,h
	db	1,0			;sub	a,l
	db	1,0			;sub	a,(hl)
	db	1,0			;sub	a,a
	db	1,0			;sbc	a,b
	db	1,0			;sbc	a,c
	db	1,0			;sbc	a,d
	db	1,0			;sbc	a,e
	db	1,0			;sbc	a,h
	db	1,0			;sbc	a,l
	db	1,0			;sbc	a,(hl)
	db	1,0			;sbc	a,a
;A0
	db	1,0			;and	a,b
	db	1,0			;and	a,c
	db	1,0			;and	a,d
	db	1,0			;and	a,e
	db	1,0			;and	a,h
	db	1,0			;and	a,l
	db	1,0			;and	a,(hl)
	db	1,0			;and	a,a
	db	1,0			;xor	a,b
	db	1,0			;xor	a,c
	db	1,0			;xor	a,d
	db	1,0			;xor	a,e
	db	1,0			;xor	a,h
	db	1,0			;xor	a,l
	db	1,0			;xor	a,(hl)
	db	1,0			;xor	a,a
;B0
	db	1,0			;or	a,b
	db	1,0			;or	a,c
	db	1,0			;or	a,d
	db	1,0			;or	a,e
	db	1,0			;or	a,h
	db	1,0			;or	a,l
	db	1,0			;or	a,(hl)
	db	1,0			;or	a,a
	db	1,0			;cp	a,b
	db	1,0			;cp	a,c
	db	1,0			;cp	a,d
	db	1,0			;cp	a,e
	db	1,0			;cp	a,h
	db	1,0			;cp	a,l
	db	1,0			;cp	a,(hl)
	db	1,0			;cp	a,a
;C0
	db	1,0			;ret	nz
	db	1,0			;pop	bc
	db	3,2			;jp	nz,*
	db	3,2			;jp	*
	db	3,2			;call	nz,*
	db	1,0			;push	bc
	db	2,1			;add	a,*
	db	1,0			;rst	00h
	db	1,0			;ret	z
	db	1,0			;ret
	db	3,2			;jp	z,*
	db	3,0			;$CB************
	db	3,2			;call	z,*
	db	3,2			;call	*
	db	2,1			;adc	a,*
	db	1,0			;rst	08h
;D0
	db	1,0			;ret	nc
	db	1,0			;pop	de
	db	3,2			;jp	nc,*
	db	2,6			;out	(*),a
	db	3,2			;call	nc,*
	db	1,0			;push	de
	db	2,1			;sub	*
	db	1,0			;rst	10h
	db	1,0			;ret	c
	db	1,0			;exx
	db	3,2			;jp	c,*
	db	2,7			;in	a,(*)
	db	3,2			;call	c,*
	db	3,0			;$DD************
	db	2,1			;sbc	*
	db	1,0			;rst	18h
;E0
	db	1,0			;ret	po
	db	1,0			;pop	hl
	db	3,2			;jp	po,*
	db	1,0			;ex	(sp),hl
	db	3,2			;call	po,*
	db	1,0			;push	hl
	db	2,1			;and	*
	db	1,0			;rst	20h
	db	1,0			;ret	pe
	db	1,0			;jp	(hl)
	db	3,2			;jp	pe,*
	db	1,0			;ex	de,hl
	db	3,2			;call	pe,*
	db	3,0			;$ED*************
	db	2,1			;xor	*
	db	3,2			;bcall	*
;F0
	db	1,0			;ret	p
	db	1,0			;pop	af
	db	3,2			;jp	p,*
	db	1,0			;di
	db	3,2			;call	p,*
	db	1,0			;push	af
	db	2,1			;or	*
	db	1,0			;rst	30h
	db	1,0			;ret	m
	db	1,0			;ld	sp,hl
	db	3,2			;jp	m,*
	db	1,0			;ei
	db	3,2			;call	m,*
	db	3,0			;$FD*************
	db	2,1			;cp	*
	db	1,0			;rst	38h
dtabed:
			;format is 2ndbyte of op, then two type bytes of regular table
			;with the length byte being total length

	db	04ah,2,0			;adc hl,bc
	db	05ah,2,0			;adc hl,de
	db	06ah,2,0			;adc hl,hl
	db	07ah,2,0			;adc hl,sp
	db	0a9h,2,0			;cpd
	db	0b9h,2,0			;cpdr
	db	0a1h,2,0			;cpi
	db	0b1h,2,0			;cpir
	db	046h,2,0			;im 0
	db	056h,2,0			;im 1
	db	05eh,2,0			;im 2
	db	040h,2,0			;in b,(c)
	db	048h,2,0			;in c,(c)
	db	050h,2,0			;in d,(c)
	db	058h,2,0			;in e,(c)
	db	060h,2,0			;in h,(c)
	db	068h,2,0			;in l,(c)
	db	078h,2,0			;in a,(c)
	db	0aah,2,0			;ind
	db	0bah,2,0			;indr
	db	0a2h,2,0			;ini
	db	0b2h,2,0			;inir
	db	043h,4,4			;ld (*),bc
	db	053h,4,4			;ld (*),de
	db	073h,4,4			;ld (*),sp
	db	057h,2,0			;ld a,i
	db	05fh,2,0			;ld a,r
	db	04bh,4,5			;ld bc,(*)
	db	05bh,4,5			;ld de,(*)
	db	047h,2,0			;ld i,a
	db	04fh,2,0			;ld r,a
	db	07bh,4,5			;ld sp,(*)
	db	0a8h,2,0			;ldd
	db	0b8h,2,0			;lddr
	db	0a0h,2,0			;ldi
	db	0b0h,2,0			;ldir
	db	0abh,2,0			;outd
	db	0bbh,2,0			;otdr
	db	0a3h,2,0			;outi
	db	0b3h,2,0			;otir
	db	041h,2,0			;out b,(c)
	db	049h,2,0			;out c,(c)
	db	051h,2,0			;out d,(c)
	db	059h,2,0			;out e,(c)
	db	061h,2,0			;out h,(c)
	db	069h,2,0			;out l,(c)
	db	079h,2,0			;out a,(c)
	db	04dh,2,0			;reti
	db	045h,2,0			;retn
	db	06fh,2,0			;rld
	db	067h,2,0			;rrd
	db	042h,2,0			;sbc hl,bc
	db	052h,2,0			;sbc hl,de
	db	062h,2,0			;sbc hl,hl
	db	072h,2,0			;sbc hl,sp
       db     044h,2,0                    ;neg
dtabedend:
dtabedsize    EQU      (dtabedend-dtabed)/3
dstr:
	db	"nop",0
	db	"ld bc,",0
	db	"ld (bc),a",0
	db	"inc bc",0
	db	"inc b",0
	db	"dec b",0
	db	"ld b,",0
	db	"rlca",0
	db	"ex af,af",0
	db	"add hl,bc",0
	db	"ld a,(bc)",0
	db	"dec bc",0
	db	"inc c",0
	db	"dec c",0
	db	"ld c,",0
	db	"rrca",0

	db	"djnz ",0
	db	"ld de,",0
	db	"ld (de),a",0
	db	"inc de",0
	db	"inc d",0
	db	"dec d",0
	db	"ld d,",0
	db	"rla",0
	db	"jr ",0
	db	"add hl,de",0
	db	"ld a,(de)",0
	db	"dec de",0
	db	"inc e",0
	db	"dec e",0
	db	"ld e,",0
	db	"rra",0

	db	"jr nz,",0
	db	"ld hl,",0
	db	"ld(    ),hl",0
	db	"inc hl",0
	db	"inc h",0
	db	"dec h",0
	db	"ld h,",0
	db	"daa",0
	db	"jr z,",0
	db	"add hl,hl",0
	db	"ld hl,(",0
	db	"dec hl",0
	db	"inc l",0
	db	"dec l",0
	db	"ld l,",0
	db	"cpl",0

	db	"jr nc,",0
	db	"ld sp,",0
	db	"ld(    ),a",0
	db	"inc sp",0
	db	"inc (hl)",0
	db	"dec (hl)",0
	db	"ld(hl),",0
	db	"scf",0
	db	"jr c,",0
	db	"add hl,sp",0
	db	"ld a,(",0
	db	"dec sp",0
	db	"inc a",0
	db	"dec a",0
	db	"ld a,",0
	db	"ccf",0

	db	"ld b,b",0
	db	"ld b,c",0
	db	"ld b,d",0
	db	"ld b,e",0
	db	"ld b,h",0
	db	"ld b,l",0
	db	"ld b,(hl)",0
	db	"ld b,a",0
	db	"ld c,b",0
	db	"ld c,c",0
	db	"ld c,d",0
	db	"ld c,e",0
	db	"ld c,h",0
	db	"ld c,l",0
	db	"ld c,(hl)",0
	db	"ld c,a",0

	db	"ld d,b",0
	db	"ld d,c",0
	db	"ld d,d",0
	db	"ld d,e",0
	db	"ld d,h",0
	db	"ld d,l",0
	db	"ld d,(hl)",0
	db	"ld d,a",0
	db	"ld e,b",0
	db	"ld e,c",0
	db	"ld e,d",0
	db	"ld e,e",0
	db	"ld e,h",0
	db	"ld e,l",0
	db	"ld e,(hl)",0
	db	"ld e,a",0

	db	"ld h,b",0
	db	"ld h,c",0
	db	"ld h,d",0
	db	"ld h,e",0
	db	"ld h,h",0
	db	"ld h,l",0
	db	"ld h,(hl)",0
	db	"ld h,a",0
	db	"ld l,b",0
	db	"ld l,c",0
	db	"ld l,d",0
	db	"ld l,e",0
	db	"ld l,h",0
	db	"ld l,l",0
	db	"ld l,(hl)",0
	db	"ld l,a",0

	db	"ld (hl),b",0
	db	"ld (hl),c",0
	db	"ld (hl),d",0
	db	"ld (hl),e",0
	db	"ld (hl),h",0
	db	"ld (hl),l",0
	db	"halt",0
	db	"ld (hl),a",0
	db	"ld a,b",0
	db	"ld a,c",0
	db	"ld a,d",0
	db	"ld a,e",0
	db	"ld a,h",0
	db	"ld a,l",0
	db	"ld a,(hl)",0
	db	"ld a,a",0

	db	"add a,b",0
	db	"add a,c",0
	db	"add a,d",0
	db	"add a,e",0
	db	"add a,h",0
	db	"add a,l",0
	db	"add a,(hl)",0
	db	"add a,a",0
	db	"adc a,b",0
	db	"adc a,c",0
	db	"adc a,d",0
	db	"adc a,e",0
	db	"adc a,h",0
	db	"adc a,l",0
	db	"adc a,(hl)",0
	db	"adc a,a",0
	
	db	"sub b",0
	db	"sub c",0
	db	"sub d",0
	db	"sub e",0
	db	"sub h",0
	db	"sub l",0
	db	"sub (hl)",0
	db	"sub a",0
	db	"sbc b",0
	db	"sbc c",0
	db	"sbc d",0
	db	"sbc e",0
	db	"sbc h",0
	db	"sbc l",0
	db	"sbc (hl)",0
	db	"sbc a",0

	db	"and b",0
	db	"and c",0
	db	"and d",0
	db	"and e",0
	db	"and h",0
	db	"and l",0
	db	"and (hl)",0
	db	"and a",0
	db	"xor b",0
	db	"xor c",0
	db	"xor d",0
	db	"xor e",0
	db	"xor h",0
	db	"xor l",0
	db	"xor (hl)",0
	db	"xor a",0

	db	"or b",0
	db	"or c",0
	db	"or d",0
	db	"or e",0
	db	"or h",0
	db	"or l",0
	db	"or (hl)",0
	db	"or a",0
	db	"cp b",0
	db	"cp c",0
	db	"cp d",0
	db	"cp e",0
	db	"cp h",0
	db	"cp l",0
	db	"cp (hl)",0
	db	"cp a",0

	db	"ret nz",0
	db	"pop bc",0
	db	"jp nz,",0
	db	"jp ",0
	db	"callnz,",0
	db	"push bc",0
	db	"add a,",0
	db	"rst 00H",0
	db	"ret z",0
	db	"ret",0
	db	"jp z,",0
	db	"!!CB!!",0
	db	"call z,",0
	db	"call ",0
	db	"adc a,",0
	db	"rst 08H",0

	db	"ret nc",0
	db	"pop de",0
	db	"jp nc,",0
	db	"out(  ),a",0
	db	"callnc,",0
	db	"push de",0
	db	"sub ",0
	db	"rst 10H",0
	db	"ret c",0
	db	"exx",0
	db	"jp c,",0
	db	"in a,(",0
	db	"call c,",0
	db	"!!DD!!",0
	db	"sbc ",0
	db	"rst 18H",0
	
	db	"ret po",0
	db	"pop hl",0
	db	"jp po,",0
	db	"ex (sp),hl",0
	db	"callpo,",0
	db	"push hl",0
	db	"and ",0
	db	"rst 20H",0
	db	"ret pe",0
	db	"jp (hl)",0
	db	"jp pe,",0
	db	"ex de,hl",0
	db	"callpe,",0
	db	"!!ED!!",0
	db	"xor ",0
	db	"bcall ",0

	db	"ret p",0
	db	"pop af",0
	db	"jp p,",0
	db	"di",0
	db	"call p,",0
	db	"push af",0
	db	"or ",0
	db	"rst 30H",0
	db	"ret m",0
	db	"ld sp,hl",0
	db	"jp m,",0
	db	"ei",0
	db	"call m,",0
	db	"!!FD!!",0
	db	"cp ",0
	db	"rst 38H",0

dstred:
	
	db	"adc hl,bc",0
	db	"adc hl,de",0
	db	"adc hl,hl",0
	db	"adc hl,sp",0
	db	"cpd",0
	db	"cpdr",0
	db	"cpi",0
	db	"cpir",0
	db	"im 0",0
	db	"im 1",0
	db	"im 2",0
	db	"in b,(c)",0
	db	"in c,(c)",0
	db	"in d,(c)",0
	db	"in e,(c)",0
	db	"in h,(c)",0
	db	"in l,(c)",0
	db	"in a,(c)",0
	db	"ind",0
	db	"indr",0
	db	"ini",0
	db	"inir",0
	db	"ld(    ),bc",0
	db	"ld(    ),de",0
	db	"ld(    ),sp",0
	db	"ld a,i",0
	db	"ld a,r",0
	db	"ld bc,(",0
	db	"ld de,(",0
	db	"ld i,a",0
	db	"ld r,a",0
	db	"ld sp,(",0
	db	"ldd",0
	db	"lddr",0
	db	"ldi",0
	db	"ldir",0
	db	"outd",0
	db	"otdr",0
	db	"outi",0
	db	"otir",0
	db	"out (c),b",0
	db	"out (c),c",0
	db	"out (c),d",0
	db	"out (c),e",0
	db	"out (c),h",0
	db	"out (c),l",0
	db	"out (c),a",0
	db	"reti",0
	db	"retn",0
	db	"rld",0
	db	"rrd",0
	db	"sbc hl,bc",0
	db	"sbc hl,de",0
	db	"sbc hl,hl",0
	db	"sbc hl,sp",0
       db     "neg",0

dstrcb:
       db     "rlc ",0
       db     "rrc ",0
       db     "rl ",0
       db     "rr ",0
       db     "sla ",0
       db     "sra ",0
       db     "sll ",0
       db     "srl ",0
       db     "bit 0,",0
       db     "bit 1,",0
       db     "bit 2,",0
       db     "bit 3,",0
       db     "bit 4,",0
       db     "bit 5,",0
       db     "bit 6,",0
       db     "bit 7,",0
       db     "res 0,",0
       db     "res 1,",0
       db     "res 2,",0
       db     "res 3,",0
       db     "res 4,",0
       db     "res 5,",0
       db     "res 6,",0
       db     "res 7,",0
       db     "set 0,",0
       db     "set 1,",0
       db     "set 2,",0
       db     "set 3,",0
       db     "set 4,",0
       db     "set 5,",0
       db     "set 6,",0
       db     "set 7,",0

dregstxt:
       db     "b   c   d   e   h   l   (hl)a   "
DDUnknownTXT:
       db     "!!DD!!",0
EDUnknownTXT:
       db     "!!ED!!",0
FDUnknownTXT:
       db     "!!FD!!",0

IXIYNoOffset:
       db     09,19h,29h,39h,2Bh,0E3h,23h,0E9h,20h,0E5h,0E1h,0F9h,21h,22h,2Ah
IXIYNoOffsetNum      EQU    $-IXIYNoOffset
