************************************
* Instructions Beginning With 1110 *
* ** LSL (B, W, L)                 *
* ** LSR (B, W, L)                 *
* ** ASR (B, W, L)                 *
* ** ASL (B, W, L)                 *
* ** ROL (B, W, L)                 *
* ** ROR (B, W, L)                 *
************************************
INSTR1110:
    MOVEM.L         A0-A5/D0-D7,-(SP)
    CLR.L           D7
    
    * get bits 6 and 7
    MOVE.B          #7,D4
    MOVE.W          (A6),D5
    JSR             BITMASKER
    
    CMP.B           #3,D5
    BEQ             MEM_SHIFTS
    BNE             REG_SHIFTS
    
MEM_SHIFTS:
    MOVE.B          #8,D4

    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)

    
    BRA             TABLE_1110_PREP
    
REG_SHIFTS:
    MOVE.B          #9,D4

    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    * prep size information
    MOVE.B          #0,D7           ; size type 0
    ROR.W           #2,D7           ; rotate to the top
    MOVE.B          #1,D7           ; 2 bit size field
    ROR.W           #1,D7           ; rotate to top
    MOVE.B          #7,D7           ; start index = 7
    ROR.W           #4,D7           ; rotate to the top
    MOVE.B          #1,D7           ; indicate size needed
    ROR.W           #1,D7           ; rotate to top
    
    SWAP            D7              ; swap size info to higher order word
    MOVE.W          (A6),D7         ; move instruction in
    
    BRA             TABLE_1110_PREP
    
TABLE_1110_PREP:
    MOVE.W          (A6),D5
    JSR             BITMASKER
    
    JSR             GET_DIR_1110

    MULU            #8,D5
    LEA             TABLE_1110,A0
    JSR             0(A0,D5)
    
    BRA             BUFFER_1110    
    
*************************************
* Jump table for rotation and shift *
* instructions.                     *
*************************************
TABLE_1110:
    JSR             ROT_00
    RTS
    JSR             ROT_01
    RTS
    JSR             ROT_10
    RTS
    JSR             ROT_11
    RTS
    
**********
* ROT_00 *
* ** ASR *
* ** ASL *
**********
ROT_00:
    CMP.B           #1,D6       ; check the direction bit
    BEQ             HNDL_ASL    ; left
    BNE             HNDL_ASR    ; right
    
HNDL_ASL:
    LEA             ASL_TXT,A0
    RTS
    
HNDL_ASR:
    LEA             ASR_TXT,A0
    RTS
    
**********
* ROT_01 *
* ** LSR *
* ** LSL *
**********
ROT_01:
    CMP.B           #1,D6       ; check direction bit
    BEQ             HNDL_LSL    ; left
    BNE             HNDL_LSR    ; right
    
HNDL_LSL:
    LEA             LSL_TXT,A0
    RTS
    
HNDL_LSR:
    LEA             LSR_TXT,A0
    RTS

***********
* ROT_10  *
* ** ROXR *
* ** ROXL *
***********
ROT_10:
    CMP.B           #1,D6       ; check direction bit
    BEQ             HNDL_ROXL   ; left
    BNE             HNDL_ROXR   ; right
    
HNDL_ROXL:
    LEA             ROXL_TXT,A0
    RTS
    
HNDL_ROXR:
    LEA             ROXR_TXT,A0
    RTS

**********
* ROT_11 *
* ** ROR *
* ** ROL *
**********
ROT_11:
    CMP.B           #1,D6       ; check direction bit
    BEQ             HNDL_ROL    ; left
    BNE             HNDL_ROR    ; right
    
HNDL_ROL:
    LEA             ROL_TXT,A0
    RTS

HNDL_ROR:
    LEA             ROR_TXT,A0
    RTS

* little subroutine to get the direction of a shift/rotate
* and put it in D6, 1 for left, 0 for right.
GET_DIR_1110:
    MOVE.W          (A6),D6
    AND.W           #$0100,D6
    LSR.W           #8,D6
    RTS
    
BUFFER_1110:
    MOVE.B          #1,D0
    JSR             PUSHBUFFER
    JSR             UPDATE_OPCODE
    JSR             GET_OP_SIZE
    
    BRA             FINISH_1110
    
FINISH_1110:
    MOVEM.L         (SP)+,A0-A5/D0-D7
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
