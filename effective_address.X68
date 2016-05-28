*-----------------------------------------------------------
* Title      : Effective Address Decoder
* Written by : Adam Croutworst
* Date       : 05/14/16
* Description:
*-----------------------------------------------------------
EADECODER:

    MOVEM.L     A0-A5/D0-D7,-(SP)   ; move registers to stack to be moved
    LEA         ERROR,A1            ; load error status from Opcode
    CMP.B       #0,(A1)             ; compare error to 0 to check for ok status
    BNE         FINISH_EADECODER
    
    LEA         EA_NEEDED,A1        ; check ea_needed status (1 for needed, 0 for not)
    CMP.B       #0,(A1)
    BEQ         FINISH_EADECODER
    
    MOVEA.L     A6,A0
    MOVE.W      (A0),D5             ; move instruction in to D5
    
    MOVE.B      #5,D4               ; get mode from second to last 3 bits
    JSR         BITMASKER
    MULU        #8,D5               ; offset for jump table
    
    LEA         EA_TABLE,A0         ; load the effective address jump table
    JSR         0(A0,D5)            ; call jump table
    BRA         FINISH_EADECODER    ; branch to finish when done
    

* push ascii format ea to display
    
    
FINISH_EADECODER:
    MOVEM.L     (SP)+,A0-A5/D0-D7   ; move registers back from stack
    RTS                             ; exit subroutine

    INCLUDE 'eamodes/ea_table.x68'




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
