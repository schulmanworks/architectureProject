module Instruction_Memory (
input [31:0] PC,
output reg [31:0] inst);
// reg [7:0] memory[199:0];
reg[31:0] memory[199:0];

initial begin
memory[0] =   32'b00111100000000011111111111111111; //1. lui $1, 1
memory[4] =   32'b00000000000000010001010000000011; //2. sra $2, $1, 16
memory[8] =   32'b00000000000000100001110000000000; //3. sll $3, $2, 16
memory[12] =  32'b00000000000000110010011000000010; //4. srl $4, $3, 24
memory[16] =  32'b00100100000001010000000000001111; //5. addui $5, $0, 17
memory[20] =  32'b00000000100001010011000000100011; //6.  subu $6, $4, $5
memory[24] =  32'b00000000110001000011100000100001; //7.  addu $7, $6, $4
memory[28] =  32'b00000000111001100100000000100100; //8.  and  $8, $7, $6
memory[32] =  32'b00000000111001100100100000100110; //9.  xor  $9, $7, $6
memory[36] =  32'b00000000001010010101000000101010; //10. slt  $10, $1, $9
memory[40] =  32'b00010101010000000000000000000010; //11. bne  $10, $0, xxx,
// next instruction is 52 = PC+4 + 8

memory[52] =  32'b00000000111010010101100000100101; //12  or  $11, $7, $9
memory[56] =  32'b00001100000000000000000000010010; //13  jal XXXX
// I'll jump C0 72 = 1001000
memory[72] =  32'b00110001011011000000000000001010; //14. andi $12, $11, 1010
memory[76] =  32'b00000011111000000000000000001000; //15. jr $31
// next instruction is 60 [56+4] from $31
memory[60] =  32'b00001000000000000000000000010100; //16. j zzzz
// next instruction is 80 = 1010000
memory[80] =  32'b10001101100011010000000000000000; //17. lw  $13, 0($12)
memory[84] =  32'b00111001101011100000000000001110; //18. xori $14, $13, 1110
memory[88] =  32'b00110101101011110000000000001110; //19. ori  $15, $13, 1110
memory[92] =  32'b00000000001010011000000000101011; //20. sltu $16, $1, $9
memory[96] =  32'b00101000001100010000000000000000; //21. slti $17, $1, 0
memory[100] = 32'b00101100001100100000000000000000; //22. sltui $18, s1, 0
memory[104] = 32'b00010010000100100000000000000010; //23. beq $16,$18, yyyy
// next instruction is +12 (4+8)
memory[116] = 32'b10101101100010110000000000000100; //24. sw $11, 4(12)
end


always @ (PC)
//inst = {memory[PC],memory[PC+1],memory[PC+2],memory[PC+3]);
inst = memory[PC];
endmodule
