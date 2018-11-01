;Program to sort array
.MODEL SMALL
.DATA
ARR DB 100 DUP(?)   ;10 byte is reserved for array
MES1 DB 13,10,"ENTER THE NO OF ELEMENTS(00H-64H) : $"
MES2 DB 13,10,"ENTER THE ELEMENTS : $"
MES3 DB 13,10,"AFTER SORTING : $"
NO DW ?
.CODE
.STARTUP

NA:

LEA DX,MES1  ;LOAD EFFECTIVE ADDRESS OF MES
MOV AH,9
INT 21H

MOV CX,2
MOV BX,0
INPN:
    SHL BL,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE H
        SUB AL,7H
        H: SUB AL,30H
    ADD BL,AL
    LOOP INPN

CMP BX,100
JA NA
    
LEA DX,MES2  ;LOAD EFFECTIVE ADDRESS OF MES
MOV AH,9
INT 21H

MOV NO,BX

MOV BX,OFFSET ARR
MOV CX,NO
MOV DI,0
;INPUT OF ARRAY
INP:
    MOV DL,0
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L
       SUB AL,7H
    L: SUB AL,30H
    ADD DL,AL
    SHL DL,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L2
       SUB AL,7H
       L2: SUB AL,30H
    ADD DL,AL
    MOV [BX+DI],DL
    INC DI
    MOV DL," "
    MOV AH,02
    INT 21H
    LOOP INP

DEC NO
;SORT BY BUBBLE SORT
MOV DX,0    ;i
MOV CX,NO    ;I
MOV BX,OFFSET ARR
LOOP1:  ;for(i=0;i<n-1;i++)
    MOV DI,0    ;j
    MOV SI,NO
    SUB SI,DX
    LOOP2:  ;for(j=0;j<n-i-1;j++)
        MOV AH,[BX+DI]
        MOV AL,[BX+DI+1]
        CMP AH,AL   ;a[j]>=a[j+1]
        JBE T
            XCHG AL,AH
       T: MOV [BX+DI],AH
          MOV [BX+DI+1],AL
          INC DI   ;j++
          CMP DI,SI
          JAE S
            JMP LOOP2
    S:  INC DX
    LOOP LOOP1
    
LEA DX,MES3  ;LOAD EFFECTIVE ADDRESS OF MES
MOV AH,9
INT 21H
;OUTPUT OF ARRAY
INC NO
MOV DI,0
MOV BX,OFFSET ARR
MOV CX,NO
OUTPUT:
    MOV DL,[BX+DI]
    AND DL,0F0H
    SHR DL,4
    CMP DL,9
    JBE L1
        ADD DL,7H
    L1: ADD DL,30H
    MOV AH,02
    INT 21H
    MOV DL,[BX+DI]
    AND DL,0FH
    CMP DL,9
    JBE L3
        ADD DL,7H
    L3: ADD DL,30H
    MOV AH,02
    INT 21H
    INC DI
    MOV DL," "
    MOV AH,02
    INT 21H
    LOOP OUTPUT   
.EXIT
END