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
    JSR     BITMASKER         ; mask the second set of 4 bits

    RTS

* need a jump table here
FOUR_TABLE:
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   NOP
   RTS
   JSR      FOUR1110
   RTS
   NOP
   RTS

**************************************************
* Instructions With 1110 as Second Set of 4 Bits *
* ** NOP
* ** TODO - finish this list
**************************************************
FOUR1110:
   * check for NOP
   MOVE.W      (A6),D5
   AND.W       #$00FF,D5
   CMP.B       #$71,D5
   BEQ         HNDL_NOP

HNDL_NOP:
   * TODO - add NOP to the buffer
