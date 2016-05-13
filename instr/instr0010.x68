************************************
* Instructions Beginning With 0010 *
* ** MOVE.L                        *
* ** MOVEA.L                       *
************************************
INSTR0010:
    MOVEM.L     A0-A5/D0-D7,-(SP)       ; registers to stack
    
    LEA         BUFFER,A1               ; load the buffer
    * check for MOVEA    
    MOVE.W      (A6),D5                 ; setup the bitmasker for bits
    MOVE.B      #6,D4                   ; 8 to 6
    JSR         BITMASKER
    
    CMP.B       #1,D5
    BNE         MOVE0010
    LEA         MOVEA_TXT,A0
    BRA         DONE0010
    
MOVE0010:
    LEA         MOVE_TXT,A0
    BRA         DONE0010
    
DONE0010:
    
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    
    ADDQ.W      #1,D7
    ROR.W       #1,D7
    ADD.W      #13,D7
    ROR.W       #4,D7
    SWAP        D7
    MOVE.W      (A6),D7
    
    JSR         GET_OP_SIZE
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
