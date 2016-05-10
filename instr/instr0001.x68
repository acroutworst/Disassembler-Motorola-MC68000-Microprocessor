************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
************************************
INSTR0001:
        MOVEM.L     A0-A5/D0-D7,-(SP)

    * TODO - some stuff from MOVE.B
        LEA         BUFFER,A1
        LEA         MOVE_TXT,A0
        JSR         PUSHBUFFER
        MOVEM.L     (SP)+,A0-A5/D0-D7
        RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
