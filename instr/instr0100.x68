************************************
* Instructions Beginning With 0100 *
* ** LEA                           *
* ** CLR (B, W, L)                 *
* ** MOVEM                         *
* ** NOP                           *
* ** RTS                           *
* ** JSR                           *
************************************
INSTR0100:
    MOVE.B  #1,D4
    MOVE.W  (A6),D5
    JSR     BITMASKER
    RTS
