*-----------------------------------------------------------
* Title      :CONVERT2HEX
* Written by :NGUYEN NGUYEN
* Date       :5/8/16
* Description:CONVERT THE ASCII TO HEX
*-----------------------------------------------------------
  *  ORG    $1000
*START:                  ; first instruction of program
CONVERT2HEX 
*initialize
    MOVEA.L #COMPARESPOT,A2
    MOVE.L D1,(A2)
    MOVE.B #0,D3

******CONVERT******
*CHECK IF THE STRING IS EMPTY
    CMP.L 0,(A2)
    BEQ FINISH
    
LOOP
*Else go through loop
    CMP.B #7, D3
    BEQ LOOPDONE
    ADDQ #1,D3
    MOVE.B (A1)+,D0
*READ EACH CHARACTER* 
    MOVE.B (A1)+,D2    *GOES THRU A1 ONE AT A TIME

*CHK CHARACTER 0-9
NUM 
    CMP.B #$39,D2 *0-9 IN HEX IS 30-39
    BGT UPCAP   
    CMP.B #30,D2
    BLT ERR
    BRA NUM2HEX

*CHECK LETTER A-F IS 41-46
UPCAP
    CMP.B #46,D2
    BGT.B LOWCAP
    CMP.B #41,D2
    BLT ERR
    BRA NUM2HEX

*CHECK LETTER a-f 61-66
LOWCAP
    CMP.B #66,D2
    BGT.B ERR
    CMP.B #61,D2
    BLT.B ERR
    BRA CONVERTLOW

CONVERTNUM
*CONVERT BY SUBTRACTING '0'
    SUB.B #'0',D2
    MOVE.L D2,D3
    BRA ADD2STRING
    

CONVERTLOW
*convert by adding A and subtracting a
    ADD.B #$A, D2
    SUB.B #'a',D2
    MOVE.L D2,D3
    BRA ADD2STRING

CONVERTUP
*convert by adding A, subtracting A
    ADD.B #$A,D2
    SUB.B #'A',D2
    MOVE.L D2, D3
    BRA ADD2STRING

ADD2STRING
*loop through to add
    ADD.B D3,D4
    LSL.L #4,D4
    BRA LOOP
 
LOOPDONE
    MOVEA.L #STRING2HEX,A6
    MOVE.L D5,(A6)
    RTS

   SIMHALT             ; halt simulator

* Put variables and constants here
COMPARESPOT DS 16
STRING2HEX DS 32


    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
