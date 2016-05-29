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
    
    MOVE.W      (A6),D7             ; move instruction in
    
    JSR         PUSHBUFFER          ; push text to buffer
    JSR         UPDATE_OPCODE       ; update opcode
    JSR         GET_OP_SIZE         ; get op size
    
    * update ea info
    LEA         EA_NEEDED,A5
    MOVE.B      #1,(A5)
    
    LEA         NUM_OPERANDS,A5
    MOVE.B      #2,(A5)

    
    MOVEM.L     (SP)+,A0-A5/D0-D7   ; move registers back from stack
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
