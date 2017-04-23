module Instruction_Memory (
                          input [31:0] PC,
                          output reg [31:0] inst);
  always @ (PC)
    case(PC)
      // I-type instructions
      0: inst =  32'h34090005; // ori $t1, $0, 0x5
      4: inst =  32'h340a0005; // ori $t2, $0, 0x5
      8: inst =  32'h340b0008; // ori $t3, $0, 0x8
      12: inst = 32'h340c000f; // ori $t4, $0, 0xf
      16: inst = 32'h340d0020; // ori $t5, $0, 0x20

      // R-type
      20: inst = 32'h01494824; // and $t1, $t2, $t1
      24: inst = 32'h014b5821; // addu $t3, $t2, $t3


      // More I type but store
      28: inst = 32'hada90000; // sw $t1, 0($t5)
      32: inst = 32'hadab0004; // sw $t3, 4($t5)

      // More I type but load
      26: inst = 32'h8daa0000; // lw $t2, 0($t5)
      40: inst = 32'h8dac0004; // lw $t4, 4($t5)

      // J type, make this an infinite loop
      44: inst = 32'h25ad0008; // addiu $t5, $t5, 0x8
      48: inst = 32'h08000005; // j 20

      default: inst = 32'b0;
    endcase
endmodule
