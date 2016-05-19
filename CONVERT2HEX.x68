*-----------------------------------------------------------
* Title      :CONVERT2HEX
* Written by :NGUYEN NGUYEN
* Date       :5/18/16
* Description:CONVERT THE ASCII TO HEX
*-----------------------------------------------------------
  
CONVERT2HEX 
    MOVEM.L A0-A5/D0-D7,-(SP) * Move registers to stack to be moved 
    *(A2) indirect pointer to string length
    *A2 stores the current address passed in
    *D3 hold the length loop  

*initialize
    MOVEA.L #SETLENGTH,A2   *set string length for address
    MOVE.L D1,(A2)       *moves the length input into the indirect address
    MOVE.B #0,D3          *Clears D3 and set to 0

******CONVERT******

*CHECK IF THE STRING IS EMPTY
    CMP.L #0,(A2)    *compare 0 to input length
    BEQ LOOPDONE    *if 0 then loop is done
    
LOOP
*Else go through loop
    CMP.B (A2),D3    *D3 holds the length that we've gone through 
    BEQ LOOPDONE    *if the input length and the length we've looped through then it's done
    ADDQ #1,D3
    
*READ EACH CHARACTER* 
    MOVE.B (A1)+,D2    *GOES THRU A1 (address passed in) ONE AT A TIME

*CHK CHARACTER 0-9
NUM2HEX 
    CMP.B #$39,D2 *0-9 IN HEX IS 30-39
    BGT UPCAP   *greater than 39 then it's a letter
    CMP.B #30,D2 
    BLT ERR       *if it's less than 30 then it's not valid
    BRA NUM2HEX   *Else it's within the number range

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
    ADD.B D3,STRING2HEX
    MOVE.L  #STRING2HEX,D4
    LSL.L #4,D4 * LSL will only do LSL.W if you aren't dealing with a data register
    MOVE.L  D4,STRING2HEX
    BRA LOOP
 
LOOPDONE
    MOVEA.L #STRING2HEX,A6
    MOVE.L D5,(A6)
    RTS

ERR
    MOVEA.L #00000000,A6       *Inaccurate code
    MOVEM.L (SP)+, A0-A5/D0-D7 *Move registers back from stack
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
