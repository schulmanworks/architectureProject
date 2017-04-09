module branch_add (
input[31:0] PCplus4, Boff,
output[31:0] BAout);
assign BAout = PCplus4 + Boff;
endmodule
