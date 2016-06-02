*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $7000
START:                  ; first instruction of program

    *TEST_DATA:
**-----------------------MOVE--------------------------------
** Syntax: <ea>, <ea>
** Size: B, W, L
**-----------------------------------------------------------
*    MOVE.B      #1,D0
*    MOVE.B      #1,D1
*    MOVE.B      #1,D2       ; WEIRD BUG HERE
*    MOVE.B      #1,D3
*    MOVE.B      #1,D4
*    MOVE.B      #1,D5
*    MOVE.B      #1,D6
*    MOVE.B      #1,D7
*    MOVE.W      #1,D1
*    
*    MOVE.L      #1234,$700A    
*
**LEGAL INSTRUCTIONS
*  *  BCS     *-10
*    BSR     $7030
*   * BGT     *+24
*    BPL     24
*    *BVS     *+2013
*
*    SUBI.W  #$DADA,D2
*    SUBI.B  #$FA,D0
*    
*    NOT.B   D0
*    NOT.W   (A0)
*    NOT.L   (A1)+
*    NOT.B   -(A2)
*    NOT.W   (0,A3)
*    NOT.L   (5,A7,D1)
*    NOT.W   $123.L   
*    
*    MOVE.B  (6*2,A6,D2),(A4)     ;(d8,An,Xn),(An)
*    MOVE.W  (79,A6,A1),A5        ;(d8,An,Xn),An
*    MOVE.L  (5,A0,D2.L),D6       ;(d8,An,Xn.SIZE),Dn
*    MOVE.W  D1, $00F00210
*    MOVE.L  D2, (A1)+
*    
*    MOVE.B  (A1),$FF00          ;(An),<ea>
*    MOVE.W  (A3),D3
*    MOVE.L  (A5),-(A1)
*    
*    MOVE.L  A0, (A2)            ;An,<ea>
*    MOVE.W  A1, (A3)+
*
*    MOVE.W  -(A1),D1        ; -(An),<ea>
*    MOVE.L  -(A2),(A2)+
*
**Illegal Instruct
*    MOVE.B  $FA, -(SP)        ;<ea>, -(SP)
*    MOVE.W  ($FA,A1),(A2)     ;(d16,An),<ea>
*
*    MOVE.L  (SP)+, D3           ;(SP)+, <ea>
**-----------------------MOVEA--------------------------------
** Syntax: <ea>, An
** Size:   W, L
**-----------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*
*    MOVEA.W  D0,A0              Dn,An
*    MOVEA.L  A0,A1              An,An
*    MOVEA.L  (A1),A2            (An),An
*    
*    MOVEA.L  (A2)+,A3           (An)+,An
*    MOVEA.W  -(A3),A4           -(An),An
**-----------------------MOVEM--------------------------------
** Syntax: <list>,<ea>   -   <ea>,<list>
** Size:   W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*
**Register to Memory - <list>,<ea>
*    MOVEM.W     D1-D3/A1, (A0)      ;<list>,(An)
*    MOVEM.W     D1/A0-A1, $DADA     ;<list>,(xxx).W
*    MOVEM.L     D0-D4/A0-A4, -(A1)  ;<list>,-(An)
*    
**Memory to Register - <ea>,<list>
*    MOVEM.W     (A1),D1-D3/A1       ;(An),<list>
*    MOVEM.L     (A2)+, D0-D4/A0-A4  ;(An)+,<list>
*    
* 
**-----------------------ADD----------------------------------
** Syntax: <ea>,Dn   -   Dn,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
**<ea>,Dn
*    ADD.B       D0,D1       ;Dn,Dn
*    ADD.W       D1,D2
*    ADD.L       D2,D3
*    
*    ADD.W       A1,D1       ;An,Dn
*    ADD.L       A2,D2
*    ADD.L       A3,D5
*    
*    ADD.B       (A0),D2     ;(An),Dn
*    ADD.W       (A1),D3
*    ADD.L       (A2),D4
*    
*    ADD.B       (A3)+,D0    ;(An)+,Dn
*    ADD.W       (A4)+,D1
*    ADD.L       (A5)+,D2
*    
*    ADD.B       -(A0),D3    ;-(An),Dn
*    ADD.W       -(A1),D4    
*    ADD.L       -(A2),D5
*    
*    ADD.B       #$FA,D0    ;(xxx).W,Dn
*    
**Dn,<ea>
*
*    ADD.W       D0,A1       ;Dn,An
*    ADD.W       D1,A2
*    ADD.L       D2,A3
*    
*    ADD.B       D3,(A4)     ;Dn,(An)
*    ADD.W       D4,(A5) 
*    ADD.L       D5,(A6)
*    
*    ADD.B       D0,(A0)+    ;Dn,(An)+
*    ADD.W       D1,(A1)+
*    ADD.L       D2,(A2)+
*    
*    ADD.B       D3,-(A3)    ;Dn,-(An)
*    ADD.W       D4,-(A4)
*    ADD.L       D5,-(A5)
**-----------------------ADDA---------------------------------
** Syntax: <ea>,An   
** Size:   W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    ADDA.W       D0,A0           ;Dn,An
*    ADDA.L       D1,A1   
*    
*    ADDA.L       A2,A3           ;An,An
*    ADDA.W       A3,A4
*    
*    ADDA.W       (A0),A0         ;(An),An
*    ADDA.L       (A2),A2
*    
*    ADDA.L       (A1)+,A1        ;(An)+,An
*    ADDA.W       (A2)+,A2
*   
*    ADDA.W       -(A3),A2        ;-(An),An
*    ADDA.L       -(A2),A3
*
*
**ILLEGAL INSTRUCTIONS
*
*    ADDA.W       ($FA,A2),A1   ;(d16,An),An
*
**-----------------------ADDQ---------------------------------
** Syntax: #<data>,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    ADDQ.B      #$1,D1       ;#<data>,Dn
*    ADDQ.W      #$2,D2
*    ADDQ.L      #3,D3
*    
*    ADDQ.W      #$4,A0      ;#<data>,An
*    ADDQ.L      #$5,A1
*    ADDQ.L      #$6,A2
*    
*    ADDQ.B      #$7,(A0)     ;#<data>,(An)
*    ADDQ.W      #$8,(A1)
*    ADDQ.L      #1,(A2)
*    
*    ADDQ.B      #$2,(A2)+    ;#<data>,(An)+
*    ADDQ.W      #$3,(A3)+
*    ADDQ.L      #$4,(A4)+
*    
*    ADDQ.B      #$5,-(A5)    ;#<data>,-(An)
*    ADDQ.W      #6,-(A6)
*    ADDQ.L      #$7,-(A7)
*    
**-----------------------SUB----------------------------------
** Syntax: <ea>,Dn   -   Dn,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
**<ea>,Dn
*
*    SUB.B       D0,D1       ;Dn,Dn
*    SUB.W       D2,D3
*    
*    SUB.L       A1,D0       ;An,Dn
*    SUB.W       A4,D3
*    
*    SUB.B       (A3),D3     ;(An),Dn
*    SUB.L       (A2),D0
*    
*    SUB.B       (A0)+,D1    ;(An)+,Dn
*    SUB.W       (A3)+,D2
*    
*    SUB.L       -(A1),D2    ;-(An),Dn
*    SUB.B       -(A2),D1    
*
**Dn,<ea>
*
*    SUB.W       D0,A1       ;Dn,An
*    SUB.L       D3,A4
*    
*    SUB.B       D3,(A3)     ;Dn,(An)
*    SUB.W       D0,(A2)
*    
*    SUB.L       D1,(A0)+    ;Dn,(An)+
*    SUB.B       D2,(A3)+
*    
*    SUB.W       D2,-(A1)    ;Dn,-(An)
*    SUB.L       D1,-(A2)
*
*
**-----------------------SUBA---------------------------------
** Syntax: <ea>, An
** Size:   W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*
*    SUBA.W      D0,A0       ;Dn,An
*    SUBA.L      D1,A1
*    
*    SUBA.W      A1,A2       ;An,An
*    SUBA.L      A2,A3
*    
*    SUBA.W      (A3),A3     ;(An),An
*    SUBA.L      (A4),A4
*    
*    SUBA.W      (A5)+,A0    ;(An)+,An
*    SUBA.L      (A6)+,A1
*    
*    SUBA.W      -(A0),A2    ;-(An),An
*    SUBA.L      -(A1),A3 
*
**----------------------SUBI----------------------------------
** Syntax: #<data>,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    SUBI.W      #$DADA,D2
*    
*    SUBI.B      #10,(A1)
*    
*    
*    SUBI.B      #10,-(A4)            ;#<data>,-(An)
*    SUBI.W      #$F,-(A1)
*
**ILLEGAL INSTRUCTIONS
*
*    SUBI.W      #9,($30,A1)        ; #<data>,(d16,An)
*    SUBQ.L      #1,D0           ;SUBQ
*   
**----------------------MULU----------------------------------
** Syntax: <ea>,Dn16 x 16, -> 32
** Size:   W
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*
*    MULU.W      D0,D1           ;Dn,Dn
*    MULU.W      (A0),D1         ;(An),Dn
*    MULU.W      (A2)+,D2        ;(An)+,Dn
*    MULU.W      -(A3),D3        ;-(An),Dn
*
*
**ILLEGAL INSTRUCTIONS
*
*    MULU.W      ($32,A2),D0     ;(d16,An),Dn
*    MULU.W      ($1000,PC),D1   ;(d16,PC),Dn
*
**----------------------DIVS----------------------------------
** Syntax: <ea>, Dn32/16
** Size:   W
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    DIVS.W      D1,D2           ;Dn,Dn
*    DIVS.W      (A1),D2         ;(An),Dn
*    DIVS.W      (A2)+,D3        ;(An)+,Dn
*    DIVS.W      -(A3),D4        ;-(An),Dn
*   
**-----------------------EOR----------------------------------
** Syntax: Dn,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    EOR.B       D0,D1           ;Dn,Dn
*    EOR.W       D1,D2
*    
*    EOR.L       D2,(A2)         ;Dn,(An)
*    EOR.B       D3,(A3)
*    
*    EOR.W       D4,(A4)+        ;Dn,(An)+
*    EOR.L       D5,(A5)+
*    
*    EOR.B       D6,-(A6)        ;Dn,-(An)
*    EOR.W       D7,-(A7)
*
**-----------------------EORI---------------------------------
** Syntax: #<data>,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*
*    EORI.B      #$FA,D0       ;#<data>,Dn
*    EORI.W      #10,D1
*    
**-----------------------AND----------------------------------
** Syntax: <ea>,Dn    -  Dn,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
**<ea>,Dn
*
*    AND.B       D0,D1           ;Dn,Dn
*    AND.W       (A1),D2         ;(An),Dn
*    AND.L       (A2)+,D3        ;(An)+,Dn
*    AND.B       -(A3),D4        ;-(An),Dn
**Dn,<ea>
*
*    AND.W       D0,(A1)         ;Dn,(An)
*    AND.L       D1,(A2)+        ;Dn,(An)+
*    AND.B       D2,-(A3)        ;Dn,-(An)
*    AND.W       D3,$DADA        ;Dn,(xxx).W
*    
*    
**ILLEGAL INSTRUCTIONS
*
*    AND.B       ($12,A2),D2     ;(d16,An),Dn
*    AND.W       ($1121,PC),D3   ;(d16,PC),Dn
*    AND.L       D4, ($112,A4)   ;Dn,(d16,An)
*
**-----------------------ORI----------------------------------
** Syntax: #<data>,<ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    ORI.B       #$F1,D0         ;#<data>,Dn
*    ORI.W       #$DADA,(A2)     ;#<data>,(An)
* 
*    ORI.B       #$11,-(A4)      ;#<data>,-(An)
*
*    
**ILLEGAL INSTRUCTIONS
*
*    ORI.B       #4,($FF,A2)     ;#<data>,(d16,An)
*    OR.W        D1,D2           ;OR
*
**----------------------ASL-----------------------------------
** Syntax: Dx,Dy  - #<data>,Dy   -   <ea>
** Size:   B, W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    ASL.B       D0,D1       ;Dx,Dy
*    ASL.W       D2,D2       
*    ASL.L       #4,D2       ;#<data>,Dy
*    ASL.W       (A2)        ;(An)
*    ASL.W       (A3)+       ;(An)+
*    ASL.W       -(A4)       ;-(An)
*
**ILLEGAL INSTRUCTIONS
*
*    ASL.W       ($22,A4)    ;(d16,An)
*
*    
**-----------------------LSR----------------------------------
** Syntax: Dx,Dy  - #<data>,Dy   -   <ea>
** Size:   B, W, L
**------------------------------------------------------------
**LEGAL INSTRUCTIONS
*    LSR.B       D0,D1      ; Dx,Dy
*    LSR.W       D2,D2       
*    LSR.L       #4,D2       ;#<data>,Dy
*    LSR.W       (A2)        ;(An)
*    LSR.W       (A3)+      ; (An)+
*    LSR.W       -(A4)      ; -(An)
*
**----------------------BTST----------------------------------
** Syntax: Dn, <ea>  - #<data>,<ea>
** Size:   B, L
**------------------------------------------------------------
**LEGAL INSTRUCTIONS
**Dn, <ea>
*
*    BTST.L      D0, D1      ;Dn,Dn
*    BTST.B      D1,(A1)     ;Dn,(An)
*    BTST.B      D2,(A2)+    ;Dn,(An)+
*    BTST.B      D3,-(A3)    ;Dn,-(An)
*
**-----------------------CMP + Bcc----------------------------
** Syntax: <ea>,Dn
** Size:   B, W, L
**------------------------------------------------------------
**LEGAL INSTRUCTIONS
*    CMP.B       D1,D0       ;Dn,Dn
*    BEQ         B1a
*B1a    
*    CMP.W       A2,D1       ;An,Dn
*    BEQ         B2a
*B2a
*    CMP.L       (A3),D2     ;(An),Dn
*    BLT         B3
*B3
*    CMP.B       (A4)+,D3    ;(An)+,Dn
*    BNE         B4
*B4
*    CMP.W       -(A5),D4    ;-(An),Dn
*
*
**ILLEGAL INSTRUCTIONS
*    JSR     ($19,A2)    ;(d16,An)
*    JSR     ($100,PC)   ;(d16,PC)
**-----------------------CMPA + Bcc---------------------------
** Syntax: <ea>,An
** Size:    W, L
**------------------------------------------------------------
*
**LEGAL INSTRUCTIONS
*    CMPA.W      D0,A0       ;Dn,An
*    CMPA.L      A0,A1       ;An,An
*    BEQ         Ba1
*Ba1
*    CMPA.W      (A1),A2     ;(An),An
*    BLT         Ba2
*Ba2
*    CMPA.L      (A2)+,A3    ;(An)+,An
*    BNE         Ba3
*Ba3
*    CMPA.W      -(A3),A4    ;-(An),An
*    BHI         Ba4
*Ba4
*    CMPA.L      #1234,A7    #<data>,An
*    
**ILLEGAL INSTRUCTIONS
*
*    CMPA.W      ($33,A1),A0     (d16,An),An
*    CMPA.L      ($11,PC),A2     (d16,PC),An
**-----------------------RTS----------------------------------
** Syntax: 
** Size:   Unsized
**------------------------------------------------------------
**LEGAL INSTRUCTIONS
*JUMP    *For JSR & RTS test
*        MOVE.B  D1,D1
*        RTS
**ILLEGAL INSTRUCTIONS
*        NOP         ;NOP    
*    SIMHALT             ; halt simulator

    INCLUDE 'main.x68'
    END    $7000        ; last line of source
    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
