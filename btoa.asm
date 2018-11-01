;Program to convert BINARY to ASCII

.MODEL SMALL
.CODE
.STARTUP

MOV CX,8
MOV BX,0
INP:
    SHL BX,1
    MOV AH,1
    INT 21H
    SUB AL,30H
    ADD BL,AL
    LOOP INP
    
MOV DL,"="
MOV AH,2
INT 21H
    
MOV DL,10
MOV CX,4
MOV AX,BX
MOV BX,0
GETNUM:
    DIV DL
    ADD BL,AH
    MOV AH,0
    ROR BX,4
    LOOP GETNUM
MOV CX,4
MOV DX,0
DIS:
    MOV DX,BX
    AND DX,0F000H
    ROL DX,4
    CMP DL,9
    JBE L1
        ADD DL,7H
        L1: ADD DL,30H
    MOV AH,02
    INT 21H
    SHL BX,4
    LOOP DIS
.EXIT 
END