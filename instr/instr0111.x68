************************************
* Instructions Beginning With 0111 *
* ** MOVEQ - done                  *
*                                  *
* This subroutine is done!         *
************************************
INSTR0111:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         MOVEQ_TXT,A0
    MOVE.B      #1,D0
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    CLR         D7
    
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #2,(A0)

    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
