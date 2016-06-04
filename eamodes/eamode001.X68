************************************
* Effective Address w/ 001         *
* ** DATA ADDRESS REGISTER         *
*                                  *
* This subroutine is done!         *
************************************
EAMODE001:
    MOVEM.L     A0-A5/D0-D7,-(SP)   ; move registers to stack
    
    DIVU        #8,D5               ; divide value by 8
    
    ANDI        #7,D0               ; add 7
    MOVE.B      #2,D0               ; choose ea buffer
    
    JSR         PUSHBUFFER          ; send data to buffer
    
    MOVE.W      D5,D1
    MOVE.B      #1,D2
    JSR         HEX2ASCII           ; convert to ascii
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
