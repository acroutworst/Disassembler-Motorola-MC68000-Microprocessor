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
    
    MOVEA.L     A6,A3               ; capture working address
    
GET_OPERANDS:
    LEA         NUM_OPERANDS,A0
    MOVE.B      (A0),D0
    MULU        #8,D0
    LEA         OPERANDS_TABLE,A1
    JSR         0(A1,D0)
    BRA         FINISH_EADECODER
    
    
    
    
OPERANDS_TABLE:
    JSR         NO_OPERANDS
    RTS
    JSR         ONE_OPERAND
    RTS
    JSR         TWO_OPERAND
    RTS
    
    
NO_OPERANDS:
    RTS
    
ONE_OPERAND:
    
    JSR         GET_DEST
    
    RTS
    
TWO_OPERAND:
    
    
    JSR         GET_SOURCE
    
    LEA         COMMA,A0
    MOVE.B      #2,D0
    JSR         PUSHBUFFER
    
    JSR         GET_DEST
    
    RTS
    
    
    
GET_SOURCE:
    LEA         EA_TYPE,A5
    MOVE.B      (A5),D0
    MULU        #8,D0

    LEA         SOURCE_TABLE,A0
    JSR         0(A0,D0)
    RTS

GET_DEST:
    LEA         EA_TYPE,A5
    MOVE.B      (A5),D0
    MULU        #8,D0
    
    LEA         DEST_TABLE,A0
    JSR         0(A0,D0)
    RTS
    
SOURCE_TABLE:
    JSR         EASRC00
    RTS
    JSR         EASRC01
    RTS
    JSR         EASRC02
    RTS
    JSR         EASRC03
    RTS
    JSR         EASRC04
    RTS
    JSR         EASRC05
    RTS
    JSR         EASRC06
    RTS
    JSR         EASRC07
    RTS
    
EASRC00:
    MOVE.B      #5,D4
    MOVE.W      (A3),D5
    JSR         BITMASKER
    
    MULU        #8,D5               ; offset for jump table
    
    LEA         EA_TABLE,A0         ; load the effective address jump table
    JSR         0(A0,D5)            ; call jump table
    RTS
    
EASRC01:
    RTS
    
EASRC02:
    RTS
    
EASRC03:
    RTS
    
EASRC04:
    RTS
    
EASRC05:
    RTS
    
EASRC06:
    RTS
    
EASRC07:
    RTS
    

DEST_TABLE:
    JSR         EADST00
    RTS
    JSR         EADST01
    RTS
    JSR         EADST02
    RTS
    JSR         EADST03
    RTS
    JSR         EADST04
    RTS
    JSR         EADST05
    RTS
    JSR         EADST06
    RTS
    JSR         EADST07
    RTS
    
EADST00:
    MOVE.B      #6,D4
    MOVE.W      (A3),D5
    JSR         BITMASKER
    
    MULU        #8,D5
    
    LEA         EA_TABLE,A0
    JSR         0(A0,D5)
    RTS
    
EADST01:
    RTS
    
EADST02:
    RTS
    
EADST03:
    RTS
    
EADST04:
    RTS
    
EADST05:
    RTS
    
EADST06:
    RTS
    
EADST07:
    RTS
    
    
FINISH_EADECODER:
    MOVEM.L     (SP)+,A0-A5/D0-D7   ; move registers back from stack
    RTS                             ; exit subroutine

    INCLUDE 'eamodes/ea_table.x68'







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
