*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
DECODER:


    MOVEM.L     A0-A5/D0-D7,-(SP)       ; move registers to stack to be moved
                                        ; back upon returning from subroutine
                                        
    * get first 4 bits at address in A6
    MOVEA.L     A6,A0                   ; move starting address to A0 to manip
    MOVE.W      (A0),D5                 ; move data at A0 to D5 to manip
    
    LEA         MASK_TABLE,A1           ; load the masking jump table
    MOVE.B      #0,D0                   ; choose the subroutine to mask (first 4)
    JSR         0(A1,D0)                ; call the jump table
    MULU        #8,D5                   ; multiply the results by 8 for instruction jump table address
    LEA         INST_TABLE,A0           ; load the instruction jump table
    JSR         0(A0,D5)                ; call the instruction jump table
    BRA         FINISH                  ; go to the end
    
    
***********************************
* Jump Table for the First 4 Bits *
***********************************
INST_TABLE:
    JSR     INSTR0000
    RTS
    JSR     INSTR0001
    RTS
    JSR     INSTR0010
    RTS
    JSR     INSTR0011
    RTS
    JSR     INSTR0100
    RTS
    JSR     INSTR0101
    RTS
    JSR     INSTR0110
    RTS
    JSR     INSTR0111
    RTS
    JSR     INSTR1000
    RTS
    JSR     INSTR1001
    RTS
    JSR     INSTR1010
    RTS
    JSR     INSTR1011
    RTS
    JSR     INSTR1100
    RTS
    JSR     INSTR1101
    RTS
    JSR     INSTR1110
    RTS
    
    
************************************
* Instructions Beginning With 0000 *
* ** ADDI                          *    
************************************
INSTR0000:
    LEA         BUFFER,A1               ; load the buffer to add to it
    MOVE.B      ADDI_TXT,BUFFER         ; 
    * TODO - some stuff for addi
    RTS
    
    
************************************
* Instructions Beginning With 0001 *
* ** MOVE.B                        *
************************************
INSTR0001:

    * TODO - some stuff from MOVE.B
    RTS

************************************
* Instructions Beginning With 0010 *
* ** MOVE.L                        *
* ** MOVEA.L                       *
************************************
INSTR0010:
    * TODO - stuff for opcodes
    RTS
    
************************************
* Instructions Beginning With 0011 *
* ** MOVE.W                        *
* ** MOVEA.W                       *
************************************
INSTR0011:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 0100 *
* ** LEA                           *
* ** CLR (B, W, L)                 *
* ** MOVEM                         *
* ** NOP                           *
* ** RTS                           *
* ** JSR                           *
************************************
INSTR0100:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 0101 *
* ** ADDQ (B, W, L)                *
************************************
INSTR0101:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 0110 *
* ** Bcc                           *
************************************
INSTR0110:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 0111 *
* ** MOVEQ                         *
************************************
INSTR0111:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 1000 *
* ** DIVU                          *
* ** OR                            *
************************************
INSTR1000:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 1001 *
* ** SUB                           *
************************************
INSTR1001:
    * TODO
    RTS

************************************
* Instructions Beginning With 1010 *
************************************    
INSTR1010:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 1011 *
* ** CMP                           *
************************************
INSTR1011:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 1100 *
* ** AND (B, W, L)                 *
************************************
INSTR1100:
    * TODO
    RTS
    
************************************
* Instructions Beginning With 1101 *
* ** ADD (B, W, L)                 *
* ** ADDA (W, L)                   *
************************************
INSTR1101:
    * TODO
    RTS
    
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
    * TODO
    RTS
    
    
        
    
    
FINISH:   
    MOVEM.L     (SP)+,A0-A5/D0-D7       ; move registers back from stack
    RTS                                 ; exit subroutine
    
    










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
