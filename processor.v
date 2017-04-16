module processor(
                input reset, clk);
  wire[3:0] ALUOp;
  wire[3:0] ALUfunc;
  wire[4:0] regad, Rmuxout, ra;
  wire[31:0] PC, PCplus4, newPC, inst, JumpAdrs,
  Mmuxout, regin, signex, Boff, ALU2,
  BAOut, BMuxout, JMuxout, memout,
  ALUOut, reg2data, reg1data;
  wire RegWrite;


  assign ra = 5'b11111;

  PC PCmod (clk, reset, newPC, PC);

  PC_adder PC_adder (PC, PCplus4);

  Instruction_Memory Inst_Mem (PC, inst);

  thirtytwo_bit_mux jal_mux (.select(jal), .zero_value(Mmuxout),
                            .one_value(PCplus4), .out_value(regin));

  five_bit_mux regdesc1(.select(RegDst), .zero_value(inst[20:16]),
                      .one_value(inst[15:11]), .out_value(Rmuxout));

  five_bit_mux regdest2(.select(jal), .zero_value(Rmuxout),
                        .one_value(ra), .out_value(regad));

  registers tegisters(RegWrite, clk, inst[25:21], inst[20:16], regad,
                      regin, reg1data, reg2data);

  jump_calc j_calc (PCplus4[31:28],inst[25:0],JumpAdrs);

  main_control main_control (inst[31:26], ALUOp, ALUSrc, RegDst,
                            RegWrite, MemWrite, MemtoReg, MemRead,
                            Branch, bne, Jump, jal, ui);

  sign_extend sign_ex (ui, inst[15:0], signex);

  shift_left_two SL2 (signex, Boff);

  branch_add Branch_add (PCplus4, Boff, BAOut);

  thirtytwo_bit_mux ALUSrcMux (.select(ALUSrc), .zero_value(reg2data),
                              .one_value(signex), .out_value(ALU2));

  ALU ALU (reg1data, ALU2, ALUfunc, inst[10:6], ALUOut, zero, overflow);

  ALU_Control ALU_cont (ALUOp, inst[5:0], jr, ALUfunc);

  Branch_logic BL (Branch, bne, zero, Branchsel);

  thirtytwo_bit_mux Bmux (.select(Branchsel), .zero_value(PCplus4),
                        .one_value(BAOut), .out_value(BMuxout));

  thirtytwo_bit_mux Jmux (.select(Jump), .zero_value(BMuxout),
                        .one_value(JumpAdrs), .out_value(JMuxout));

  thirtytwo_bit_mux JRmux (.select(jr), .zero_value(JMuxout),
                          .one_value(reg1data), .out_value(newPC));

  Data_Memory DM (clk, MemRead, MemWrite, ALUOut, reg2data, memout);

  thirtytwo_bit_mux  Mmux (.select(MemtoReg), .zero_value(ALUOut),
                            .one_value(memout), .out_value(Mmuxout));

endmodule
