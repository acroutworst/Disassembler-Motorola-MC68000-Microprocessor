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
    
    
    
    MOVEM.L     -(SP),A0-A5/D0-D7       ; move registers back from stack
    RTS                                 ; exit subroutine
    
    INCLUDE 'variables.x68'
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
