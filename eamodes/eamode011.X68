************************************
* Effective Address w/ 011         *
* ** INDIRECT ADDRESS REGISTER w/  *
*    POST INCREMENT                *
* This subroutine is done!         *
************************************
EAMODE011:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         O_PAREN,A0        ; load ( text
    
    CLR.L       D1
    MOVE        D5,D1
    ANDI        #7,D1
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER        ; send data to buffer
    
    LEA         C_PAREN,A0     ; load ) text
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER        ; send data to buffer
    
    LEA         PLUS,A0        ; load + text 
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER        ; send data to buffer
    
    MOVE.B      #4,D2
    JSR         HEX2ASCII
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
