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
    LEA REQSTART, A1 *load start message
    MOVE.B #2,D0 
    TRAP #15         *Read inputinto D1.L
    MOVE.L D0,D2     *transfer start from d1 to d2
       
*Check size 
       CMP.W #6,D2     * Is a string length no greater than 6 or 8? 
       BGT STARTA
       
*Must sent to subroutine to be converted to HEX* 
       JSR CONVERT2HEX 
       
*ask for ending address       
ENDA   
    LEA REQEND,A1 *Load end message
    MOVE.B #2,D0
    TRAP #15  *Read input into D1.L
            CMP.W #6,D1
    BGT ENDA

*send ending address to convert to HEX*
    JSR CONVERT2HEX
       
*check address validity

ADDY   
    CMP.L D1,D2   *Compares The starting address to the ending address
* Put program code here
    BGE STARTA     *If D1 (starting) is greater than D2 (end) go back for new addresses
       

    CMP.L D1,#1000    *Compares D1 to initial address
    BLE STARTA    *if D1 is less than or equal than $1000 starting addy of the program then must ask for new start
    MOVE.B D1,D3 *move over to keep D1 unchanged
    LSR.L #1,D3
 *Left shift 1 bit, if carry bit is 1 it's odd and if carry is 0 then  even
    BCS ODD    
    BRA EVEN
       
ODD
    LEA ODDERR,A1    *prints out odd error message
    MOVE.B #2,D0       *takes in new number
    TRAP #15
    BRA ADDY          *uses new address and recheck for errors
* If even check for length*
EVEN 




**conversion to hex**
  

  
  
  
   *goes back to user to reenter

    SIMHALT             ; halt simulator

* Put variables and constants here
    INCLUDE 'CONVERT2HEX.x68'
CR EQU $0D     *ASCII code for carriage return
LF EQU $0A     *ASCII code for line feed
ADDYLENGTH EQU 6   *need 32 bit address length

HELLO DC.B 'Welcome to Teamy McTeamFaces Disassembler!',CR,LF,0
REQSTART DC.B 'Please enter in the starting location:',CR,LF, 0
REQEND DC.B 'Please enter in the ending location:',CR,LF,0
ODDERR DC.B 'Starting address cant be odd, please reenter:', CR, LF, 0
COMPLETE_REGISTER EQU D0-D7/A1-A7       
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~