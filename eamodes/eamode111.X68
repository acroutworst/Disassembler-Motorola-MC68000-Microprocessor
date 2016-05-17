************************************
* Effective Address w/ 111         *
* ** IMMEDIATE | ABSOLUTE ADDRESS  *
*                                  *
* This subroutine is done!         *
************************************
EAMODE111:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         SUBTABLE,A1
    
    MOVE        D5,D0
    MULU        #6,D0
    JSR         0(A1,D0)            ; send to subtable
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
