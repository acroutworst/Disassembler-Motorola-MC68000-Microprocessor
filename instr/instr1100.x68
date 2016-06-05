************************************
* Instructions Beginning With 1100 *
* ** AND (B, W, L) - done          *
* ** MULU - done                   *
* ** MULS - done                   *
*                                  *
* This subroutine is done!         *
************************************
INSTR1100:
    MOVEM.L         A0-A5/D0-D7,-(SP)       ; move registers to stack
    CLR.L           D7                      ; clear size register
    * get bits 6-8
    MOVE.B          #6,D4                   ; choose bitmasking routine
    MOVE.W          (A6),D5                 ; load instruction
    JSR             BITMASKER               ; mask the bits
    
    * check for MULU
    CMP.B           #3,D5                   ; 3 for MULU
    BEQ             HNDL_MULU
    
    * check for MULS
    CMP.B           #7,D5                   ; 7 for MULS
    BEQ             HNDL_MULS
    
    * everything else is AND (functionally)
    BRA             HNDL_AND
    
HNDL_MULU:
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A0
    MOVE.B      #3,(A0)
    
    LEA         EA_DST_TYPE,A5
    MOVE.B      #5,(A5)

    LEA             MULU_TXT,A0             ; load the text
    BRA             BUFFER_1100             ; push to the buffer

HNDL_MULS:
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A0
    MOVE.B      #3,(A0)

    LEA         EA_DST_TYPE,A5
    MOVE.B      #5,(A5)

    LEA             MULS_TXT,A0             ; load MULS text
    BRA             BUFFER_1100             ; push to the buffer

HNDL_AND:
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A5
    MOVE.B      #0,(A5)
    
    LEA         EA_DST_TYPE,A5
    MOVE.B      #0,(A5)

    LEA             AND_TXT,A0              ; load AND text
    
    * setup size for AND
    ROR.W           #2,D7                   ; type 0 size field
    ADDQ.B          #1,D7                   ; 2 bit size field
    ROR.W           #1,D7                   ; rotate to top
    ADDQ.B          #7,D7                   ; start index = 7
    ROR.W           #4,D7                   ; rotate to top
    ADDQ.B          #1,D7                   ; indicate size needed
    ROR.W           #1,D7                   ; rotate to top
    
    SWAP            D7                      ; swap size info to higher order word
    MOVE.W          (A6),D5                 ; move instruction in
    
BUFFER_1100:
    MOVE.B          #1,D0                   ; choose the buffer to push to
    JSR             PUSHBUFFER              ; push loaded text to buffer
    JSR             UPDATE_OPCODE           ; update the opcode
    
    CMP.B           #0,D7                   ; check for size information
    BEQ             FINISH_1100             ; no size info, done here
    JSR             GET_OP_SIZE             ; get op size 
    BRA             FINISH_1100             ; done here
    
FINISH_1100:
    MOVEM.L         (SP)+,A0-A5/D0-D7       ; move registers back from stack
    RTS









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
