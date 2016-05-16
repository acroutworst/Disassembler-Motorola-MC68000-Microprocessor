************************************
* Instructions Beginning With 0111 *
* ** MOVEQ - done                  *
*                                  *
* This subroutine is done!         *
************************************
INSTR0111:
    LEA         MOVEQ,A0
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
