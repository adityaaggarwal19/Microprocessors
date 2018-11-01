;program to take input of numbers and perform addition operation (8 digit)(32 bit)
.MODEL SMALL
.386
.CODE
.STARTUP
; taking input of four digit in BX
MOV ECX,8
MOV EBX,0
INP1:
    SHL EBX,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE H
        SUB AL,7H
    H: SUB AL,30H
    ADD BL,AL
    LOOP INP1
; seperating with + operator  
MOV DL,'+'
MOV AH,02
INT 21H
    
; taking input of four digit in DX
MOV ECX,8
MOV EDX,0
INP2:
    SHL EDX,4
    MOV AH,01
    INT 21H
    SUB AL,30H
    ADD DL,AL
    LOOP INP2
;ADD TWO NUMBERS
ADD EBX,EDX
; seperating with = operator  
MOV DL,'='
MOV AH,02
INT 21H

MOV ECX,8
MOV EDX,0
DIS:
    MOV EDX,EBX
    AND EDX,0F0000000H
    ROL EDX,4
    CMP DL,9
    JBE L2
        ADD DL,7H
    L2: ADD DL,30H
    MOV AH,02
    INT 21H
    SHL EBX,4
    LOOP DIS
.EXIT
END