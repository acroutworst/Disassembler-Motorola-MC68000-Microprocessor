*-----------------------------------------------------------
* Title      :print
* Written by :Nguyen
* Date       :5/22/16
* Description:print functions, keeps track of screen
*-----------------------------------------------------------
PRINTSTART
	MOVEM.L     A0-A5/D0-D7,-(SP)
	BSR         COUNTER             *Clears the screen first

PRINTLOOP	
*Set D1 with trap 11, high byte is col 0-79 low num is row 0-31

	CLR.W       D1                  *clears out D1 to reset row and column
	MOVE.W      #0000,D1            *reset all column

	ADD.B       LINECOUNTER,D1      *linecounter keeps the row update
	MOVE.B      #11,D0           
	TRAP        #15

	LEA         MEM_BUFFER,A1       *Load memory location
	MOVE.L      #14,D0
	TRAP        #15                 *Print
	
    ADD.W       #$0F00,D1           *Memory location 13 spaces
	MOVE.B      #11,D0
	TRAP        #15
	
    LEA         OPCODE_BUFFER,A1    *loads opcode location
	MOVE.L      #14,D0               *Display string at (A1), w/o CR, LF.
	TRAP        #15
	
	ADD.W       #$0B00,D1           *Move over 8 columns in the row
	MOVE.B      #11,D0
	TRAP        #15
	
	LEA         EA_BUFFER,A1	    *Loads EA location
	MOVE.L      #14,D0
	TRAP        #15
	
	ADD.B       #1,D1               *Moves down to next row
	MOVE.B      #11,D0
	TRAP        #15
	
    

DONE   *back to main	
	MOVEM.L (SP)+,A0-A5/D0-D7
	RTS

*Print out the err with address DATA $ADDR  
PRINTERR
	MOVEM.L     A0-A5/D0-D7,-(SP)   * Move registers to stack to be moved
    LEA         PRINTDATA,A1        *Prints address DATA $ 
    MOVE.B      #14,D0
    TRAP        #15


	LEA		 	ERRADD,A1
    MOVE.B      #14,D0              *Prints the null terminated string at A1
    TRAP        #15

    MOVEM.L     (SP)+,A0-A5/D0-D7   *move registers back from stack
    JMP         AGAIN               *Jumps to ask if they want to try program again

CLEARSCREEN
	LEA CLEARQ,A1    *ask user to clear
	MOVE.B #14,D0
	TRAP #15

	MOVE #5,D0       *Press enter to continue and clear
	TRAP #15

    MOVE.W      #$FF00,D1           *this is the clearscreen code with trap 11
    MOVE.B      #11,D0
    TRAP        #15
    MOVE.B      #1,LINECOUNTER      *reset linecounter to 1 due to printing header below

    LEA         HEADER,A1           *Load and print the header 
	MOVE.B      #14,D0
	TRAP        #15

	MOVE.W      #$0001,D1           *header takes 1 row, start below that
	MOVE.B      #11,D0
	TRAP        #15
	RTS                             * will return to counter where it'll 
                                    * return to where it was in print
    
COUNTER
	ADDI.B      #1,LINECOUNTER      *add 1 to counter to keep track of print screen
	CMP.B       #20,LINECOUNTER     *if it's greater or equal than 20 then clear 
	BGE         CLEARSCREEN      
	CMP.B       #0,LINECOUNTER      ; check if haven't printed any lines yet
	BEQ         CLEARSCREEN         ; and clear screen to start over
	RTS                             *return to the printloop

GOODBYE
	LEA GOODBYEM,A1                 ; load goodbye message text
	MOVE.B #14,D0                   ; choose trap task
	TRAP #15                        ; print it







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
