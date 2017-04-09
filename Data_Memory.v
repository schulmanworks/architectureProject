module Data_Memory (
                    input clk, MemRead, MemWrite,
                    input [31:0] ALUOut, reg2data,
                    output reg [31:0] memout);
  reg [31:0] data_mem[199:0];
  initial begin
    data_mem[8] = 32'b11110000111100001111000011110000;
    data_mem[10] = 32'b00000000000000000000000000000101;
  end
  always @ (ALUOut or MemRead)
    begin
    if (MemRead == 1) memout = data_mem[ALUOut];
  end
  always @(posedge clk)
    begin
    if (MemWrite ==1) data_mem[ALUOut] <= reg2data;
  end
endmodule
