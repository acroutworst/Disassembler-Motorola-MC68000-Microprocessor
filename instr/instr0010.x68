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
    
    LEA         BUFFER,A1               ; load the buffer
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
    
    JSR         PUSHBUFFER              ; push the text to the buffer
    JSR         UPDATE_OPCODE           ; update the opcode
    
    * prepare the size information for getting operation size
    ADDQ.B      #2,D7                   ; type 2 size field
    ADDQ.W      #1,D7                   ; 2 bit size field
    ROR.W       #1,D7                   ; rotate to top
    ADD.W       #13,D7                  ; 13 starting index
    ROR.W       #4,D7                   ; rotate to top
    SWAP        D7                      ; swap size to higher order word
    
    MOVE.W      (A6),D7                 ; move instruction into lower order word
    JSR         GET_OP_SIZE             ; get the size
    
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
