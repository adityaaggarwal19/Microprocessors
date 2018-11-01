;program to take input of numbers and perform multiplication operation (8 digit)(32 bit)
.MODEL SMALL
.386
.CODE
.STARTUP
;   TAKING INPUT OF 32 BIT NUMBERS
MOV ECX,8
MOV EBX,0
INP1:
    SHL EBX,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L
        SUB AL,7H
    L: SUB AL,30H
    ADD BL,AL
    LOOP INP1   
; seperating with * operator  
MOV DL,'*'
MOV AH,02
INT 21H

MOV ECX,8
MOV EDX,0
INP2:
    SHL EDX,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L1
        SUB AL,7H
    L1: SUB AL,30H
    ADD DL,AL
    LOOP INP2

MOV EAX,EDX ;   MOVING EDX TO ACCUMULATOR

MUL EBX ;   MULTIPLYING BY EAX

MOV EBP,EDX
MOV ESP,EAX
; seperating with = operator  
MOV DL,'='
MOV AH,02
INT 21H

;   DISPLAYING EDX:EAX RESULT
MOV ECX,8
MOV EDX,0
MOV EAX,0
DIS1:
    MOV EDX,EBP
    AND EDX,0F0000000H
    ROL EDX,4
    CMP DL,9
    JBE L2
        ADD DL,7H
    L2: ADD DL,30H
    MOV AH,02
    INT 21H
    SHL EBP,4
    LOOP DIS1
MOV ECX,8
MOV EDX,0
DIS2:
    MOV EDX,ESP
    AND EDX,4026531840    ;F0000000H
    ROL EDX,4
    CMP DL,9
    JBE L3
        ADD DL,7H
        L3: ADD DL,30H
    MOV AH,02
    INT 21H
    SHL ESP,4
    LOOP DIS2
.EXIT
END