*-----------------------------------------------------------
* Title      :CONVERT2HEX
* Written by :NGUYEN NGUYEN
* Date       :5/18/16
* Description:CONVERT THE ASCII TO HEX
*-----------------------------------------------------------

********************************************************
* Usage Notes:
* ** D1 - contains string length
* ** D2 - used for moving chars in
* ** D3 - loop counter
* ** D4 - converted string
* ** (A1) - string to convert
* ** 
  
CONVERT2HEX 
    MOVEM.L     A0-A5/D0-D7,-(SP) * Move registers to stack to be moved 
    *(A2) indirect pointer to string length
    *A2 stores the current address passed in
    *D3 hold the length loop  

*initialize
*    MOVEA.L #SETLENGTH,A2   *set string length for address
*    MOVE.L D1,(A2)       *moves the length input into the indirect address
    
    CLR.L       D3          *Clears D3 and set to 0
    
******CONVERT******

    *LEA INPUT,A1
LOOP:
*Else go through loop
          
    MOVE.B      (A1)+,D2    *GOES THRU A1 (address passed in) ONE AT A TIME

*CHK CHARACTER 0-9
NUM2HEX:
    CMP.B       #$39,D2 *0-9 IN HEX IS 30-39
    BGT         UPCAP   *greater than 39 then it's a letter
    CMP.B       #$30,D2 
    BLT         ERR       *if it's less than 30 then it's not valid
    BRA         CONVERTNUM   *Else it's within the number range

*CHECK LETTER A-F IS 41-46
UPCAP:
    CMP.B       #$46,D2
    BGT         LOWCAP
    CMP.B       #$41,D2
    BLT         ERR
    BRA         CONVERTUP

*CHECK LETTER a-f 61-66
LOWCAP:
    CMP.B       #$66,D2
    BGT         ERR
    CMP.B       #$61,D2
    BLT         ERR
    BRA         CONVERTLOW

CONVERTNUM:
*CONVERT BY SUBTRACTING '0' 0x30
    SUB.B       #'0',D2
    BRA         ADD2STRING
    
CONVERTLOW:
    SUB.B       #$57,D2
    BRA         ADD2STRING

CONVERTUP:
* convert by subtracting 0x37
    SUB.B       #$37,D2
    BRA         ADD2STRING

ADD2STRING:
*loop through to add
    ADD.B       D2,D4    *Add the converted num/letter to running total

    ADDQ        #1,D3
    CMP.B       D1,D3    *D3 holds the length that we've gone through 
    BEQ         LOOPDONE    *if the input length and the length we've looped through then it's done 
    LSL.L       #4,D4    *Shift left to accept next digit
    
    BRA         LOOP
 
LOOPDONE:
    MOVEA.L     D4,A6
    MOVEM.L     (SP)+,A0-A5/D0-D7   *move registers back from stack
    RTS

ERR:
    MOVEA.L     #$00000000,A6       *bad address that's out of scope
    MOVEM.L     (SP)+,A0-A5/D0-D7 *Move registers back from stack
    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
