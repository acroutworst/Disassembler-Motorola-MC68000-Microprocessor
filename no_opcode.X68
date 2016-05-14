*-----------------------------------------------------------
* Title      : No Opcode
* Written by : Geoff Friesen
* Date       : 2016/05/12
* Description: Subroutine that handles input that does not
*              decode into a valid opcode and is assumed
*              to be data
*-----------------------------------------------------------
NO_OPCODE:
    
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         DATA_TXT,A0
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE    
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
