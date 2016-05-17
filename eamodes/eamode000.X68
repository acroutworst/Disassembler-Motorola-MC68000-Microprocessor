************************************
* Effective Address w/ 000         *
* ** DATA DIRECT ADDRESS           *
*                                  *
* This subroutine is done!         *
************************************
EAMODE000:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    MOVE        D5,D0
    ANDI        #7,D0
    BSR         DATA_BUFFER         ; send data to buffer
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
