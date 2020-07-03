module cpu(clk);
	parameter N = 16;
	input clk;
	// reg [N-1:0] accumulator;
	// reg [N-1:0] offset;
	// reg [N-1:0] stackPointer;
	reg [N-1:0] programCounter;
	// initial programCounter = 0x11111; // wherever instruction memory starts
	reg [N-1:0] registers [2:0]; // combining all the registers
	// registers[0] is the accumulator
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
	parameter STORE = 4;
	// parameter STORE


	
	// wire [N-1:0] instr; // write connects instruction memory with the cpu
	// wire [3:0] opcode = instr[N-1:N-4];
	// wire [N-5, 0] immediate = instr[N-5:0];
	// wire [1:0] moveArgA = immediate[3:2];
	// wire [1:0] moveArgB = immediate[1:0];
	// wire [N-1:0] result; // wire connects ALU output to memory
	// wire [N-1:0] address = {4'b0, instr[N-5:0]}; // remove top 4 bits which specify opcode

	wire [N-1:0] instr; // write connects instruction memory with the cpu
	wire [3:0] opcode;
	wire [N-5:0] immediate;
	wire [1:0] moveArgA;
	wire [1:0] moveArgB;
	wire [N-1:0] result; // wire connects ALU output to memory
	wire [N-1:0] address; // remove top 4 bits which specify opcode
	wire [N-1:0] data; // wire carries data from the memory to the ALU

	reg dataMemWrite;
	initial dataMemWrite = 0;

	assign opcode = instr[N-1:N-4];
	assign immediate = instr[N-5:0];
	assign moveArgA = immediate[3:2];
	assign moveArgB = immediate[1:0];
	assign address = {4'b0, instr[N-5:0]}; // remove top 4 bits which specify opcode

	// seperate data and instruction memory blocks
	memory dataMem(address+registers[1], registers[0], data, dataMemWrite, clk); //address, in, out, write_en, clk);
	memory instMem(programCounter, 0, instr, 0, clk); // in address is kept at zero, so is write enable
	ALU a(registers[0], data, result, opcode, clk);

	always @ (posedge clk)
	begin
		programCounter <= (opcode == IFJUMP) ? programCounter + 4 : address;
		registers[0] <= result;
		case (opcode)
			IMM: registers[0] <= {4'b0, immediate};
			STORE: dataMemWrite <= 1;
			MOVE: registers[moveArgA] <= registers[moveArgB];
			default: registers[0] <= result;
		endcase
	end
endmodule
