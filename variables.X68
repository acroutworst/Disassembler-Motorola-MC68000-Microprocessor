* this file contains the variables that should be used throughout the course
* of execution

****************
* GLOBAL STUFF *
****************

* I'm thinking we put what we're going to print out at some address
BUFFER      DS.B    10
ERROR       DS.W    1
BUFFER_POS  DS.B    1

CR          EQU     $0D         ; carriage return
LF          EQU     $0A         ; line feed
NEWLINE     DC.B    CR,LF,0     ; new line
************
* IO STUFF *
ADDYLENGTH  EQU     8   *need 32 bit address length

HELLO       DC.B    'Welcome to Teamy McTeamFaces Disassembler!',CR,LF,0
REQSTART    DC.B    'Please enter in the starting location:',CR,LF,0
REQEND      DC.B    'Please enter in the ending location:',CR,LF,0
ODDERR      DC.B    'Starting address cant be odd, please reenter:',CR,LF,0
*COMPLETE_REGISTER EQU D0-D7/A1-A7       
ERRADD      EQU     00000000
PRINT       DC.B    'Address DATA $'
COMPARESPOT DS.B    16
STRING2HEX  DS.B    32

* storage for the start and end address
START_ADDR  DS.L    1
END_ADDR    DS.L    1

* punctuation
SPACE       DC.B    ' ',0
PERIOD      DC.B    '.',0
COMMA       DC.B    ',',0

* number types
POUND       DC.B    '#',0
DOLLAR      DC.B    '$',0
MOD         DC.B    '%',0

* for printing indirect addressing stuff
O_PAREN     DC.B    '(',0
C_PAREN     DC.B    ')',0
PLUS        DC.B    '+',0
MINUS       DC.B    '-',0

* for printing data and address registers
D           DC.B    'D',0
A           DC.B    'A',0



****************
* OPCODE STUFF *
****************
* BIT MASKS
* 
* groupings of 4
FIRST4MASK  EQU     $F000
SECON4MASK  EQU     $0F00
THIRD4MASK  EQU     $00F0
LAST_4MASK  EQU     $000F

* ea masks
B0TO2MASK   EQU     $0007
B3TO5MASK   EQU     $0038
B6TO8MASK   EQU     $01C0

* size mask
B6TO7MASK   EQU     $00C0


* SIZE MODIFIERS
B           DC.B    '.B',0
W           DC.B    '.W',0
L           DC.B    '.L',0

* OPCODES
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
ASL_TXT     DC.B    'ASL',0
ASR_TXT     DC.B    'ASR',0
ROL_TXT     DC.B    'ROL',0
ROR_TXT     DC.B    'ROR',0
DATA_TXT    DC.B    'DATA',0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
