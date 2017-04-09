
module test;
reg reset, clk;
initial begin
#5 reset = 1; clk = 1;
#10 clk = 0; reset = 0;
forever #10 clk = ~clk;
end
processor H0 (reset, clk);
endmodule
