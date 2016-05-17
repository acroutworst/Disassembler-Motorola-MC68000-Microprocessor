************************************
* Effective Address w/ 011         *
* ** INDIRECT ADDRESS REGISTER w/  *
*    POST INCREMENT                *
* This subroutine is done!         *
************************************
EAMODE011:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    MOVE.W      O_PAREN,(A6)+
    
    CLR.L       D0
    MOVE        D5,D0
    ANDI        #7,D0
    BSR         ADDRESS_BUFFER         ; send data to buffer
    
    MOVE.W      C_PAREN,(A6)+
    MOVE.W      PLUS,(A6)+
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
