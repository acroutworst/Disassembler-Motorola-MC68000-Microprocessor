************************************
* Effective Address w/ 000         *
* ** DATA DIRECT ADDRESS           *
*                                  *
* This subroutine is done!         *
************************************
EAMODE000:
    MOVEM.L     A0-A5/D0-D7,-(SP)   ; move registers to stack
    
    
    
    LEA         D,A0                ; load D text / LEA #'D',A0 
    MOVE.B      #2,D0               ; choose ea buffer
    
    JSR         PUSHBUFFER          ; send data to buffer
    
    MOVE.W      D5,D1               ; move original value to D1
    MOVE.B      #1,D2               ; choose length of string
    JSR         HEX2ASCII           ; convert to ascii and push to buffer
         
    MOVEM.L     (SP)+,A0-A5/D0-D7   ; move registers back from stack
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
