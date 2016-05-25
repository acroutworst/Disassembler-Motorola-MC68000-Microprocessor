*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $7000
START:                  ; first instruction of program

    MOVE.B      #1,D0
    MOVE.W      #1,D1
    MOVE.L      #1,D2
* Put program code here
    JSR         DISASSEMBLER

    
* Put variables and constants here

    INCLUDE 'main.x68'
    END    $7000        ; last line of source
    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
