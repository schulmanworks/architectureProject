module registers(input RegWrite, clk,
input[4:0] reg1ad, reg2ad, writead,
input[31:0] data_in, output wire [31:0] reg1data, reg2data);

reg[31:0] register[31:0];
initial begin register[0] = 0; end // $zero
assign regldata = register[reg1ad]; // read
assign reg2data = register[reg2ad]; // write
always @ (posedge clk)
begin
if (RegWrite== 1) register[writead] <= data_in;

end
endmodule
