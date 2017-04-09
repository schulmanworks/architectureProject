module ALU (
input[31:0] reg1data, ALU2,
input[3:0] ALUfunc,
input[4:0] shamt,
output reg [31:0] ALUOut,
output reg zero, overflow);
reg[5:0] i;
always @ (*)
begin
case (ALUfunc)
4'b0010: ALUOut = reg1data + ALU2; // add, addui, lw, sw
4'b0110: ALUOut = reg1data - ALU2; // sub, bne,beq
4'b0000: ALUOut = reg1data & ALU2; // and, andi
4'b0001: ALUOut = reg1data | ALU2; // or , ori
4'b1001: ALUOut = reg1data ^ ALU2; // xor, xori
4'b1010: ALUOut = ALU2 << shamt; //   sll  slci
4'b1100: ALUOut = ALU2 >> shamt; //   srl
4'b0111: begin                   //   slt,— SIGNED #5

if (reg1data[31] == ALU2[31])
begin
if (reg1data < ALU2) ALUOut =1;
else ALUOut = 0;
end
else
begin
if (reg1data > ALU2) ALUOut =1;
else ALUOut = 0;
end
end

4'b1101: ALUOut = ALU2 << 16; // lui
4'b1110: begin // sltu, sltui - UNSIGNED #s
if (reg1data < ALU2) ALUOut = 1;
else ALUOut = 0;
end
4'b1011: begin // sra
ALUOut=ALU2;
for (i=0; i<=31; i=i+1)
begin
if (i < shamt) ALUOut = {ALUOut[31],ALUOut[31:1]};
end
end
default: ALUOut = 0;
endcase
if (ALUOut == 0) zero = 1; else zero = 0;
end
endmodule
