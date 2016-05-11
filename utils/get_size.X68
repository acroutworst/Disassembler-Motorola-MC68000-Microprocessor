*-----------------------------------------------------------
* Title      : Get Size
* Written by : Geoff Friesen
* Date       : 2016/05/09
* Description: Subroutine to get the size of an instruction
*              code. Called by opcodes.
*              Implementation:
*              ** Location of the size in the instruction is
*              ** contained in the higher order word of D7
*              ** while the actual instruction word is in
*              ** the lower order word of D7.
*              ** size location
*                 ** Bit 15-12: start index
*                 ** Bit 11: number of bits
*-----------------------------------------------------------
GET_OP_SIZE:
    MOVEM.L     A0-A5/D0-D6,-(SP)       ; move the registers to stack

    SWAP        D7                      ; swap the high and low words
    ROL.W       #4,D7                   ; rotate the first 4 bits to the bottom
    MOVE.B      D7,D0                   ; store start index in D0
    LSR.B       #4,D7                   ; consume the start index
    ROL.W       #2,D7                   ; rotate the number of bits in the size
                                        ; to the bottom
    MOVE.B      D7,D1                   ; store the number of bits in D1
    MULU        #8,D1                   ; offset for SIZE_TABLE
    SWAP        D7                      ; swap the instruction back to lower word
    
    LEA         SIZE_TABLE,A3           ; load the size table
    
    JSR         0(A3,D1)                ; jump into SIZE_TABLE
    BRA         GET_SIZEDONE

    
    
SIZE_TABLE
    JSR         SIZE0
    RTS
    JSR         SIZE1
    RTS
    JSR         SIZE2
    RTS

**************************************
* SIZE0                              *
* ** called when number of size bits *
* ** is 0                            *
**************************************
SIZE0:
    * TODO
    RTS

**************************************
* SIZE1                              *
* ** called when number of size bits *
* ** is 1                            *
**************************************
SIZE1:
    ADDQ        #1,D2           ; 1 bit in size field
    JSR         SHIFT_AND_MASK  ; shift and mask the instruction
    CMP.B       #0,D7           ; check for zero
    BEQ         WORD_SIZE       ; zero - word size
    BRA         LONG_SIZE       ; one - long size

**************************************
* SIZE2                              *
* ** called when number of size bits *
* ** is 2                            *
**************************************
SIZE2:
    ADDQ        #3,D2           ; 2 bits in size field
    JSR         SHIFT_AND_MASK
    CMP.B       #7,D0
    BEQ         COMMON_SIZE
    CMP.B       #1,D7
    BEQ         BYTE_SIZE
    CMP.B       #3,D7
    BEQ         WORD_SIZE
    CMP.B       #2,D7
    BEQ         LONG_SIZE
    
    BRA         SIZE_ERROR
    
    
    
*******************************************
* SHIFT_AND_MASK                          *
* ** quick subroutine to shift and mask   *
* ** the instruction based on start index *
* ** and number of bits                   *
*******************************************
SHIFT_AND_MASK:
    LSL.W       D0,D2           ; shift the mask bit left start index bits
    AND.W       D2,D7           ; mask the instruction
    LSR.W       D0,D7           ; shift the size field to the right
    RTS

COMMON_SIZE:
    CMP.B       #0,D7
    BEQ         BYTE_SIZE
    CMP.B       #2,D7
    BEQ         LONG_SIZE
    CMP.B       #3,D7
    BEQ         WORD_SIZE
    
    BRA         SIZE_ERROR
    
PUSH_SIZE:    
    JSR         PUSHBUFFER
    RTS
    

BYTE_SIZE:
    LEA         B,A0
    JSR         PUSH_SIZE
    RTS
    
WORD_SIZE:
    LEA         W,A0
    JSR         PUSH_SIZE
    RTS
    
LONG_SIZE:
    LEA         L,A0
    JSR         PUSH_SIZE
    RTS
    
SIZE_ERROR:
    LEA         ERROR,A3
    ADDQ        #1,(A3)
    RTS
    


GET_SIZEDONE:
    MOVEM.L     (SP)+,A0-A5/D0-D6
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
