************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
*                                  *
* ** This subroutine is done!      *
************************************
INSTR0001:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    CLR.L       D7
    
    LEA         MOVE_TXT,A0         ; load move text
    LEA         EA_NEEDED,A5
    ADDQ.B      #1,(A5)
    BRA         BUFFER0001          
            
BUFFER0001:
    MOVE.B      #1,D0               ; choose buffer to push to
    JSR         PUSHBUFFER          ; push to buffer
    JSR         UPDATE_OPCODE       ; update opcode
    BRA         PREP_SIZE_0001      ; get the size info ready

PREP_SIZE_0001:        
    ADDQ.B      #2,D7               ; type 2 size field
    ROR.W       #2,D7               ; rotate to top
    ADDQ.B      #1,D7               ; 2 bit size field
    ROR.W       #1,D7               ; rotate to top
    ADD.B       #13,D7              ; start index = 13
    ROR.W       #4,D7               ; rotate to top
    ADDQ.B      #1,D7               ; indicate size needed
    ROR.W       #1,D7               ; rotate to top
    
    SWAP        D7                  ; swap size info to higher order word
    MOVE.W      (A6),D7             ; move instruction in
    JSR         GET_OP_SIZE         ; get op size
        
INSTR0001DONE:
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
