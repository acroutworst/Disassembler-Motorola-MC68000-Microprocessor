************************************
* Instructions Beginning With 0000 *
* ** ADDI                          *
************************************
INSTR0000:
    LEA         BUFFER,A1               ; load the buffer to add to it
    MOVE.B      ADDI_TXT,BUFFER         ;
    * TODO - some stuff for addi
    RTS
