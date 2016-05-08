*-----------------------------------------------------------
* Title      : BitMasker
* Written by : Geoff Friesen
* Date       : 2016/05/06
* Description: Subroutine that masks for a certain set of bits
*              based on predefined sets.
*
* Assumptions:
* ** D5 contains data to be masked
* ** D4 contains desired bit masking routine (detailed below)
*-----------------------------------------------------------

BITMASKER:
    MOVEM.L     A0-A6/D0-D3/D6-D7,-(SP)         ; move all registers to
                                                ; stack except D4 & D5
                                                
    LEA         MASK_TABLE,A0                   ; load the jump table
    MULU        #8,D4                           ; get the offset of the table
    JSR         0(A0,D4)                        ; call the jump table
    
    MOVEM.L     (SP)+,A0-A6/D0-D3/D6-D7         ; move the registers back from stack
    RTS                                         ; all done here
    

*******************************
* Jump Table for Masking Bits *
*******************************
* This jump table can be accessed to jump to the appropriate subroutine
* to mask a certain set of bits. Also shifts bits all the way to the right.
*  
* Usage:
* 1. Load the table into an address register
* 2. Move the value to be masked into D5
* 3. Jump to the appropriate subroutine
*   ** JSR  0(<An>,<subroutine # * 8>)
* ** 0 - MASK15TO12 - masks for first 4 bits
* ** 1 - MASK11TO8 - masks for second 4 bits
* ** 2 - MASK7TO4 - masks for third 4 bits
* ** 3 - MASK3TO0 - masks for last 4 bits
* ** 4 - MASK2TO0 - masks for last 3 bits
* ** 5 - MASK5TO3 - masks for second to last 3 bits
* ** 6 - MASK8TO6 - masks for bits 8 to 6
MASK_TABLE:
    JSR     MASK15TO12
    RTS
    JSR     MASK11TO8
    RTS
    JSR     MASK7TO4
    RTS
    JSR     MASK3TO0
    RTS
    JSR     MASK2TO0
    RTS
    JSR     MASK5TO3
    RTS
    JSR     MASK8TO6
    RTS


*-----------------------------------------------------------------------------*
* Masking Subroutines                                                         *
*-----------------------------------------------------------------------------*

**************
* MASK15TO12 *
**************
MASK15TO12:
    AND.W       #FIRST4MASK,D5
    ROL.W       #4,D5
    RTS

*************
* MASK11TO8 *
*************
MASK11TO8:
    AND.W       #SECON4MASK,D5
    ROL.W       #8,D5
    RTS
    
************
* MASK7TO4 *
************
MASK7TO4:
    AND.W       #THIRD4MASK,D5
    LSR.W       #8,D5
    RTS
    
************
* MASK3TO0 *
************
MASK3TO0:
    AND.W       #LAST_4MASK,D5
    RTS
    
************
* MASK2TO0 *
************
MASK2TO0:
    AND.W       #B0TO2MASK,D5
    RTS
    
************
* MASK5TO3 *
************
MASK5TO3:
    AND.W       #B3TO5MASK,D5
    LSR.W       #3,D5
    RTS

************
* MASK8TO6 *
************
MASK8TO6:
    AND.W       #B6TO8MASK,D5
    LSR.W       #6,D5
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
