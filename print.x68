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

SETPRINT             	*Set D1 with trap 11, high num is col 0-79 low num is 0-31
	MOVE.W 0101,D1.W           *header takes 1 row and 1 colum

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
