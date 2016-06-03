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
*                 ** Bit 15: size needed indicator (1 for needed)
*                 ** Bit 14-11: start index of size
*                 ** Bit 10: number of bits (0 for 1, 1 for 2)
*                 ** Bit 9-8: size type (0 for common, 1 for 1 bit, 2 for MOVE)
*-----------------------------------------------------------
GET_OP_SIZE:
    MOVEM.L     A0-A5/D0-D6,-(SP)       ; move the registers to stack
    MOVE.B      #1,D0                   ; choose the buffer to use
    
    SWAP        D7                      ; swap the high and low words
    
    ROL.W       #1,D7                   ; rotate needed bit to bottom
    CLR.L       D1
    MOVE.B      D7,D1                   ; store needed in D1
    LSR.B       #1,D7                   ; consume needed bit
    
    CMP.B       #0,D1                   ; check if size is needed
    BEQ         GET_SIZEDONE            ; don't need size, exit
    
    * continue getting size info
    ROL.W       #4,D7                   ; rotate start index to the bottom
    CLR.L       D2
    MOVE.B      D7,D2                   ; store start index in D2
    LSR.B       #4,D7                   ; consume the start index
    
    ROL.W       #1,D7                   ; rotate the number of bits in the size
                                        ; to the bottom
    CLR.L       D3
    MOVE.B      D7,D3                   ; store the number of bits in D3
    LSR.B       #1,D7                   ; consume the size
    
    ROL.W       #2,D7                   ; rotate the type info to the bottom
    CLR.L       D4
    MOVE.B      D7,D4                   ; store type info in D4
    

    MULU        #8,D4                   ; offset for SIZE_TABLE
    SWAP        D7                      ; swap the instruction back to lower word
    
    CLR.L       D5
    
    LEA         SIZE_TABLE,A3           ; load the size table
    
    JSR         0(A3,D4)                ; jump into SIZE_TABLE
    BRA         GET_SIZEDONE

SIZE_TABLE
    JSR         TYPE0
    RTS
    JSR         TYPE1
    RTS
    JSR         TYPE2
    RTS

**************************************
* TYPE0                              *
* ** called for size type 0          *
* ** B: 00                           *
* ** W: 01                           *
* ** L: 10                           *
**************************************
TYPE0:
    ADDQ        #3,D5
    JSR         SHIFT_AND_MASK
    
    CMP.B       #0,D7
    BEQ         BYTE_SIZE
    CMP.B       #2,D7
    BEQ         LONG_SIZE
    CMP.B       #1,D7
    BEQ         WORD_SIZE
    
    BRA         SIZE_ERROR

**************************************
* TYPE1                              *
* ** called for size type 1          *
* ** W: 0                            *
* ** L: 1                            *
**************************************
TYPE1:
    ADDQ        #1,D5
    JSR         SHIFT_AND_MASK
    
    CMP.B       #0,D7
    BEQ         WORD_SIZE
    BNE         LONG_SIZE
    
**************************************
* TYPE2                              *
* ** called for size type 2          *
* ** B: 01                           *
* ** W: 11                           *
* ** L: 10                           *
**************************************
TYPE2:
    ADDQ        #3,D5
    JSR         SHIFT_AND_MASK
    
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
    SUB.W       D3,D2           ; if 2 bit size, only need to shift index - 1
    
    LSL.W       D2,D5           ; shift the mask bit left start index bits
    AND.W       D5,D7           ; mask the instruction
    LSR.W       D2,D7           ; shift the size field to the right
    RTS

***************************************
* PUSH_SIZE                           *
* ** pushes the size to opcode buffer *
* ** and size variable                *
***************************************
PUSH_SIZE:      
    JSR         PUSHBUFFER      ; push the loaded size to opcode buffer
    JSR         UPDATE_SIZE     ; update size variable
    

    

    RTS
***************************************
* PUSH_PERIOD                         *
* ** loads a period to be pushed to   *
* ** opcode buffer                    *
***************************************    
PUSH_PERIOD
    LEA         PERIOD,A0
    JSR         PUSHBUFFER
    RTS

***************************************
* BYTE_SIZE                           *
* ** pushes a period and loads a B    *
* ** to be pushed                     *
***************************************
BYTE_SIZE:
    JSR         PUSH_PERIOD
    LEA         B,A0
    JSR         PUSH_SIZE
    RTS
    
***************************************
* WORD_SIZE                           *
* ** pushes a period and loads W      *
* ** to be pushed                     *
***************************************
WORD_SIZE:
    JSR         PUSH_PERIOD
    LEA         W,A0
    JSR         PUSH_SIZE
    RTS
    
***************************************
* LONG_SIZE                           *
* ** pushes a period and loads L      *
* ** to be pushed                     *
***************************************
LONG_SIZE:
    JSR         PUSH_PERIOD
    LEA         L,A0
    JSR         PUSH_SIZE
    RTS

***************************************
* SIZE_ERROR                          *
* ** no size found, set error bit     *
***************************************
SIZE_ERROR:
    LEA         ERROR,A3
    ADDQ        #1,(A3)
    JSR         NO_OPCODE
    BRA         GET_SIZEDONE
    
***************************************
* PAD_SPACES                          *
* ** pads opcode buffer with sapces   *
* ** no longer used                   *
***************************************
PAD_SPACES:
    LEA         SPACE,A0
    JSR         PUSHBUFFER
    LEA         OP_BUFFER_POS,A1
    MOVE.W      (A1),D6
    CMP.B       #7,D6
    BLE         PAD_SPACES
    RTS

GET_SIZEDONE:
    LEA         OPCODE_BUFFER,A0        ; load opcode buffer
    LEA         OP_BUFFER_POS,A1
    ADDA        (A1),A0                 ; update position
    MOVE.B      #$00,(A0)               ; push null terminate
    MOVEM.L     (SP)+,A0-A5/D0-D6       ; move registers back from stack
    RTS








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
