*-----------------------------------------------------------
* Title      :print
* Written by :Nguyen
* Date       :5/22/16
* Description:print functions, keeps track of screen
*-----------------------------------------------------------
PRINTSTART
	MOVEM.L A0-A5/D0-D7,-(SP)
	BSR CLEARSCREEN     *Clears the screen first

PRINTLOOP	
	LEA HEADER,A1    *Load nad print the header 
	MOVE.B #14,D0
	TRAP #15
	BSR COUNTER      *branch to counter to increment by 1 and then back 

SETPRINT            *Set D1 with trap 11, high num is col 0-79 low num is 0-31
	LEA MEM_BUFFER,A1    *Load memory location
	MOVE.L #14,D0
	TRAP #15              *Print
	ADD.B #13,D1.W        *Memory location 13 spaces
	LEA OPCODE_BUFFER,A1  *loads opcode location
	MOVE.L #14,D0
	TRAP #15
	ADD.B #8,D1.W         *Move over 8 spaces in the row
	LEA EA_BUFFER,A1	*Loads EA location
	MOVE.L #14,D0
	TRAP #15
	ADD.W #100,D1.W    *Moves down to next column
	MOVE.B #00,D1.W    *resets the row
	BSR COUNTER
	
****
*How to check if all the opcodes has been printed and is done?*
****	
	BRA SETPRINT       *repeat until done

DONE	
	MOVEM.L (SP)+,A0-A5/D0-D7
	RTS

*Print out the err with address DATA $ADDR  
PRINTERR
	MOVEM.L A0-A5/D0-D7,-(SP) * Move registers to stack to be moved
    LEA PRINTDATA,A1    *Prints address DATA $ 
    MOVE.B #14,D0
    TRAP #15
    MOVE.L A6,A1
    MOVE.B #13,D0               *Prints the null terminated string at A1
    TRAP #15
    MOVEM.L (SP)+,A0-A5/D0-D7   *move registers back from stack
    RTS                         *return 

CLEARSCREEN
    MOVE.W $FF00,D1.W           *this is the clearscreen code with trap 11
    MOVE.B #11,DO
    TRAP #15
    MOVE.B #0,LINECOUNTER       *reset linecounter to 0
    MOVE.W #0100,D1.W         *header takes 1 column, start below that
    JMP PRINTLOOP               *go back to print loop

COUNTER
	ADDI.B #1, LINECOUNTER      *add 1 to counter to keep track of print screen
	CMP.B #20,LINECOUNTER       *if it's greater or equal than 20 then clear 
	BGT CLEARSCREEN              
	RTS                         *return to the printloop

GOODBYE
	LEA GOODBYE,A1
	MOVE.B #14,D0
	TRAP #15



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
