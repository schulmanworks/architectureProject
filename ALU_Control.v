module ALU_Control(
input[3:0] ALUOp,
input[5:0] funct,
output reg jr,
output reg[3:0] ALUfunc);
always @ (ALUOp, funct, ALUfunc)
begin
jr = 0; // default
case (ALUOp)
4'b0010: // R—typ& instructions
begin
case (funct) // look at function code
6'b100001: ALUfunc = 4'b0010; // addu
6'b100011: ALUfunc = 4'b0110; // subu
6'b100100: ALUfunc = 4'b0000; // and
6'b100101: ALUfunc = 4'b0001; // or
6'b100110: ALUfunc = 4'b1001; // xor
6'b000000: ALUfunc = 4'b1010; // sll
6'b000011: ALUfunc = 4'b1011; // sra
6'b000010: ALUfunc = 4'b1100; // srl
6'b101010: ALUfunc = 4'b0111; // slt
6'b101011: ALUfunc = 4'b1110; // sltu
6'b001000: begin ALUfunc = 4'b0010; jr = 1; end // jr
endcase
end
4'b0011: ALUfunc = 4'b1101; //lui - sll 16
4'b0000: ALUfunc = 4'b0010; //addui, lw, sw - add
4'b0101: ALUfunc = 4'b0000; //andi - AND
4'b0110: ALUfunc = 4'b0001; //ori
4'b0111: ALUfunc = 4'b1001; //xori
4'b0100: ALUfunc = 4'b0111; //slti - SIGNED Slt
4'b0001: ALUfunc = 4'b0110; //beq, bne - subtract
4'b1001: ALUfunc = 4'b1110; //sltui - subtract & set bit
endcase
end
endmodule
