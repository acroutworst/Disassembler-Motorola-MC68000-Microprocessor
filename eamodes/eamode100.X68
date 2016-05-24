************************************
* Effective Address w/ 100         *
* ** INDIRECT ADDRESS REGISTER w/  *
*    PRE DECREMENT                 *
* This subroutine is done!         *
************************************
EAMODE100:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    MOVE.W      MINUS,(A6)+
    MOVE.W      O_PAREN,(A6)+
    
    CLR.L       D0
    MOVE        D5,D0
    ANDI        #7,D0
    BSR         EA_BUFFER         ; send data to buffer
    
    MOVE.W      C_PAREN,(A6)+
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
