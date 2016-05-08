************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
************************************
INSTR0001:
    MOVEM.L     A0-A5/D0-D7,-(SP)

    * TODO - some stuff from MOVE.B
    LEA         BUFFER,A1
    LEA         ADDI_TXT,A2
    MOVE.L      (A2),BUFFER
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS
