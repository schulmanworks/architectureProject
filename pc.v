module PC (input clk, reset,
input[31:0] newPC,
output reg[31:0] PC);
always @(posedge clk or posedge reset)
begin

if (reset == 1)
PC<= 0; // or whereever the first instruction is
else
PC<= newPC;
end
endmodule
