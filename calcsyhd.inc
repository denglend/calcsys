;This is the application header definition area required for all apps.
 IFNDEF ION
 db 080h,0Fh    ;Field: Program length
 db   00h,00h,00h,00h 
 db 080h,012h    ;Field: Program type
 IFDEF TI83P
  IFDEF BETA
   db 9Fh,04h
  ELSE
   db 01h,04h  
  ENDIF
 ELSE
  IFDEF BETA
   db 2fh,02h
  ELSE
   db 01h,02h
  ENDIF
 ENDIF
 db 080h,021h    ;Field: App ID
 db   01h       
 db 080h,031h    ;Field: App Build
 db   03h    
 db 080h,048h    ;Field: App Name
 db "Calcsys "
 db 080h,081h    ;Field: App Pages
 db 01h         
 db 080h,090h    ;No default splash screen
 db 03h,026h ,09h,04h, 04h,06fh,01bh,80h     ;Field: Date stamp- 5/12/1999
 db 02h,0dh,040h                             ;Dummy encrypted TI date stamp signature
 db 0a1h ,06bh ,099h ,0f6h ,059h ,0bch ,067h 
 db 0f5h ,085h ,09ch ,09h ,06ch ,0fh ,0b4h ,03h ,09bh ,0c9h 
 db 03h ,032h ,02ch ,0e0h ,03h ,020h ,0e3h ,02ch ,0f4h ,02dh 
 db 073h ,0b4h ,027h ,0c4h ,0a0h ,072h ,054h ,0b9h ,0eah ,07ch 
 db 03bh ,0aah ,016h ,0f6h ,077h ,083h ,07ah ,0eeh ,01ah ,0d4h 
 db 042h ,04ch ,06bh ,08bh ,013h ,01fh ,0bbh ,093h ,08bh ,0fch 
 db 019h ,01ch ,03ch ,0ech ,04dh ,0e5h ,075h 
 db 80h,7Fh      ;Field: Program Image length
 db   0,0,0,0    ;Length=0, N/A
 db   0,0,0,0    ;Reserved
 db   0,0,0,0    ;Reserved
 db   0,0,0,0    ;Reserved
 db   0,0,0,0    ;Reserved
 ELSE
 IFDEF ION
       org    9327h
       xor    a
       jr     nc,Init
       db     "Calcsys Ion",0
 ENDIF
 ENDIF

