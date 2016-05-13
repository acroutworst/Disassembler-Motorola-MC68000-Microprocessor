*-----------------------------------------------------------
* Title      : Clear Variables
* Written by : Geoff Friesen
* Date       : 2016/05/12
* Description: Clears all variables used by the program to
*              reset for another iteration
*-----------------------------------------------------------
CLEAR_VARS:
    MOVEM.L     A0-A6/D0-D7,-(SP)
    
    LEA         BUFFER_POS,A0
    LEA         OPCODE,A1
    LEA         SIZE,A2
    MOVE.B      #0,(A0)
    MOVE.B      #0,(A2)
        
    MOVE.B      #5,D1
    BSR         VARS_LOOP
    
    LEA         BUFFER,A1
    MOVE.B      #40,D1
    BSR         VARS_LOOP
    
    MOVEM.L     (SP)+,A0-A6/D0-D7
    RTS
    
VARS_LOOP:
    MOVE.B      #0,(A1)+
    ADDQ        #1,D0
    CMP.B       D1,D0
    BNE         VARS_LOOP
    RTS
    

    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
