*-----------------------------------------------------------
* Title      : Disassembler
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    * test junk data
    MOVEA.L #$6000,A6
    * MOVE.W  #$1639,(A6)
    * MOVE.W  #$4E71,(A6)         ; throwing machine for NOP into mem address
    MOVE.W  #$1601,(A6)           ; MOVE.B D0,D3
    JSR     DISPLAY
    JSR     DECODER

    SIMHALT             ; halt simulator

* Put variables and constants here

    INCLUDE 'variables.x68'
    INCLUDE 'opcodes.x68'
    INCLUDE 'bitmasker.x68'
    INCLUDE 'utils/push_to_buffer.x68'
    INCLUDE 'input_validation.x68'

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
