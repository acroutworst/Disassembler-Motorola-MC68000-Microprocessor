************************************
* Instructions Beginning With 1000 *
* ** DIVU                          *
* ** DIVS                          *
* ** OR                            *
************************************
INSTR1000:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    CLR.L       D7
    * check for DIVS and DIVU
    MOVE.B      #6,D4
    MOVE.W      (A6),D5
    JSR         BITMASKER
    
    * cmp to DIVU
    CMP.B       #3,D5
    BEQ         HNDL_DIVU
    
    * cmp to DIVS
    CMP.B       #7,D5
    BEQ         HNDL_DIVS
    
    * must be or - prep for get size
    LEA         OR_TXT,A0
    MOVE.B      #1,D7               ; 2 bits for size
    ROR.W       #1,D7               ; rotate to top
    MOVE.B      #7,D7               ; 7 start index
    ROR.W       #4,D7               ; rotate to top
    SWAP        D7
    MOVE.W      (A6),D7             ; move instruction in
    
    
    BRA         NO_OP_1000          * if none found
    
HNDL_DIVU:
    LEA         DIVU_TXT,A0
    BRA         PUSH_1000
    
HNDL_DIVS:
    LEA         DIVS_TXT,A0
    BRA         PUSH_1000
    
NO_OP_1000:
    JSR         NO_OPCODE
    BRA         PUSH_1000
        
PUSH_1000:
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    CMP.L       #0,D7
    BEQ         FINISH_1000
    JSR         GET_OP_SIZE
    BRA         FINISH_1000
    
FINISH_1000:    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
