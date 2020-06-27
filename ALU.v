module ALU(A, B, out, opcode, clk);
	parameter N = 16;
	input [N-1:0] A, B;
	input [3:0] opcode;
	output reg [N-1:0] out;

	// uses onehot encodiung for simplicity
	parameter ADD = 4'b0001;
	parameter OR = 4'b0010;
	parameter AND = 4'b0100;
	parameter XOR = 4'b1000;
	always @ (posedge clk)
		switch (control) begin
			ADD: out <= A + B;
			OR: out <= A | B;
			AND: out <= A & B;
			XOR: out <= A ^ B;
			SL: out <= {A[N-2:1], 0}
			SR: out <= {A[N-1],A[N-1:1]}
			SEQ: out <= A == B
			SLT: out <= A < B
			default: ; // if OP is not defined as parameter, do nothing
		end
endmodule
