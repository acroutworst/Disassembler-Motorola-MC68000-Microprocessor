************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
*                                  *
* ** This subroutine is done!      *
************************************
INSTR0001:
    MOVEM.L     A0-A5/D0-D7,-(SP)
        
    
    LEA         MOVE_TXT,A0
    BRA         BUFFER0001
            
BUFFER0001:
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    BRA         PREP_SIZE_0001

PREP_SIZE_0001:        
    ADDQ        #2,D7
    ROR.W       #2,D7
    ADDQ        #7,D7
    ROR.W       #4,D7
    SWAP        D7
    MOVE.W      (A6),D7
    JSR         GET_OP_SIZE
        
INSTR0001DONE:
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
