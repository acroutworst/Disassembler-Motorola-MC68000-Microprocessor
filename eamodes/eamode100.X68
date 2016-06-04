************************************
* Effective Address w/ 100         *
* ** INDIRECT ADDRESS REGISTER w/  *
*    PRE DECREMENT                 *
* This subroutine is done!         *
************************************
EAMODE100:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    LEA         MINUS,A0        ; load - text
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER      ; send data to ea buffer
    
    LEA         O_PAREN,A0      ; load ( text
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER      ; send data to ea buffer
    
    CLR.L       D1
    MOVE        D5,D1
    ANDI        #7,D1
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER      ; send data to ea buffer
    
    LEA         C_PAREN,A0      ; load ) param
    
    MOVE.B      #2,D0
    JSR         PUSHBUFFER      ; send data to ea buffer
    
    MOVE.B      #1,D2           ; choose length of string
    JSR         HEX2ASCII       ; convert to ascii and push to buffer
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
