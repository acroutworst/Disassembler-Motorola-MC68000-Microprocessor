*-----------------------------------------------------------
* Title      :User input
* Written by :Nguyen
* Date       :
* Description:
*-----------------------------------------------------------
    *ORG    $1000   
    
DISPLAY: 
    LEA HELLO,A1     *LOAD Welcome message
    MOVE.B #14,D0    * Moves 14 into data register
    TRAP #15          *Prints out wecome message
          
*ask for starting address
STARTA 
    LEA REQSTART,A1 *load start message *A1 has the current starting
    MOVE.B #2,D0     * read string at (A1) and length is returned at D1
    TRAP #15         *Read input length into D1.L
    *MOVE.L D1,D2     *transfer start from d1 to d2
       
* don't need to check size? Check size 
       *CMP.W #6,D2     * Is a string length no greater than 6 or 8? 
       *BGT STARTA
       
*Must sent to subroutine to be converted to HEX* 
       JSR CONVERT2HEX 
       CMP #ERRADD,A6
       BEQ PRINTERR
       MOVE.L A6,START_ADDR
         
*ask for ending address       
ENDA   
    LEA REQEND,A1 *Load end message
    MOVE.B #2,D0
    TRAP #15  *Read input into D1.L
    CMP.W #6,D1
    BGT ENDA

*send ending address to convert to HEX*
    JSR CONVERT2HEX
    CMP #ERRADD,A6
    BEQ PRINTERR
    MOVE.L A6,END_ADDR
       
*check address validity
CHECKADDY
    MOVEA.L START_ADDR,A5   
    CMP.L   END_ADDR,A5   *Compares The starting address to the ending address --> CMP will only compare the source to a data register
* Put program code here
    BGE STARTA     *If D1 (starting) is greater than D2 (end) go back for new addresses
       
    MOVE.B START_ADDR,D3 *move over to keep D1 unchanged
    LSR.L #1,D3
 *Left shift 1 bit, if carry bit is 1 it's odd and if carry is 0 then even
    BCS ODD    
    BRA EVEN
       
ODD
    LEA ODDERR,A1       *prints out odd error message
    MOVE.B #14,D0       
    TRAP #15
    BRA STARTA          *send back to ask for new starting address

* If even check for length*
EVEN 




*Print out the err with address DATA $ADDR
  
PRINTERR
    LEA PRINT,A1
    MOVE.B #14, D0
    TRAP #15
    MOVE.L A6,A1
    MOVE.B #13,D0
    TRAP #15

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
