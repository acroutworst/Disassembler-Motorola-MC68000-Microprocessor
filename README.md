# CSS-422-Final
Disassembler for Motorola MC68000 Microprocessor (Easy68k). Final project for CSS 422 

Specifications:
  * Output Buffer: $2200
  * Acceptable Input Range: <TBD>
Register Use:
  * A6: address currently being processed
Current Subroutines:
  * main: main program to be executed
  * bitmasker: masks off a set of bits
  * opcodes: decodes an instruction
    * instr/instr[0000-1111]: subroutines for each instruction starting
    * with the corresponding 4 bits
  * utils/get_size: gets the operation size of an instruction
  * utils/push_to_buffer: pushes text to the output buffer

  
  
