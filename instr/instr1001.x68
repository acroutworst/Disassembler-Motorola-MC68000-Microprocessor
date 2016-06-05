************************************
* Instructions Beginning With 1001 *
* ** SUB - done                    *
*                                  *
* NOTE: This subroutine ignores    *
*       other possible opcodes.    *
* This subroutine is done!         *
************************************
INSTR1001:
    MOVEM.L     A0-A5/D0-D7,-(SP)   ; move registers to stack
    
    MOVE.W      CURRENT_INSTR,D5
    MOVE.B      #7,D4
    JSR         BITMASKER
    
    CMP.B       #3,D5
    BEQ         HNDL_SUBA
    
    LEA         SUB_TXT,A0          ; load sub text
    MOVE.B      #1,D0               ; choose buffer
    
    * prep size info
    CLR.L       D7                  ; clear size register
    ROR.W       #2,D7               ; type 0 size field
    ADDQ.B      #1,D7               ; 2 bit size field
    ROR.W       #1,D7               ; rotate to top
    ADDQ.B      #7,D7               ; start index = 7
    ROR.W       #4,D7               ; rotate to top
    ADDQ.B      #1,D7               ; indicate size needed
    ROR.W       #1,D7               ; rotate to top
    
    SWAP        D7                  ; swap size info to higher order word
    
    MOVE.W      CURRENT_INSTR,D7             ; move instruction in
    BRA         DONE_1001
    
HNDL_SUBA:
    LEA         SUBA_TXT,A0
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    
    * prep size info
    CLR.L       D7
    MOVE.B      #1,D7
    ROR.W       #2,D7
    ADDQ.B      #1,D7
    ROR.W       #1,D7
    ADDQ.B      #8,D7
    ROR.W       #4,D7
    ADDQ.B      #1,D7
    ROR.W       #1,D7
    
    SWAP        D7
    
    MOVE.W      CURRENT_INSTR,D7
    BRA         DONE_1001    

DONE_1001:    
    JSR         PUSHBUFFER          ; push text to buffer
    JSR         UPDATE_OPCODE       ; update opcode
    JSR         GET_OP_SIZE         ; get op size
    
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)
    
    LEA         EA_SRC_TYPE,A5
    MOVE.B      #0,(A5)
    
    LEA         EA_DST_TYPE,A5
    MOVE.B      #0,(A5)


FINISH_1001:
    MOVEM.L     (SP)+,A0-A5/D0-D7   ; move registers back from stack
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
