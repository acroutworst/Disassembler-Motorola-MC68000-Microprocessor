*-----------------------------------------------------------
* Title      : Clear Variables
* Written by : Geoff Friesen
* Date       : 2016/05/12
* Description: Clears all variables used by the program to
*              reset for another iteration
*-----------------------------------------------------------
CLEAR_VARS:
    MOVEM.L     A0-A6/D0-D7,-(SP)
    CLR.L       D0
    CLR.L       D1
    
    * clear mem buffer position
    LEA         MEM_BUFFER_POS,A0
    MOVE.B      #0,(A0)+
    MOVE.B      #0,(A0)

    * clear opcode buffer position
    LEA         OP_BUFFER_POS,A1
    MOVE.B      #0,(A1)+
    MOVE.B      #0,(A1)

    * clear ea buffer position
    LEA         EA_BUFFER_POS,A2
    MOVE.B      #0,(A2)+
    MOVE.B      #0,(A2)
    
    * clear ea_needed var
    LEA         EA_NEEDED,A0
    MOVE.B      #0,(A0)
    
    * clear ea_type var
    LEA         EA_SRC_TYPE,A0
    MOVE.B      #0,(A0)
    
    LEA         EA_DST_TYPE,A0
    MOVE.B      #0,(A0)

    * clear num_operands var
    LEA         NUM_OPERANDS,A0
    MOVE.B      #0,(A0)
    
    * clear size
    LEA         SIZE,A0
    MOVE.B      #0,(A0)

    
    * clear mem buffer
    LEA         MEM_BUFFER,A1
    MOVE.B      #10,D1
    CLR.L       D0
    BSR         VARS_LOOP
    
    * clear opcode
    LEA         OPCODE,A1
    MOVE.B      #6,D1
    CLR.L       D0
    BSR         VARS_LOOP
    
    * clear opcode buffer
    LEA         OPCODE_BUFFER,A1
    MOVE.B      #8,D1
    CLR.L       D0
    BSR         VARS_LOOP
    
    * clear ea buffer
    LEA         EA_BUFFER,A1
    MOVE.B      #26,D1
    CLR.L       D0
    BSR         VARS_LOOP
    

    
    MOVEM.L     (SP)+,A0-A6/D0-D7
    RTS
    
VARS_LOOP:
    MOVE.B      #0,(A1)+
    ADDQ        #1,D0
    CMP.B       D1,D0
    BNE         VARS_LOOP
    RTS
    

CLEAR_REG:
    CLR.L       D0
    CLR.L       D1
    CLR.L       D2
    CLR.L       D3
    CLR.L       D4
    CLR.L       D5
    CLR.L       D6
    CLR.L       D7
    

    RTS    









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
