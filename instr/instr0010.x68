************************************
* Instructions Beginning With 0010 *
* ** MOVE.L                        *
* ** MOVEA.L                       *
************************************
INSTR0010:
    MOVEM.L     A0-A5/D0-D7,-(SP)       ; registers to stack
    
    LEA         BUFFER,A1               ; load the buffer
    
    MOVE.W      (A6),D5                 ; setup the bitmasker for bits
    MOVE.B      #6,D4                   ; 8 to 6
    JSR         BITMASKER
    
    CMP.B       #1,D5
    BNE         MOVE0010
    LEA         MOVEA_TXT,A0
    BRA         DONE0010
    
MOVE0010:
    LEA         MOVE_TXT,A0
    BRA         DONE0010
    
DONE0010:
    
    JSR         PUSHBUFFER
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
