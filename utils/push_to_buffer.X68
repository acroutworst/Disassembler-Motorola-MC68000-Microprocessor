*-----------------------------------------------------------
* Title      : Push to Buffer
* Written by : Geoff Friesen
* Date       : 2016/05/08
* Description: Takes a null-terminated string loaded into A0 
*              and pushes it to the buffer specified in 
*              D0 for display.
*              ** 0 - MEM_BUFFER - buffer for the memory location
*              ** 1 - OPCODE_BUFFER - buffer containing the opcode and size
*              ** 2 - EA_BUFFER - buffer containing all EA operands
*-----------------------------------------------------------
PUSHBUFFER:
    MOVEM.L     A0-A6/D0-D7,-(SP)       ; move registers to stack
    CMP.B       #0,D0                   ; check for mem buffer
    BEQ         HNDL_MEM_BUFFER
    CMP.B       #1,D0                   ; check for opcode buffer
    BEQ         HNDL_OPCODE_BUFFER
    CMP.B       #2,D0                   ; check for ea buffer
    BEQ         HNDL_EA_BUFFER
    
HNDL_MEM_BUFFER:
    LEA         MEM_BUFFER,A1           ; load mem buffer
    LEA         MEM_BUFFER_POS,A2       ; load mem buffer position
    BRA         PREP_BUFFER

HNDL_OPCODE_BUFFER:
    LEA         OPCODE_BUFFER,A1        ; load opcode buffer
    LEA         OP_BUFFER_POS,A2        ; load position
    BRA         PREP_BUFFER

HNDL_EA_BUFFER:
    LEA         EA_BUFFER,A1            ; load ea buffer
    LEA         EA_BUFFER_POS,A2        ; load ea buffer position
    BRA         PREP_BUFFER

PREP_BUFFER:
    MOVE.W      (A2),D3                 ; move loaded buffer position in
    ADDA.L      D3,A1                   ; add to buffer address
    
PUSH_LOOP:
    MOVE.B      (A0)+,(A1)+             ; push one character
    
    ADDQ        #1,(A2)                 ; increment buffer position
    CMP.B       #0,(A0)                 ; check for 0 (null-terminated)
    BEQ         PUSHBUFFERDONE          ; done if 0
    BRA         PUSH_LOOP               ; next iteration
    
PUSHBUFFERDONE:
    MOVEM.L     (SP)+,A0-A6/D0-D7       ; move registers back from stack
    RTS
    





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
