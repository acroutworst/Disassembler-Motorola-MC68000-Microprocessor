************************************
* Instructions Beginning With 0100 *
* ** LEA - done                    *
* ** CLR (B, W, L)                 *
* ** MOVEM                         *
* ** NOP - done                    *
* ** RTS - done                    *
* ** JSR - done                    *
************************************
INSTR0100:
    MOVEM.L A0-A5/D0-D7,-(SP)
    
    * check for LEA
    MOVE.W  (A6),D5         ; move the instruction in
    MOVE.B  #6,D4           ; choose bitmask routine
    JSR     BITMASKER
    
    CMP.B   #7,D5           ; compare to LEA
    BNE     FOUR_SETUP      ; not LEA
    
    * handling LEA
    LEA     LEA_TXT,A0      ; load LEA text
    MOVE.B  #1,D0           ; choose the buffer to push to
    JSR     PUSHBUFFER      ; push lea text to buffer
    JSR     UPDATE_OPCODE   ; update the opcode with lea
    
    MOVEM.L (SP)+,A0-A5/D0-D7
    RTS
    
****************************************
* Setup for masking off the second set *
* of 4 bits.                           *
****************************************
FOUR_SETUP:
    MOVE.B  #1,D4             ; choose the bitmasking routine
    MOVE.W  (A6),D5           ; move the instruction in
    JSR     BITMASKER         ; mask the second set of 4 bits
    
    LEA     FOUR_TABLE,A0     ; load the table
    MULU    #8,D5             ; get the offset
    JSR     0(A0,D5)          ; jump into the table
    RTS

*******************************************
* Jump table for the second set of 4 bits *
*******************************************
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
* Optional                                       *
* ** MOVE from SR                                *
* ** NEGX                                        *
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
* ** CLR                                         *
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
* Optional                                       *
* ** MOVE to CCR                                 *
* ** NEG                                         *
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
* Optional                                       *
* ** NOT                                         *
* ** MOVE to SR                                  *
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
* ** MOVEM (register to memory)(W, L)            *
**************************************************
* Optional                                       *
* ** EXT                                         *
* ** SWAP                                        *
* ** NBCD                                        *
* ** PEA                                         *
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
* Optional                                       *
* ** ILLEGAL                                     *
* ** TAS                                         *
* ** TST                                         *
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
* ** MOVEM (memory to register)(W, L)            *
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
* ** NOP                                         *
* ** RTS                                         *
* ** JSR                                         *
**************************************************
* Optional                                       *
* ** TRAPV                                       *
* ** STOP                                        *
* ** RESET                                       *
* ** JMP                                         *
* ** LINK                                        *
* ** UNLK                                        *
* ** MOVE USP                                    *
* ** RTE                                         *
* ** RTR                                         *
**************************************************
FOUR1110:
   * mask for last 8 bits to compare
   MOVE.W      (A6),D5              ; move instruction in
   AND.W       #$00FF,D5            ; mask for last 8
   
   * check for NOP
   CMP.B       #$71,D5              ; cmp to NOP last 8
   BEQ         HNDL_NOP             ; handle NOP
   
   * check for RTS
   CMP.B       #$75,D5              ; cmp to RTS last 8
   BEQ         HNDL_RTS             ; handle RTS
   
   * check for JSR
   MOVE.W      (A6),D5              ; move instruction in
   AND.W       #$00C0,D5            ; mask for bits 6 and 7
   LSR.W       #6,D5                ; shift to the right
   CMP.B       #$2,D5               ; compare bits to bits from JSR
   BEQ         HNDL_JSR             ; handle JSR
   
   JSR         NO_OPCODE            ; no opcode found
   BRA         FINISH_FOUR1110

HNDL_NOP:
    LEA        NOP_TXT,A0
    BRA        FINISH_FOUR1110

HNDL_RTS:
    LEA        RTS_TXT,A0
    BRA        FINISH_FOUR1110
    
HNDL_JSR:
    LEA        JSR_TXT,A0
    BRA        FINISH_FOUR1110
    
FINISH_FOUR1110:
    MOVE.B     #1,D0
    JSR        PUSHBUFFER
    JSR        UPDATE_OPCODE
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
