************************************
* Instructions Beginning With 0100 *
* ** LEA - done                    *
* ** CLR (B, W, L) - done          *
* ** MOVEM - done                  *
* ** NOP - done                    *
* ** RTS - done                    *
* ** JSR - done                    *
*                                  *
* This subroutine is done!         *
************************************
INSTR0100:
    MOVEM.L A0-A5/D0-D7,-(SP)
    
    * check for LEA
    MOVE.W  (A6),D5         ; move the instruction in
    MOVE.B  #6,D4           ; choose bitmask routine (8-6)
    JSR     BITMASKER
    
    CMP.B   #7,D5           ; compare to LEA
    BNE     FOUR_SETUP      ; not LEA
    
    * handling LEA
    LEA     LEA_TXT,A0      ; load LEA text
    MOVE.B  #1,D0           ; choose the buffer to push to
    
    JSR     PUSHBUFFER      ; push lea text to buffer
    JSR     UPDATE_OPCODE   ; update the opcode with lea
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #2,(A0)

    LEA         EA_SRC_TYPE,A0
    MOVE.B      #0,(A0)
FINISH_0100:

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
    BRA     FINISH_0100

*******************************************
* Jump table for the second set of 4 bits *
*******************************************
FOUR_TABLE:
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      FOUR0010
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      FOUR1000
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      FOUR1100
   RTS
   JSR      NOOP_0100
   RTS
   JSR      FOUR1110
   RTS
   JSR      NOOP_0100
   RTS
   
NOOP_0100:
    JSR     NO_OPCODE 
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
    LEA         CLR_TXT,A0      ; load clr text
    MOVE.B      #1,D0           ; choose buffer
    JSR         PUSHBUFFER      ; push to buffer
    
    * prep size info
    CLR.L       D7              ; clear for size info
    ROR.W       #2,D7           ; type 2 size field
    ADDQ.B      #1,D7           ; 2 bits in size field
    ROR.W       #1,D7           ; rotate to top
    ADDQ.B      #7,D7           ; start index = 7
    ROR.W       #4,D7           ; rotate to top
    ADDQ.B      #1,D7           ; indicate size needed
    ROR.W       #1,D7           ; rotate to top
    
    SWAP        D7              ; swap size info to higher order word
    
    MOVE.W      (A6),D7         ; move instruction in
    
    JSR         GET_OP_SIZE     ; get size
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #1,(A0)
    
    LEA         EA_DST_TYPE,A0
    MOVE.B      #4,(A0)

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
*                                                *
* NOTE: Ignoring optional opcodes and assuming   *
*       we won't encounter them                  *
**************************************************
* Optional                                       *
* ** EXT                                         *
* ** SWAP                                        *
* ** NBCD                                        *
* ** PEA                                         *
**************************************************
FOUR1000:
    LEA         MOVEM_TXT,A0        ; load movem text
    MOVE.B      #1,D0               ; choose buffer
    JSR         PUSHBUFFER          ; push text to buffer
    
    * setup size info
    CLR.L       D7                  ; clear size register
    ADDQ.B      #1,D7               ; type 1 size field
    ROR.W       #2,D7               ; rotate to top
    ROR.W       #1,D7               ; 1 bit size field
    ADDQ.B      #6,D7               ; start index = 6
    ROR.W       #4,D7               ; rotate to top
    ADDQ.B      #1,D7               ; indicate size needed
    ROR.W       #1,D7               ; rotate to top
    
    SWAP        D7                  ; swap size info to higher order word
    
    MOVE.W      (A6),D7             ; move instruction in
    
    JSR         GET_OP_SIZE         ; get size
    
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #2,(A0)
    
    *TODO - need to determine ea type

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
    BSR         FOUR1000        ; functionally identical
                                ; for opcode decoding
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
    
    
    * update ea info
    LEA        EA_NEEDED,A0
    MOVE.B     #0,(A0)
    
    LEA        NOP_TXT,A0

    BRA        FINISH_FOUR1110
    

HNDL_RTS:
    
    LEA        EA_NEEDED,A0
    MOVE.B     #0,(A0)

    LEA        RTS_TXT,A0

    BRA        FINISH_FOUR1110
    
HNDL_JSR:
    * update ea info
    LEA        EA_NEEDED,A0
    MOVE.B     #1,(A0)
    
    LEA        NUM_OPERANDS,A0
    MOVE.B     #1,(A0)
    
    LEA        EA_DST_TYPE,A0
    MOVE.B     #4,(A0)

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
