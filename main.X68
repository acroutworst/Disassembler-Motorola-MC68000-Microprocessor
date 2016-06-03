*-----------------------------------------------------------
* Title      : Disassembler
* Written by : Geoff Friesen, Adam Croutworst, Nguyen Nguyen
* Date       :
* Description:
*-----------------------------------------------------------
***************************
* TEST DATA
***************************
    ORG    $1000
START:                  ; first instruction of program 
    JSR         DISASSEMBLER
   
DISASSEMBLER:
    JSR     CLEAR_REG                 
    JSR     DISPLAY
    
    
    * test junk data
    *MOVEA.L #$6000,A6
    * MOVE.W  #$1639,(A6)
    *MOVE.W  #$4E71,(A6)         ; throwing machine for NOP into mem address
    * MOVE.W  #$1601,(A6)           ; MOVE.B D0,D3
    
****************************************************************
* Main Program Loop                                            *
* ** This loops through the address space collected by DISPLAY *
* ** in order to decode each instruction, line by line.        *
****************************************************************
MAIN_LOOP:
    MOVE.W  #0,ERROR
    JSR     CLEAR_VARS
    JSR     DECODER
    JSR     EADECODER     ; commenting out to test print subroutine
    
    JSR     PRINTSTART
    LEA     END_ADDR,A0
    MOVE.L  (A0),D0
    CMP.L   A6,D0
    BGT     MAIN_LOOP
    BRA     END_DIS
    
END_DIS:
    SIMHALT

************************************
* Includes                         *
* ** List of all subroutine files  *
* ** to be included in the program *
************************************    
    INCLUDE 'opcodes.x68'
    INCLUDE 'effective_address.x68'
    INCLUDE 'utils/bitmasker.x68'
    INCLUDE 'utils/push_to_buffer.x68'
    INCLUDE 'input_validation.x68'
    INCLUDE 'CONVERT2HEX.x68'
    INCLUDE 'utils/get_size.x68'
    INCLUDE 'utils/clear_variables.x68'
    INCLUDE 'utils/hex2ascii.x68'
    INCLUDE 'no_opcode.x68'
    INCLUDE 'print.x68'
    INCLUDE 'variables.x68'
    
    

* fin
    END    START        ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
