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
    MOVE.L      (A0),D0                 ; move data at A0 to D0 to manip
    AND.L       FIRST4MASK,D0           ; mask all but the first 4 bits
    
    
************************************
* Instructions Beginning with 0000 *
* ** ADDI                          *    
************************************
INSTR0000:
    LEA         BUFFER,A1               ; load the buffer to add to it
    
    
    
    
    
    MOVEM.L     (SP)+,A0-A5/D0-D7       ; move registers back from stack
    RTS                                 ; exit subroutine
    
    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
