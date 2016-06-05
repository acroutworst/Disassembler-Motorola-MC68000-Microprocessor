*-----------------------------------------------------------
* Title      :User input
* Written by :Nguyen
* Date       :
* Description:Get user input, check the address length and jsr to convert2hex
*-----------------------------------------------------------
RESTART
    MOVE.W      #$FF00,D1           *this is the clearscreen code with trap 11
    MOVE.B      #11,D0
    TRAP        #15
    JSR CLEAREVERYTHING
    JMP DISASSEMBLER

DISPLAY 
    MOVEM.L     A0-A5/D0-D7,-(SP) * Move registers to stack to be moved 
    LEA HELLO,A1      *LOAD Welcome message
    MOVE.B #14,D0     * Moves 14 into data register
    TRAP #15          *Prints out wecome message
          
*ask for starting address
STARTA
    LEA REQSTART,A1   *load start message *A1 has the current starting
    MOVE.B #14,D0
    TRAP #15

*read Input
    MOVE.B #2,D0      *read string at (A1) and length is returned at D1
    TRAP #15          *Read input length into D1.L
    
*check length
    CMP.W #6,D1       *Check the length is no more than 24 bits, valid address 007000-FFFFFF
    BGT BADLENGTH     *if bad length goes to print error message

*Must sent to subroutine to be converted to HEX* 
    JSR CONVERT2HEX 

*Error checks    
    CMPA.L #MINADDY,A6    *comparing to minimum address
    BLT OUTOFRANGE         *branch if less than minimum allowed
    CMPA.L #ERRADD,A6    * if address is incorrect then convert2hex will make A6,00000000 invalid address
    BNE ODDCHECK          *if not incorrect then move ot odd check
    BEQ INVALID          *else move ot invalid

ODDCHECK
    MOVE.W A6,D3   *saves original addy to A6
    LSR.L #1,D3  *Left shift 1 bit, if carry bit's 1= odd, if it's 0=even
    BCS ODD      *If odd then error
    MOVE.L A6,START_ADDR
         
*ask for ending address       
ENDA   
    LEA         REQEND,A1  *Load end message
    MOVE.B      #14,D0
    TRAP        #15

    MOVE.B      #2,D0   *read string at (A1) and length is returned at D1
    TRAP        #15       *Read input into D1.L

*check length
    CMP.W       #6,D1    *Check the length is no more than 24 bits, valid address 00007000-00FFFFFF
    BGT         BADLENGTH     *if bad length goes to print error message

*send ending address to convert to HEX*
    JSR CONVERT2HEX

*Error checks
    CMPA.L #MAXADDY,A6      *comparing the max address to the ending
    BGT OUTOFRANGE         *branch to error if greater than
    CMPA.L #ERRADD,A6      *compare ot see if incorrect characters typed in as address
    BEQ INVALID         *branch if equal
    MOVE.W A6,D3     *move over to keep D1 unchanged
    LSR.L #1,D3      *Left shift 1 bit, if carry bit's 1= odd, if it's 0=even
    BCS ODDEND
    MOVE.L A6,END_ADDR   *Move A6 to end_address for storage
       
*check address validity
CHECKADDY
    MOVEA.L START_ADDR,A5  *Move start address to A5 
    CMPA.L   END_ADDR,A5   *Compares starting addy to the ending addy
    BGT GREAT    *If D1 (start) > D2 (end) go back for new addresses
    BEQ EQUAL    *If D1 (start) == D2(end)
    MOVEA.L     START_ADDR,A6   *store starting address to A6

    MOVE.B  #12,D0              Keyboard echo
    MOVE.B  #0,D1               Invisible
    TRAP    #15
    MOVEM.L     (SP)+,A0-A5/D0-D7 *Move registers back from stack   
    RTS       *The checks are done and the ascii to hex convert done
   
  *if all else good jump tp print*     

ODD
    LEA ODDERR,A1       *prints out odd error message
    MOVE.B #14,D0       
    TRAP #15
    MOVE.L #0,A1       *clears out A1 to go back to Start A
    CLR.B D1           *Clears out D1
    BRA STARTA          *send back to ask for new starting address

ODDEND
    LEA ODDERR,A1       *prints out odd error message
    MOVE.B #14,D0       
    TRAP #15

    MOVE.L #0,A1       *clears out A1 to go back to Start A
    CLR.B D1           *Clears out D1
    BRA ENDA            *send back to ask for new ending address
                
BADLENGTH
    LEA LENGTHERR,A1    *Prints out length error
    BRA LOAD

INVALID            *End length occurs before start must restart or end is equal to start
    LEA BADADDY,A1
    BRA LOAD

OUTOFRANGE
    LEA RANGE,A1
    BRA LOAD

EQUAL     *start ==end
    LEA SAME,A1
    BRA LOAD

GREAT   *end >start
    LEA BIGEND,A1
    BRA LOAD

LOAD
    MOVE.B #14,D0     *Print out the above errors
    TRAP #15

    MOVE.L #0,A1       *clears out A1 to go back to Start A
    CLR.B D1           *Clears out D1
    BRA STARTA *end is greater than start so back to start for new addresses

*Does user want to use the converter again?*
AGAIN
    MOVE.B      #11,D0
    ADD.B       #0127,D1               *Moves down to next row
    TRAP        #15
    
    MOVE.B  #12,D0              Keyboard echo
    MOVE.B  #0,D1               Visible
    TRAP    #15
    
    LEA ASKREPEAT,A1
    MOVE.B #14,D0
    TRAP #15

    MOVE.B #5,D0    *Read single character into D1
    TRAP #15

    CMP.B #$59,D1   *compare 59 to 'Y' to 79 to 'y'
    BEQ RESTART     *back to start address 
    CMP.B #$79,D1   *compare 59 to 'Y' to 79 to 'y'
    BEQ RESTART     *back to start address 
    
    JMP GOODBYE    *else jump to printing good bye

CLEAREVERYTHING
    MOVEM.L A0-A5/D0-D7,-(SP)
    MOVEA.L #0,A0
    MOVEA.L #0,A1
    MOVEA.L #0,A2
    MOVEA.L #0,A3
    MOVEA.L #0,A4
    MOVEA.L #0,A5
    MOVEA.L #0,A6
    MOVEA.L #0,A7
    MOVE.L #0,START_ADDR
    MOVE.L #0,END_ADDR
    MOVE.B  #12,D0              Keyboard echo
    MOVE.B  #1,D1               Visible
    TRAP    #15
    MOVEM.L (SP)+,A0-A5/D0-D7 *Move registers back from stack   
    RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
