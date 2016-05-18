************************************
* Instructions Beginning With 0101 *
* ** ADDQ (B, W, L) - done         *
* ** SUBQ (B, W, L) - done         *
*                                  *
* This subroutine is done!         *
************************************
INSTR0101:
    MOVEM.L     A0-A5/D0-D7,-(SP)   ; move registers to stack
    
    MOVE.W      (A6),D5             ; move instruction in to manip
    MOVE.B      #7,D4               ; choose bitmask routine (bits 7 and 6)
    JSR         BITMASKER
    
    * check for Scc and DBcc
    CMP.B       #3,D4               ; comparing to bits 7 and 6 of Scc
                                    ; and DBcc
    BEQ         NO_OP0101           ; branch if Scc or DBcc found
    
    * figure out if addq or subq
    MOVE.W      (A6),D5
    AND.W       #$0100,D5           ; mask for bit 8
    LSR.W       #8,D5               ; shift to the end
    CMP.B       #1,D5
    BEQ         HNDL_SUBQ
    
    BRA         HNDL_ADDQ
    
HNDL_ADDQ:
    LEA         ADDQ_TXT,A0
    BRA         FINISH_0101
    
HNDL_SUBQ:
    LEA         SUBQ_TXT,A0
    BRA         FINISH_0101
    
PREP_SIZE_0101:
    CLR.L       D7                  ; clear d7 for manip
    ROR.W       #2,D7               ; type 0 size field
    ADDQ.B      #1,D7               ; 2 bit size field
    ROR.W       #1,D7               ; rotate to top
    ADDQ.B      #7,D7               ; start index = 7
    ROR.W       #4,D7               ; rotate to top
    ADDQ.B      #1,D7               ; indicate size needed
    ROR.W       #1,D7               ; rotate to top
    
    SWAP        D7                  ; swap size info to higher order word
    MOVE.W      (A6),D7             ; move instruction in
    
    RTS
    
NO_OP0101:
    LEA         ERROR,A0            ; load error flag
    MOVE.B      #1,(A0)             ; switch error flag
    LEA         ERR_TXT,A0          ; load error text
          
    BRA         FINISH_0101
    
FINISH_0101:
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE

    BSR         PREP_SIZE_0101
    JSR         GET_OP_SIZE
 
    MOVEM.L     (SP)+,A0-A5/D0-D7

    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
