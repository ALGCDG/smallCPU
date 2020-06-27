module cpu();
	parameter N = 16
	reg [N-1:0] accumulator
	reg [N-1:0] offset
	reg [N-1:0] stackPointer
	reg [N-1:0] programCounter
	ALU();
	// seperate data and instruction memory blocks
	memory data();
	memory inst();
	register accumulator();
	register offset();
	register programCounter();
	register stackPointer();
endmodule
