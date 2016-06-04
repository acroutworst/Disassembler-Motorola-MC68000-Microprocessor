*-----------------------------------------------------------
* Title      : No Opcode
* Written by : Geoff Friesen
* Date       : 2016/05/12
* Description: Subroutine that handles input that does not
*              decode into a valid opcode and is assumed
*              to be data
*-----------------------------------------------------------
NO_OPCODE:
    
    MOVEM.L     A1-A5/D0-D7,-(SP)
    LEA         ERROR,A0
    ADDQ        #1,(A0)
    LEA         DATA_TXT,A0
    JSR         PUSHBUFFER
        
    MOVEM.L     (SP)+,A1-A5/D0-D7
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
