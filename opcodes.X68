*-----------------------------------------------------------
* Title      : Opcode Decoder
* Written by : Geoff Friesen
* Date       :
* Description:
*-----------------------------------------------------------
DECODER:


    MOVEM.L     A0-A5/D0-D7,-(SP)       ; move registers to stack to be moved
                                        ; back upon returning from subroutine
    LEA         ERROR,A1                ; load the error status
    CMP.B       #0,(A1)                 ; check for ok
    BNE         FINISH                  ; exit on not okay

    LEA         BUFFER_POS,A1
    MOVE.W      #0,(A1)
    * get first 4 bits at address in A6
    MOVEA.L     A6,A0                   ; move starting address to A0 to manip
    MOVE.W      (A0),D5                 ; move data at A0 to D5 to manip

    MOVE.B      #0,D4                   ; choose the subroutine to mask (first 4)
    JSR         BITMASKER
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
    
* pushes the opcode text (null terminated)
* located at A0 to the opcode var
UPDATE_OPCODE:
    LEA     OPCODE,A1
    LEA     BUFFER_POS,A2
    SUBA    (A2),A0

UPD_OPCODE_LOOP:
    MOVE.B  (A0)+,(A1)+
    CMP.B   #0,(A0)
    BEQ     UPD_OPCODE_DONE
    BRA     UPD_OPCODE_LOOP

UPD_OPCODE_DONE:
    RTS

* pushes the size text (B, W, L) located
* at A0 to the size var
UPDATE_SIZE:
    LEA     SIZE,A1
    MOVE.B  -(A0),(A1)
    RTS

FINISH:
    MOVEM.L     (SP)+,A0-A5/D0-D7       ; move registers back from stack
    RTS                                 ; exit subroutine


    INCLUDE     'instr/instr0000.x68'
    INCLUDE     'instr/instr0001.x68'
    INCLUDE     'instr/instr0010.x68'
    INCLUDE     'instr/instr0011.x68'
    INCLUDE     'instr/instr0100.x68'
    INCLUDE     'instr/instr0101.x68'
    INCLUDE     'instr/instr0110.x68'
    INCLUDE     'instr/instr0111.x68'
    INCLUDE     'instr/instr1000.x68'
    INCLUDE     'instr/instr1001.x68'
    INCLUDE     'instr/instr1010.x68'
    INCLUDE     'instr/instr1011.x68'
    INCLUDE     'instr/instr1100.x68'
    INCLUDE     'instr/instr1101.x68'
    INCLUDE     'instr/instr1110.x68'
    INCLUDE     'instr/instr1111.x68'







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
