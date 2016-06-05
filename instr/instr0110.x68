************************************
* Instructions Beginning With 0110 *
* ** Bcc                           *
************************************
INSTR0110:
    MOVEM.L     A0-A5/D0-D7,-(SP)       ; move registers to stack
    CLR         D7
    * setup bitmasker
    MOVE.B      #1,D4
    MOVE.W      (A6),D5
    JSR         BITMASKER
    MULU        #8,D5                   ; offset for jump table
    LEA         BCC_TABLE,A0            ; load the jump table
    JSR         0(A0,D5)                ; jump in
    
    MOVE.B      #1,D0
    JSR         PUSHBUFFER
    JSR         UPDATE_OPCODE
    
    * update ea info
    LEA         EA_NEEDED,A0
    MOVE.B      #1,(A0)
    
    LEA         NUM_OPERANDS,A0
    MOVE.B      #1,(A0)
    
    LEA         EA_DST_TYPE,A0
    MOVE.B      #$B,(A0)

    
    MOVEM.L     (SP)+,A0-A5,D0-D7
    RTS
    
BCC_TABLE:
    JSR         BCC0000
    RTS
    JSR         BCC0001
    RTS
    JSR         BCC0010
    RTS
    JSR         BCC0011
    RTS
    JSR         BCC0100
    RTS
    JSR         BCC0101
    RTS
    JSR         BCC0110
    RTS
    JSR         BCC0111
    RTS
    JSR         BCC1000
    RTS
    JSR         BCC1001
    RTS
    JSR         BCC1010
    RTS
    JSR         BCC1011
    RTS
    JSR         BCC1100
    RTS
    JSR         BCC1101
    RTS
    JSR         BCC1110
    RTS
    JSR         BCC1111
    RTS
    
***********
* BCC0000 *
* ** BRA  *
***********
BCC0000:
    LEA     BRA_TXT,A0
    RTS
    
    
***********
* BCC0001 *
* ** BSR  *
***********
BCC0001:
    LEA     BSR_TXT,A0
    RTS

***********
* BCC0010 *
* ** BHI  *
***********
BCC0010:
    LEA     BHI_TXT,A0
    RTS
    
***********
* BCC0011 *
* ** BLS  *
***********
BCC0011:
    LEA     BLS_TXT,A0
    RTS

***********
* BCC0100 *
* ** BCC  *
***********
BCC0100:
    LEA     BCC_TXT,A0
    RTS

***********
* BCC0101 *
* ** BCS  *
***********
BCC0101:
    LEA     BCS_TXT,A0
    RTS

***********
* BCC0110 *
* ** BNE  *
***********
BCC0110:
    LEA     BNE_TXT,A0
    RTS

***********
* BCC0111 *
* ** BEQ  *
***********
BCC0111:
    LEA     BEQ_TXT,A0
    RTS

***********
* BCC1000 *
* ** BVC  *
***********
BCC1000:
    LEA     BVC_TXT,A0
    RTS

***********
* BCC1001 *
* ** BVS  *
***********
BCC1001:
    LEA     BVS_TXT,A0
    RTS

***********
* BCC1010 *
* ** BPL  *
***********
BCC1010:
    LEA     BPL_TXT,A0
    RTS

***********
* BCC1011 *
* ** BMI  *
***********
BCC1011:
    LEA     BMI_TXT,A0
    RTS

***********
* BCC1100 *
* ** BGE  *
***********
BCC1100:
    LEA     BGE_TXT,A0
    RTS

***********
* BCC1101 *
* ** BLT  *
***********
BCC1101:
    LEA     BLT_TXT,A0
    RTS

***********
* BCC1110 *
* ** BGT  *
***********
BCC1110:
    LEA     BGT_TXT,A0
    RTS

***********
* BCC1111 *
* ** BLE  *
***********
BCC1111:
    LEA     BLE_TXT,A0
    RTS










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
