;Program to convert ASCII to BINARY 

.MODEL SMALL
.DATA
TEMP DW ?
.CODE
.STARTUP

MOV CX,4
MOV BX,0
INP1:
    SHL BX,4
    MOV AH,01
    INT 21H
    SUB AL,30H
    ADD BL,AL
    LOOP INP1

MOV TEMP,10
MOV DX,0
MOV CX,4
MOV AX,0
GETNUM:
    MUL TEMP
    MOV DX,BX
    AND DX,0F000H
    ROL DX,4
    SHL BX,4
    ADD AX,DX
    LOOP GETNUM
    
MOV BX,AX
MOV DL,"="
MOV AH,2
INT 21H

MOV CX,16
OUTPUT:
    ROL BX,1
    JC C
    MOV DL,"0"
    MOV AH,2
    INT 21H
    JMP L
    C:
    MOV DL,"1"
        MOV AH,2
        INT 21H
    L:LOOP OUTPUT

.EXIT 
END