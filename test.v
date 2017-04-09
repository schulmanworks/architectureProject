
module test;
reg reset, clk;
initial begin
#5 reset = 1; clk = 1;
#10 clk = 0; reset = 0;
forever #10 clk = ~clk;
end
processor H0 (reset, clk);
reg[31:0] register[31:0];
initial begin register[0] = 0; end // $zero
assign regldata = register[reg1ad]; // read
assign reg2data = register[reg2ad]; // write
endmodule
