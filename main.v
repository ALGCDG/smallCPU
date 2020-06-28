module cpu(clk);
	parameter N = 16
	input clk;
	reg [N-1:0] accumulator
	reg [N-1:0] offset
	reg [N-1:0] stackPointer
	reg [N-1:0] programCounter
	parameter ADD
	parameter AND
	parameter XOR
	parameter OR
	parameter SL
	parameter SR
	parameter MOVE
	parameter IMM
	parameter IFJUMP
	parameter STORE
	wire opcode = instr[N-1:N-4];
	wire mem_d;
	wire wen = (opcode == STORE); // write enable for data memory
	wire result; // wire connects ALU output to memory
	wire [N-1:0] address = {4'b0, instr[N-5:0]}; // remove top 4 bits which specify opcode
	wire instr; // write connects instruction memory with the cpu
	ALU(accumulator, mem_d, result, opcode, clk);
	// seperate data and instruction memory blocks
	memory data(address+offset, accumulator, mem_d, wen, clk); //address, in, out, write_en, clk);
	memory inst(programCounter, 0, instr, 0, clk); // in address is kept at zero, so is write enable
	always @ (posedge clk)
		programCounter <= (opcode == IFJUMP) ? programCounter + 4 : address;
		accumulator <= result;
endmodule
