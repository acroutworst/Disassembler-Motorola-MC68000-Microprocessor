************************************
* Effective Address w/ 110         *
* ** INDIRECT ADDRESS REGISTER w/  *
*    INDEX                         *
* This subroutine is done!         *
************************************
EAMODE110:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    *MOVE.W      SIGN,(A6)+ ; JUMP TO SUBROUTINE AND DO SIGN STUFF
    
    MOVE.W      (A5)+,A0
    MOVE.L      D0,D3
    CLR.L       D4
    MOVE.B      #4,D4
    JSR         HEX2ASCII
    
    MOVEA.L     A3,A1
    MOVE.W      A1,(A6)+
    
    MOVE.W      O_PAREN,(A6)+
    
    CLR.L       D0
    MOVE        D5,D0
    ANDI        #7,D0
    MOVE.W      D0,D1
    MOVE.B      #2,D0
    JSR         PUSHBUFFER
    
    MOVE.W      COMMA,(A6)+
    MOVE.L      D5,D0
    ANDI        #$F000,D0              ; grab first byte 
    LSR.L       #8,D0
    CMPI        #8,D0
    BEQ         LONG
    CMPI        #0,D0
    BEQ         WORD
    MOVE.B      #1,D4                  ; 1 for flag - error
    
LONG:
    MOVE.W      EA_BUFFER,(A6)+
    MOVE.W      C_PAREN,(A6)+
    BRA         EXIT
    
WORD:
    MOVE.W      EA_BUFFER,(A6)+
    MOVE.W      C_PAREN,(A6)+
    
EXIT:
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
