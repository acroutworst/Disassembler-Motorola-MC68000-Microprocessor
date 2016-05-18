*-----------------------------------------------------------
* Title      : Hex2ASCII
* Written by : Geoff Friesen
* Date       : 2016/05/18
* Description: Subroutine that takes hex input in D1 and
*              pushes it to the buffer specified in D0.
*
* NOTE: does not push any associated symbols to the buffer
*-----------------------------------------------------------
HEX2ASCII:
    MOVEM.L         A0-A6/D0-D7,-(SP)   ; move registers to stack
    MOVE.B          #0,D7               ; loop counter

    
HEX2ASCII_LOOP:
    ROL.L           #4,D1               ; rotate first char to bottom
    MOVE.B          D1,D2               ; copy data to manip
    AND.B           #$0F,D2             ; mask for last 4 bits
    
    LEA             H2A_TABLE,A0        ; load jump table
    MULU            #8,D2               ; get offset
    JSR             0(A0,D2)            ; jump in
    
    JSR             PUSHBUFFER          ; push the loaded character
    ADDQ.B          #1,D7               ; increment the loop counter
    CMP.B           #8,D7               ; check if done
    BNE             HEX2ASCII_LOOP      ; next iteration
    
    MOVEM.L         (SP)+,A0-A6/D0-D7   ; move registers back from stack
    RTS
        
H2A_TABLE:
    JSR             H2A_0
    RTS
    JSR             H2A_1
    RTS
    JSR             H2A_2
    RTS
    JSR             H2A_3
    RTS
    JSR             H2A_4
    RTS
    JSR             H2A_5
    RTS
    JSR             H2A_6
    RTS
    JSR             H2A_7
    RTS
    JSR             H2A_8
    RTS
    JSR             H2A_9
    RTS
    JSR             H2A_A
    RTS
    JSR             H2A_B
    RTS
    JSR             H2A_C
    RTS
    JSR             H2A_D
    RTS
    JSR             H2A_E
    RTS
    JSR             H2A_F
    RTS
    
H2A_0:
    LEA             TXT_0,A0        ; load 0 text
    RTS
    
H2A_1:
    LEA             TXT_1,A0        ; load 1 text
    RTS
    
H2A_2:
    LEA             TXT_2,A0        ; load 2 text
    RTS
    
H2A_3:
    LEA             TXT_3,A0        ; load 3 text
    RTS
    
H2A_4:
    LEA             TXT_4,A0        ; load 4 text
    RTS
    
H2A_5:
    LEA             TXT_5,A0        ; load 5 text
    RTS
    
H2A_6:
    LEA             TXT_6,A0        ; load 6 text
    RTS
    
H2A_7:
    LEA             TXT_7,A0        ; load 7 text
    RTS
    
H2A_8:
    LEA             TXT_8,A0        ; load 8 text
    RTS

H2A_9:
    LEA             TXT_9,A0        ; load 9 text
    RTS

H2A_A:
    LEA             A,A0            ; load A text
    RTS

H2A_B:
    LEA             B,A0            ; load B text
    RTS

H2A_C:
    LEA             TXT_C,A0        ; load C text
    RTS

H2A_D:
    LEA             D,A0            ; load D text
    RTS

H2A_E:
    LEA             TXT_E,A0        ; load E text
    RTS

H2A_F:
    LEA             TXT_F,A0        ; load F text
    RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
