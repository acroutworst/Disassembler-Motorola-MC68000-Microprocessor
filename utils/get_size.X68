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
*                 ** Bit 15: start index
*                 ** Bit 14: number of bits
*-----------------------------------------------------------
GET_OP_SIZE:
    MOVEM.L     A0-A5/D0-D6,-(SP)       ; move the registers to stack

    SWAP        D7                      ; swap the high and low words
    ROL.W       #1,D7                   ; rotate the first bit to the bottom
    MOVE.B      D7,D0                   ; store start index in D0
    LSR.B       #1,D7                   ; consume the start index
    ROL.W       #1,D7                   ; rotate the number of bits in the size
                                        ; to the bottom
    MOVE.B      D7,D1                   ; store the number of bits in D1











GET_SIZEDONE:
    MOVEM.L     (SP)+,A0-A5/D0-D6
    RTS
