************************************
* Instructions Beginning With 0000 *
* ** ADDI                          *
*                                  *
* This subroutine is done!         *
************************************
INSTR0000:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    LEA         BUFFER,A1               ; load the buffer to add to it
    LEA         ADDI_TXT,A0             ; load the addi text
    JSR         PUSHBUFFER              ; push the text to the buffer
    JSR         UPDATE_OPCODE
    
    ADDQ.W      #1,D7
    ROR.W       #1,D7
    ADDQ.W      #7,D7
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
