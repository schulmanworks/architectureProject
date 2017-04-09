module thirtytwo_bit_mux(input select,
input[31:0] zero_value, one_value,
output reg [31:0] out_value);

always @ (select, zero_value, one_value)
begin
if (select ==0) out_value = zero_value;
if (select ==1) out_value = one_value;
end
endmodule
