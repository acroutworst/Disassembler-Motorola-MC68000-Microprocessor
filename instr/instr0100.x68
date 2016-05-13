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
    MOVEM.L A0-A5/D0-D7,-(SP)       ; move registers to the stack
    * check for LEA
    MOVE.W  (A6),D5                 ; move the current instruction to d5
    MOVE.B  #6,D4                   ; choose bitmask routine
    JSR     BITMASKER               ; jump to the bitmasker
    
    CMP.B   #7,D5                   ; compare the bits to %111
    BNE     FOUR_SETUP              ; not LEA, go to jump table
    
    LEA     LEA_TXT,A0              ; is LEA, load the text
    JSR     PUSHBUFFER              ; push lea text to buffer
    JSR     UPDATE_OPCODE           ; update the opcode variable
    BRA     FOUR_DONE               ; all done

FOUR_SETUP:
    MOVE.B  #1,D4                   ; choose the bitmask routine (second 4)
    MOVE.W  (A6),D5                 ; move the instruction into d5
    JSR     BITMASKER               ; mask the second set of 4 bits
    
    LEA     FOUR_TABLE,A0           ; load the jump table
    MULU    #8,D5                   ; get the offset
    JSR     0(A0,D5)                ; jump into the table
    BRA     FOUR_DONE               ; all done here

*********************************
* Jump Table for the second set of 4 bits *
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
* ** CLR - done                                  *
**************************************************
FOUR0010:
    LEA         CLR_TXT,A0          ; load the CLR text
    JSR         PUSHBUFFER          ; push to buffer
    JSR         UPDATE_OPCODE       ; update the opcode
    
    * prep for getting size
    * size lives at [7] and is 2 bits
    MOVE.B      #1,D7               ; move in size bit
    ROR.W       #1,D7               ; rotate to the top
    MOVE.B      #7,D7               ; move in starting index
    ROR.W       #4,D7               ; rotate to the top
    
    SWAP        D7                  ; swap size word to the higher order
    MOVE.W      (A6),D7             ; move the instruction word in
            
    JSR         GET_OP_SIZE         ; get the size
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
* Optional                                       *
* ** SWAP                                        *
* ** EXT                                         *
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
* ** NOP - done                                  *
* ** RTS - done                                  *
* ** JSR - done                                  *
**************************************************
* Optional                                       *
* ** TRAPV                                       *
* ** STOP                                        *
* ** RESET                                       *
* ** JMP - done                                  *
**************************************************
FOUR1110:
   * mask for last 8 bits to compare
   MOVE.W      (A6),D5              ; move the instruction in
   AND.W       #$00FF,D5            ; mask for last 8
   
   * check for NOP
   CMP.B       #$71,D5              ; cmp to NOP
   BEQ         HNDL_NOP             ; handle NOP
   
   * check for RTS
   CMP.B       #$75,D5              ; cmp to RTS
   BEQ         HNDL_RTS             ; handle RTS
   
   * check for JSR
   MOVE.W      (A6),D5              ; move the instruction in
   AND.W       #$00C0,D5            ; mask for bits 6 and 7
   LSR.W       #6,D5                ; shift them to the right end
   CMP.B       #$2,D5               ; cmp to JSR
   BEQ         HNDL_JSR             ; handle JSR
   
   CMP.B       #$3,D5               ; cmp to JMP
   BEQ         HNDL_JMP             ; handle JMP
   
   JSR         NO_OPCODE            ; no opcode found
   BRA         FINISH_FOUR1110      ; done here

HNDL_NOP:
    LEA        NOP_TXT,A0           ; load NOP text
    BRA        FINISH_FOUR1110      ; finish up

HNDL_RTS:
    LEA        RTS_TXT,A0           ; load RTS text
    BRA        FINISH_FOUR1110      ; finish up
    
HNDL_JSR:
    LEA        JSR_TXT,A0           ; load JSR text
    BRA        FINISH_FOUR1110      ; finish up
    
HNDL_JMP:
    LEA        JMP_TXT,A0           ; load JMP text
    BRA        FINISH_FOUR1110      ; finish up
    
FINISH_FOUR1110:
    JSR        PUSHBUFFER           ; push selected text to buffer
    JSR        UPDATE_OPCODE        ; update the opcode
    RTS

**************************************************
* Instructions With 1111 as Second Set of 4 Bits *
**************************************************
FOUR1111:
    RTS

FOUR_DONE:
    MOVEM.L    (SP)+,A0-A5/D0-D7
    RTS    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
