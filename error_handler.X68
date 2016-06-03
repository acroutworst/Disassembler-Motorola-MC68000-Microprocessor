*-----------------------------------------------------------
* Title      : Error Handler
* Written by : Geoff Friesen
* Date       : 2016/06/03
* Description: Subroutine to push a word of data to the ea
*              buffer when an error condition occurs.
*-----------------------------------------------------------
ERROR_HANDLER:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    MOVE.B      #2,D0
    MOVE.W      CURRENT_INSTR,D1
    MOVE.B      #4,D2
    
    JSR         HEX2ASCII   
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
