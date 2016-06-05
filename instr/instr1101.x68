************************************
* Instructions Beginning With 1101 *
* ** ADD (B, W, L) - done          *
* ** ADDA (W, L) - done            *
*                                  *
* This subroutine is done!         *
************************************
INSTR1101:
    MOVEM.L         A0-A5/D0-D7,-(SP)       ; move registers to stack
    CLR.L           D7                      ; clear size register
    
    * get bits 6 and 7
    MOVE.B          #7,D4                   ; choose bitmask routine
    MOVE.W          (A6),D5                 ; load instruction
    JSR             BITMASKER
    
    CMP.B           #3,D5                   ; check for ADDA
    BEQ             HNDL_ADDA
    
    BNE             HNDL_ADD

HNDL_ADD:
    LEA             ADD_TXT,A0              ; load add text
    CLR.L           D7                      ; clear size register
    
    * setup size info
    ROR.W           #2,D7                   ; type 0 size field
    ADDQ.B          #1,D7                   ; 2 bit size field
    ROR.W           #1,D7                   ; rotate to top
    ADDQ.B          #7,D7                   ; start index = 7
    ROR.W           #4,D7                   ; rotate to top
    ADDQ.B          #1,D7                   ; indicate size needed
    ROR.W           #1,D7                   ; rotate to top
    
    SWAP            D7                      ; swap size info to higher order word
    
    MOVE.W          (A6),D7                 ; move instruction in
    
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A5
    MOVE.B      #0,(A5)
    
    LEA         EA_DST_TYPE,A5
    MOVE.B      #0,(A5)

      
    BRA             BUFFER_1101             ; branch to buffer handling
    
HNDL_ADDA:        
    LEA             ADDA_TXT,A0
    
    * setup size information
    ADDQ.B          #1,D7                   ; type 1 size field
    ROR.W           #2,D7                   ; rotate to top
    ROR.W           #1,D7                   ; rotate to top
    ADDQ.B          #8,D7                   ; start index = 8
    ROR.W           #4,D7                   ; rotate to top
    ADDQ.B          #1,D7                   ; indicate size needed
    ROR.W           #1,D7                   ; rotate to top
    
    SWAP            D7                      ; swap size info to higher order word
    MOVE.W          (A6),D7                 ; move instruction in
    
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A5
    MOVE.B      #0,(A5)
    
    LEA         EA_DST_TYPE,A5
    MOVE.B      #0,(A5)

    BRA             BUFFER_1101
    
BUFFER_1101:
    MOVE.B          #1,D0                   ; choose the buffer to push to
    JSR             PUSHBUFFER              ; push loaded text to buffer
    JSR             UPDATE_OPCODE           ; update opcode
    JSR             GET_OP_SIZE             ; get operation size
    
    BRA             FINISH_1101

    
FINISH_1101:

    LEA             EA_SRC_TYPE,A0
    MOVE.B          #0,(A0)
    MOVEM.L         (SP)+,A0-A5/D0-D7       ; move registers back from stack
    RTS









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
