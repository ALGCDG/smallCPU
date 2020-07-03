module cpu(clk);
	parameter N = 16;
	input clk;
	// reg [N-1:0] accumulator;
	// reg [N-1:0] offset;
	// reg [N-1:0] stackPointer;
	reg [N-1:0] programCounter;
	reg [N-1:0] registers [2:0]; // combining all the registers
	// registers[0] is the accumulator
	// parameter acc = registers[0];
	// parameter off = registers[1];
	// parameter sta = registers[2];
	// registers[1] is the offset register
	// registers[2] is the stack pointer
	// parameter ADD
	// parameter AND
	// parameter XOR
	// parameter OR
	// parameter SL
	// parameter SR
	parameter MOVE = 3;
	parameter IMM = 2;
	parameter IFJUMP = 1;
	// parameter STORE


	
	wire instr; // write connects instruction memory with the cpu
	wire opcode = instr[N-1:N-4];
	wire immediate = instr[N-5:0];
	wire moveArgA = immediate[3:2];
	wire moveArgB = immediate[1:0];
	wire mem_d;
	wire wen = (opcode == STORE); // write enable for data memory
	wire result; // wire connects ALU output to memory
	wire [N-1:0] address = {4'b0, instr[N-5:0]}; // remove top 4 bits which specify opcode


	// seperate data and instruction memory blocks
	memory dataMem(address+offset, accumulator, mem_d, wen, clk); //address, in, out, write_en, clk);
	memory instMem(programCounter, 0, instr, 0, clk); // in address is kept at zero, so is write enable
	ALU a(accumulator, mem_d, result, opcode, clk);

	always @ (posedge clk)
		programCounter <= (opcode == IFJUMP) ? programCounter + 4 : address;
		// accumulator <= result;
		// if (opcode == IMM) accumulator <= {4'b0, args};
		// if (opcode == MOVE) registers[moveArgA] <= registers[moveArgB];
endmodule
