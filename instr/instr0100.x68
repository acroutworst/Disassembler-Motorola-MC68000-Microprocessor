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
    
    LEA     FOUR_TABLE,A0
    MULU    #8,D5
    JSR     0(A0,D5)
    RTS

* need a jump table here
FOUR_TABLE:
   JSR      FOUR0000
   RTS
   JSR      FOUR0001
   RTS
   JSR      FOUR0010
   RTS
   JSR      FOUR0011
   RTS
   JSR      FOUR0100
   RTS
   JSR      FOUR0101
   RTS
   JSR      FOUR0110
   RTS
   JSR      FOUR0111
   RTS
   JSR      FOUR1000
   RTS
   JSR      FOUR1001
   RTS
   JSR      FOUR1010
   RTS
   JSR      FOUR1011
   RTS
   JSR      FOUR1100
   RTS
   JSR      FOUR1101
   RTS
   JSR      FOUR1110
   RTS
   JSR      FOUR1111
   RTS

**************************************************
* Instructions With 0000 as Second Set of 4 Bits *
**************************************************
FOUR0000:
    RTS
**************************************************
* Instructions With 0001 as Second Set of 4 Bits *
**************************************************
FOUR0001:
    RTS
    
**************************************************
* Instructions With 0010 as Second Set of 4 Bits *
**************************************************
FOUR0010:
    RTS

**************************************************
* Instructions With 0011 as Second Set of 4 Bits *
**************************************************
FOUR0011:
    RTS

**************************************************
* Instructions With 0100 as Second Set of 4 Bits *
**************************************************
FOUR0100:
    RTS

**************************************************
* Instructions With 0101 as Second Set of 4 Bits *
**************************************************
FOUR0101:
    RTS

**************************************************
* Instructions With 0110 as Second Set of 4 Bits *
**************************************************
FOUR0110:
    RTS

**************************************************
* Instructions With 0111 as Second Set of 4 Bits *
**************************************************
FOUR0111:
    RTS

**************************************************
* Instructions With 1000 as Second Set of 4 Bits *
**************************************************
FOUR1000:
    RTS

**************************************************
* Instructions With 1001 as Second Set of 4 Bits *
**************************************************
FOUR1001:
    RTS

**************************************************
* Instructions With 1010 as Second Set of 4 Bits *
**************************************************
FOUR1010:
    RTS

**************************************************
* Instructions With 1011 as Second Set of 4 Bits *
**************************************************
FOUR1011:
    RTS

**************************************************
* Instructions With 1100 as Second Set of 4 Bits *
**************************************************
FOUR1100:
    RTS

**************************************************
* Instructions With 1101 as Second Set of 4 Bits *
**************************************************
FOUR1101:
    RTS

**************************************************
* Instructions With 1110 as Second Set of 4 Bits *
* ** NOP
* ** TODO - finish this list
**************************************************
FOUR1110:
   * mask for last 8 bits to compare
   MOVE.W      (A6),D5
   AND.W       #$00FF,D5
   
   * check for NOP
   CMP.B       #$71,D5
   BEQ         HNDL_NOP
   
   * check for RTS
   CMP.B       #$75,D5
   BEQ         HNDL_RTS

HNDL_NOP:
    LEA        NOP_TXT,A0
    BRA        FINISH_FOUR1110

HNDL_RTS:
    LEA        RTS_TXT,A0
    BRA        FINISH_FOUR1110
    
FINISH_FOUR1110:
    JSR        PUSHBUFFER
    RTS

**************************************************
* Instructions With 1111 as Second Set of 4 Bits *
**************************************************
FOUR1111:
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
