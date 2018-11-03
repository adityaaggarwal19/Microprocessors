;ADDITION OF ARRAYS
.MODEL SMALL
.386

.DATA
ARRAY1 DB 100 DUP(?)
ARRAY2 DB 100 DUP(?)

ELE DB 0
FL DB 0
M1 DB "ENTER NO.",10,13,"$"
M2 DB "ENTER 1ST ARRAY",10,13,"$"
M3 DB "ENTER 2ND ARRAY",10,13,"$"
.CODE
.STARTUP

        MOV AH,09H;PRINTING MSG
        LEA DX,M1
        INT 21H
;   TAKING INPUT OF 16 BIT NUMBERS
MOV CX,2
MOV BX,0
INP1:;TOTAL NO. OF ELEMENTS IN THE ARRAY(N) MAX 99
    SHL BX,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L
       SUB AL,7H
    L: SUB AL,30H
    ADD BL,AL
    LOOP INP1  
    


    MOV CX,BX;TO ENTER THE  N NO.
    MOV BP,BX;AUXILIARY STORAGE 
    MOV BX,OFFSET ARRAY1
    MOV DI,0
   
    MOV AH,09H;ENTERING 1ST ARRAY
    LEA DX,M2
        INT 21H
    INP2:;ENTERING ELEMENTS
    
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L1
        SUB AL,7H
    L1: SUB AL,30H
    MOV DL,AL
    SHL DL,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L3
        SUB AL,7H
        L3: SUB AL,30H
    ADD DL,AL
    MOV [BX+DI],DL
    ADD DI,2
    LOOP INP2
    
    
    MOV BX,OFFSET ARRAY2
    MOV AH,09H;ENTERING 2ND ARRAY
    LEA DX,M3
        INT 21H
        
        MOV CX,BP
        INP3:;ENTERING ELEMENTS
    
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L9
        SUB AL,7H
        L9: SUB AL,30H
    MOV DL,AL
    SHL DL,4
    MOV AH,01
    INT 21H
    CMP AL,39H
    JBE L10
        SUB AL,7H
        L10: SUB AL,30H
    ADD DL,AL
    MOV [BX+DI],DL
    ADD DI,2
    LOOP INP3
    
    
    
    
    ;ADDING ARRAYS
    MOV CX,BP
    MOV DI,0
    DIS1:
    MOV BX,OFFSET ARRAY1
    MOV DL,[BX+DI]
    MOV BX,OFFSET ARRAY2
    
    ADD DL,[BX+DI]
    MOV AL,DL
    AND DL,0F0H
    SHR DL,4
    ADD DL,30H
    MOV AH,02
    INT 21H
    MOV DL,AL
    AND DL,0FH
    ADD DL,30H
    MOV AH,02
    INT 21H
    ADD DI,2
    LOOP DIS1
   
    
      
    
    
    
    
    
    .EXIT
END
