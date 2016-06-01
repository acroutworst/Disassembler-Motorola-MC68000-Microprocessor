************************************
* Instructions Beginning With 0010 *
* ** MOVE.L - done                 *
* ** MOVEA.L - done                *
*                                  *
* This subroutine is done!         *
************************************
INSTR0010:
    MOVEM.L     A0-A5/D0-D7,-(SP)       ; registers to stack
    CLR.L       D7
    
    * check for MOVEA    
    MOVE.W      (A6),D5                 ; setup the bitmasker for bits
    MOVE.B      #6,D4                   ; 8 to 6
    JSR         BITMASKER
    
    CMP.B       #1,D5                   ; compare masked bits to 1 (MOVEA)
    BNE         MOVE0010                ; not MOVEA
    LEA         MOVEA_TXT,A0            ; is MOVEA
    BRA         DONE0010
    
MOVE0010:
    LEA         MOVE_TXT,A0             ; load MOVE text
    BRA         DONE0010
    
DONE0010:
    MOVE.B      #1,D0                   ; choose the buffer
    JSR         PUSHBUFFER              ; push the text to the buffer
    JSR         UPDATE_OPCODE           ; update the opcode
    
    * prepare the size information for getting operation size
    ADDQ.B      #2,D7                   ; type 2 size field
    ROR.W       #2,D7                   ; rotate to top
    ADDQ.W      #1,D7                   ; 2 bit size field
    ROR.W       #1,D7                   ; rotate to top
    ADD.W       #13,D7                  ; 13 starting index
    ROR.W       #4,D7                   ; rotate to top
    ADDQ.B      #1,D7                   ; indicate size needed
    ROR.W       #1,D7                   ; rotate to top
    SWAP        D7                      ; swap size to higher order word
    
    MOVE.W      (A6),D7                 ; move instruction into lower order word
    JSR         GET_OP_SIZE             ; get the size
    
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #2,(A0)

    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
