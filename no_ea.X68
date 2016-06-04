*-----------------------------------------------------------
* Title      : No Opcode
* Written by : Adam Croutworst
* Date       : 2016/06/04
* Description: Subroutine that handles input that does not
*              decode into a valid opcode and is assumed
*              to be data
*-----------------------------------------------------------
NO_EA:
    MOVEM.L     A1-A5/D0-D7,-(SP)
    LEA         ERROR,A0
    ADDQ        #1,(A0)
    LEA         ADDR_TXT,A0
    JSR         PUSHBUFFER
        
    MOVEM.L     (SP)+,A1-A5/D0-D7
    RTS

    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
