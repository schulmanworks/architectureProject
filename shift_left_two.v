module shift_left_two (
input[31:0] signex,
output[31:0] Boff);
assign Boff = signex << 2;
endmodule
