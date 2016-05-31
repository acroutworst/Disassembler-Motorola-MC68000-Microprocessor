*-----------------------------------------------------------
* Title      :print
* Written by :Nguyen
* Date       :5/22/16
* Description:print functions, keeps track of screen
*-----------------------------------------------------------
PRINTSTART
	MOVEM.L     A0-A5/D0-D7,-(SP)
	BSR         CLEARSCREEN     *Clears the screen first

PRINTLOOP	
	LEA         HEADER,A1    *Load nad print the header 
	MOVE.B      #14,D0
	TRAP        #15
	BSR         COUNTER      *branch to counter to increment by 1 and then back 

SETPRINT        
*Set D1 with trap 11, high byte is col 0-79 low num is row 0-31
	LEA         MEM_BUFFER,A1    *Load memory location
	MOVE.L      #14,D0
	TRAP        #15              *Print
	
    ADD.W       #$0D00,D1        *Memory location 13 spaces
	MOVE.B      #11,D0
	TRAP        #15
	
    LEA         OPCODE_BUFFER,A1  *loads opcode location
	MOVE.L      #1,D0    *Display string at (A1), w/o CR, LF.
	TRAP        #15
	
	ADD.W       #$0800,D1      *Move over 8 spaces in the row
	MOVE.B      #11,D0
	TRAP        #15
	
	LEA         EA_BUFFER,A1	*Loads EA location
	MOVE.L      #14,D0
	TRAP        #15
	
	ADD.B       #1,D1    *Moves down to next row
	MOVE.B      #11,D0
	TRAP        #15
	
	* changing this to print out a newline
*	MOVE.B      #$00,D1    *resets the column
*	MOVE.B      #11,D0
*	TRAP        #15

    LEA         SPACE,A1
    MOVE.B      #13,D0
    TRAP        #15
	BSR         COUNTER
	RTS
	
	
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
    MOVE.W #$FF00,D1          *this is the clearscreen code with trap 11
    MOVE.B #11,D0
    TRAP #15
    MOVE.B #0,LINECOUNTER       *reset linecounter to 0
    MOVE.W #$0001,D1         *header takes 1 row, start below that
    JMP PRINTLOOP               *go back to print loop

COUNTER
	ADDI.B #1,LINECOUNTER      *add 1 to counter to keep track of print screen
	CMP.B #20,LINECOUNTER       *if it's greater or equal than 20 then clear 
	BGT CLEARSCREEN              
	RTS                         *return to the printloop

GOODBYE
	LEA GOODBYEM,A1
	MOVE.B #14,D0
	TRAP #15




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
