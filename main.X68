*-----------------------------------------------------------
* Title      : Disassembler
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    
    MOVEA.L #$6000,A6
    MOVE.W  #$1639,(A6)
    JSR DECODER

    SIMHALT             ; halt simulator

* Put variables and constants here

    INCLUDE 'variables.x68'
    INCLUDE 'opcodes.x68'

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
