************************************
* Instructions Beginning With 1011 *
* ** CMP                           *
* ** CMPA                          *
************************************
INSTR1011:
    
    MOVEM.L     A0-A5/D0-D7,-(SP)
    CLR.L       D7
    * setup bitmasker
    MOVE.B      #6,D4           ; choose bitmask routine
    MOVE.W      (A6),D5         ; move instruction in
    JSR         BITMASKER
    
    * check for cmp
    CMP.B       #3,D5
    BLT         HNDL_CMP
    
    * check for cmpa
    BEQ         HNDL_CMPA
    
    CMP.B       #7,D5
    BEQ         HNDL_CMPA
    
    JSR         NO_OPCODE
    BRA         PUSH_1011

HNDL_CMP:
    * setup size for CMP
    MOVE.B      #1,D7
    ROR.W       #1,D7
    MOVE.B      #7,D7
    ROR.W       #4,D7
    SWAP        D7
    MOVE.W      (A6),D7
    LEA         CMP_TXT,A0
    BRA         PUSH_1011

HNDL_CMPA:
    * setup size for CMPA
    ROR.W       #1,D7
    MOVE.B      #8,D7
    ROR.W       #4,D7
    SWAP        D7
    MOVE.W      (A6),D7
    LEA         CMPA_TXT,A0
    BRA         PUSH_1011

PUSH_1011:
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    CMP.B       #0,D7
    BEQ         FINISH_1011
    JSR         GET_OP_SIZE
    BRA         FINISH_1011

FINISH_1011:
    MOVEM.L     (SP)+,A0-A5/D0-D7    
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
