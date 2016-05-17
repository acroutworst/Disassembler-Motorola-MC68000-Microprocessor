*-----------------------------------------------------------
* Title      : Jump Table for EA Modes
* Written by : Adam Croutworst
* Date       : 05/14/16
* Description:
*-----------------------------------------------------------

***********************************
*   Jump Table for the EA Modes   *
***********************************
EA_TABLE:
    MOVEM.L     A0-A5/D0-D7,-(SP)
    
    JMP         EAMODE000           ; direct data register
    JSR
    JMP         EAMODE001           ; direct address register
    JSR
    JMP         EAMODE010           ; indirect address register   
    JSR
    JMP         EAMODE011           ; indirect address register w/ post increment
    JSR
    JMP         EAMODE100           ; indirect address register w/ pre decrement
    JSR
    JMP         EAMODE101           ; indirect address register w/ displacement
    JSR
    JMP         EAMODE110           ; indirect address register w/ index
    JSR
    JMP         EAMODE111           ; absolute / immediate 
    JSR
        
    MOVEM.L     (SP)+,A0-A5/D0-D7
    RTS


    INCLUDE     'eamodes/eamode000'       ; include all jump labels
    INCLUDE     'eamodes/eamode001'
    INCLUDE     'eamodes/eamode010'
    INCLUDE     'eamodes/eamode011'
    INCLUDE     'eamodes/eamode100'
    INCLUDE     'eamodes/eamode101'
    INCLUDE     'eamodes/eamode110'
    INCLUDE     'eamodes/eamode111'

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
