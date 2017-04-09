module Branch_logic(
input Branch, bne, zero,
output Branchsel);
assign Branchsel = (Branch & zero) | (bne & ~zero);
endmodule
