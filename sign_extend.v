module sign_extend(
input ui,
input[15:0] inst,
output reg [31:0] signex);

always @ (ui, inst)
begin
if (ui == 1) signex = {16'b0000000000000000, inst};
else begin
if (inst[15] == 1) signex={16'b1111111111111111, inst};
if (inst[15] == 0) signex={16'b0000000000000000, inst};
end
end
endmodule
