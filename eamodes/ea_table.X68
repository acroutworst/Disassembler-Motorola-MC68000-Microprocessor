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
    JSR         EAMODE000           ; direct data register
    RTS
    JSR         EAMODE001           ; direct address register
    RTS
    JSR         EAMODE010           ; indirect address register   
    RTS
    JSR         EAMODE011           ; indirect address register w/ post increment
    RTS
    JSR         EAMODE100           ; indirect address register w/ pre decrement
    RTS
    JSR         EAMODE101           ; indirect address register w/ displacement
    RTS
    JSR         EAMODE110           ; indirect address register w/ index
    RTS
    JSR         EAMODE111           ; absolute / immediate 
    RTS

    INCLUDE     'eamodes/eamode000.x68'       ; include all jump labels
    INCLUDE     'eamodes/eamode001.x68'
    INCLUDE     'eamodes/eamode010.x68'
    INCLUDE     'eamodes/eamode011.x68'
    INCLUDE     'eamodes/eamode100.x68'
    INCLUDE     'eamodes/eamode101.x68'
    INCLUDE     'eamodes/eamode110.x68'
    INCLUDE     'eamodes/eamode111.x68'




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
