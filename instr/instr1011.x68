************************************
* Instructions Beginning With 1011 *
* ** CMP - done                    *
* ** CMPA - done                   *
*                                  *
* This subroutine is done!         *
************************************
INSTR1011:
    
    MOVEM.L     A0-A5/D0-D7,-(SP)
    CLR.L       D7
    * setup bitmasker
    MOVE.B      #6,D4           ; choose bitmask routine
    MOVE.W      (A6),D5         ; move instruction in
    JSR         BITMASKER
    
    * check for cmp
    CMP.B       #3,D5
    BLT         HNDL_CMP
    
    * check for cmpa
    BEQ         HNDL_CMPA
    
    CMP.B       #7,D5
    BEQ         HNDL_CMPA
    
    JSR         NO_OPCODE
    BRA         FINISH_1011

HNDL_CMP:
    * setup size for CMP
    ROR.W       #2,D7           ; type 0 size field
    ADDQ.B      #1,D7           ; 2 bit size field
    ROR.W       #1,D7           ; rotate to top
    ADDQ.B      #7,D7           ; start index = 7
    ROR.W       #4,D7           ; rotate to top
    ADDQ.B      #1,D7           ; indicate size needed
    ROR.W       #1,D7           ; rotate to top
    
    SWAP        D7              ; swap size info to high order word
    MOVE.W      (A6),D7         ; move instruction in
    LEA         CMP_TXT,A0      ; load cmp text
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)

    BRA         PUSH_1011       ; push to buffer

HNDL_CMPA:
    * setup size for CMPA
    ADDQ.B      #1,D7           ; type 1 size field
    ROR.W       #2,D7           ; rotate to top
    ROR.W       #1,D7           ; 1 bit size field
    ADDQ.B      #8,D7           ; start index = 8
    ROR.W       #4,D7           ; rotate to top
    ADDQ.B      #1,D7           ; indicate size needed
    ROR.W       #1,D7           ; rotate to top
    
    SWAP        D7              ; swap size info to higher order word
    MOVE.W      (A6),D7         ; move instruction in to lower order word
    
    LEA         CMPA_TXT,A0     ; load cmpa text
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)

    BRA         PUSH_1011       ; push to buffer

PUSH_1011:
    MOVE.B      #0,D1
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    CMP.B       #0,D7           ; check if need to get size
    BEQ         FINISH_1011
    JSR         GET_OP_SIZE
    BRA         FINISH_1011

FINISH_1011:
    MOVEM.L     (SP)+,A0-A5/D0-D7    
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
