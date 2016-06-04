************************************
* Effective Address w/ 010         *
* ** INDIRECT ADDRESS REGISTER     *
*                                  *
* This subroutine is done!         *
************************************
EAMODE010:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         O_PAREN,A0         ; load ( text
    
    CLR.L       D1              
    MOVE        D5,D1              ; move original data to D1
    ANDI        #7,D1              ; add 7
    
    MOVE.B      #2,D0              ; choose ea buffer
    JSR         PUSHBUFFER         ; send data to buffer
    
    LEA         C_PAREN,A0         ; load ) text
    
    MOVE.B      #2,D0              ; choose ea buffer
    JSR         PUSHBUFFER         ; send data to buffer
    
    MOVE.B      #3,D2              ; string of 3 
    JSR         HEX2ASCII
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
