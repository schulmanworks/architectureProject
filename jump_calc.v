module jump_calc (input[3:0] PCbits,
input[25:0] instbits,
output [31:0] JumpAdrs);
assign JumpAdrs = {PCbits, instbits, 2'b00};
endmodule
