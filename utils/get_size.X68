*-----------------------------------------------------------
* Title      : Get Size
* Written by : Geoff Friesen
* Date       : 2016/05/09
* Description: Subroutine to get the size of an instruction
*              code. Called by opcodes
*-----------------------------------------------------------
GET_OP_SIZE:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    
    
    
    
    
    
GET_SIZEDONE:
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
