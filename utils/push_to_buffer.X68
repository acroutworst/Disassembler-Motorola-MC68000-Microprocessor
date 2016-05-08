*-----------------------------------------------------------
* Title      : Push to Buffer
* Written by : Geoff Friesen
* Date       : 2016/05/08
* Description: Takes a null-terminated string loaded into A0 
*              and pushes it to an address in memory in A1 
*              one character at a time
*-----------------------------------------------------------
PUSHBUFFER:
    MOVEM.L     A2-A6/D0-D7,-(SP)
    MOVE.B      (A0)+,(A1)+
    CMP.B       #0,(A0)
    BEQ         PUSHBUFFERDONE
    BRA         PUSHBUFFER
    
PUSHBUFFERDONE:
    MOVEM.L     (SP)+,A2-A6/D0-D7
    RTS
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
