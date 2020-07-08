module cpu(clk);
	parameter N = 16;
	input clk;
	reg [N-1:0] programCounter; // initial programCounter = 0x11111; // wherever instruction memory starts
	reg [N-1:0] registers [2:0]; // combining all the registers
	// registers[0] is the accumulator
	// registers[1] is the offset register
	// registers[2] is the stack pointer

	initial programCounter = 1;
	initial registers[0] = 0;
	initial registers[1] = 0;
	initial registers[2] = 0;

	parameter ADD = 4'd0;
	parameter XOR = 4'd1;
	parameter OR = 4'd2;
	parameter AND = 4'd3;
	parameter SEQ = 4'd4;
	parameter SLT = 4'd5;
	parameter SL = 4'd6;
	parameter SR = 4'd7;
	parameter IMM = 4'd8;
	parameter IFJUMP = 4'd9;
	parameter STORE = 4'd10;
	parameter MOVE = 4'd11;

	wire [N-1:0] instr; // write connects instruction memory with the cpu
	wire [3:0] opcode;
	wire [N-5:0] immediate;
	wire [1:0] moveArgA;
	wire [1:0] moveArgB;
	wire [N-1:0] result; // wire connects ALU output to memory
	wire [N-1:0] data; // wire carries data from the memory to the ALU

	reg dataMemWrite;
	initial dataMemWrite = 0;

	assign opcode = instr[N-1:N-4];
	assign immediate = instr[N-5:0];
	assign moveArgA = immediate[3:2];
	assign moveArgB = immediate[1:0];

	// seperate data and instruction memory blocks
	memory #(N, 1024) dataMem (immediate+registers[1], registers[0], data, dataMemWrite, clk); //address, in, out, write_en, clk);
	memory #(N, 1024) instMem (programCounter, 0, instr, 0, clk); // in address is kept at zero, so is write enable
	ALU #(N) a(registers[0], data, result, opcode, clk);

	always @ (posedge clk)
	begin
        $display("PC: %d, Instruction: %b Accumulator: %d", programCounter, instr ,registers[0]);
		if (programCounter == 0) begin
			$display("%d", data);
			$finish();
		end
		programCounter <= (opcode != IFJUMP) ? programCounter + 1 : immediate+registers[1];
		case (opcode)
			IMM: registers[0] <= {4'b0, immediate};
			STORE: dataMemWrite <= 1;
			MOVE: registers[moveArgA] <= registers[moveArgB];
			IFJUMP: registers[0] <= programCounter + 1;
			default: registers[0] <= result;
		endcase
        $display("PC: %d, Instruction: %b Accumulator: %d", programCounter, instr ,registers[0]);
	end
endmodule
