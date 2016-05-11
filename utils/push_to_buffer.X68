*-----------------------------------------------------------
* Title      : Push to Buffer
* Written by : Geoff Friesen
* Date       : 2016/05/08
* Description: Takes a null-terminated string loaded into A0 
*              and pushes it to the buffer for display
*-----------------------------------------------------------
PUSHBUFFER:
    MOVEM.L     A2-A6/D0-D7,-(SP)
    LEA         BUFFER,A1
    LEA         BUFFER_POS,A2
    MOVE.W      (A2),D0
    ADDA.L      D0,A1
PUSH_LOOP:
    MOVE.B      (A0)+,(A1)+
    
    ADDQ        #1,(A2)
    CMP.B       #0,(A0)
    BEQ         PUSHBUFFERDONE
    BRA         PUSH_LOOP
    
PUSHBUFFERDONE:
    MOVEM.L     (SP)+,A2-A6/D0-D7
    RTS
    



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
