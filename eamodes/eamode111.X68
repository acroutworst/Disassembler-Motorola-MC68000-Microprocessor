************************************
* Effective Address w/ 111         *
* ** IMMEDIATE | ABSOLUTE ADDRESS  *
*                                  *
* This subroutine is done!         *
************************************
EAMODE111:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    
    LEA         SUBTABLE,A1         ; load jump table

    MULU        #8,D4               ; get offset
    JSR         0(A1,D4)            ; send to subtable
    
    BRA         FINISH_EAMODE111
    
    
SUBTABLE:
    JSR         SUB000
    RTS
    JSR         SUB001
    RTS
    JSR         SUB010
    RTS
    JSR         SUB011
    RTS
    JSR         SUB100
    RTS
    JSR         SUB101
    RTS
    JSR         SUB110
    RTS
    JSR         SUB111
    RTS
    
    
FINISH_EAMODE111:
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS

* absolute addressing (short)
SUB000:
    LEA         DOLLAR,A0
    MOVE.B      #2,D0
    JSR         PUSHBUFFER
    
    * get a word
    MOVE.W      (A6)+,D1
    MOVE.B      #2,D0
    MOVE.B      #4,D2
    
    JSR         HEX2ASCII
    RTS
    
* absolute addressing (long)
SUB001:
    LEA         DOLLAR,A0
    MOVE.B      #2,D0
    JSR         PUSHBUFFER

    MOVE.L      (A6)+,D1
    MOVE.B      #2,D0
    MOVE.B      #8,D2
    
    JSR         HEX2ASCII
    RTS
    
SUB010:
    RTS
    
SUB011:
    RTS
    
* for immediate data
SUB100:
    * check the size of the operation
    LEA         SIZE,A2
    CMP.B       #'B',(A2)
    BEQ         GET_BYTE111
    CMP.B       #'W',(A2)
    BEQ         GET_WORD111
    CMP.B       #'L',(A2)
    BEQ         GET_LONG111

GET_BYTE111:
    BRA         GET_WORD111
    
GET_WORD111:
    MOVE.W      (A6)+,D1        ; get the next word and increment address
    MOVE.B      #4,D2           ; store the length of the hex input
    BRA         FINISH_SUB100
    
GET_LONG111:
    MOVE.L      (A6)+,D1        ; get the next long word and increment
    MOVE.B      #8,D2           ; store the length of the hex input
    BRA         FINISH_SUB100   
    
FINISH_SUB100:
    LEA         POUND,A0        ; load the pound sign
    MOVE.B      #2,D0           ; choose buffer
    JSR         PUSHBUFFER      ; push to buffer
    
    LEA         DOLLAR,A0       ; load dollar sign
    JSR         PUSHBUFFER      ; push to buffer
    
    JSR         HEX2ASCII       ; push hex data to buffer
    RTS        


SUB101:
    RTS

SUB110:
    RTS
    
SUB111:
    RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
