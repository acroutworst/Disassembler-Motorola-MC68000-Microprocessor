************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
************************************
INSTR0001:
        MOVEM.L     A0-A5/D0-D7,-(SP)

    * TODO - some stuff from MOVE.B
        LEA         MOVE_TXT,A0
        JSR         PUSHBUFFER
        JSR         UPDATE_OPCODE
        
        ADDQ        #2,D7
        ROR.W       #2,D7
        ADDQ        #7,D7
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
