* this file contains the variables that should be used throughout the course
* of execution

****************
* GLOBAL STUFF *
****************

CR          EQU     $0D
LF          EQU     $0A
NEWLINE     DC.B    CR,LF,0
START_ADDR  DS.L    1
END_ADDR    DS.L    1
PERIOD      DC.B    '.',0
COMMA       DC.B    ',',0
BUFFER      EQU     $2200
POUND       DC.B    '#',0
DOLLAR      DC.B    '$',0
MOD         DC.B    '%',0


****************
* OPCODE STUFF *
****************
B           DC.B    'B',0
W           DC.B    'W',0
L           DC.B    'L',0

MOVE_TXT    DC.B    'MOVE',0
MOVEA_TXT   DC.B    'MOVEA',0
MOVEQ_TXT   DC.B    'MOVEQ',0
MOVEM_TXT   DC.B    'MOVEM',0
NOP_TXT     DC.B    'NOP',0
JSR_TXT     DC.B    'JSR',0
ADD_TXT     DC.B    'ADD',0
ADDI_TXT    DC.B    'ADDI',0
ADDA_TXT    DC.B    'ADDA',0
ADDQ_TXT    DC.B    'ADDQ',0
RTS_TXT     DC.B    'RTS',0
LEA_TXT     DC.B    'LEA',0
CLR_TXT     DC.B    'CLR',0
DIVU_TXT    DC.B    'DIVU',0
OR_TEXT     DC.B    'OR',0
SUB_TEXT    DC.B    'SUB',0
CMP_TXT     DC.B    'CMP',0
MULS_TXT    DC.B    'MULS',0
AND_TXT     DC.B    'AND',0
LSL_TXT     DC.B    'LSL',0
LSR_TXT     DC.B    'LSR',0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
