module ALU(A, B, out, opcode, clk);
	parameter N = 16;
	input clk;
	input [N-1:0] A, B;
	input [3:0] opcode;
	output reg [N-1:0] out;

	// uses onehot encodiung for simplicity
	parameter ADD = 4'b0001;
	parameter OR = 4'b0010;
	parameter AND = 4'b0100;
	parameter XOR = 4'b1000;
	parameter SL = 4'b1001;
	parameter SR = 4'b1010;
	parameter SEQ = 4'b1100;
	parameter SLT = 4'b1011;

	always @ (posedge clk)
		case (opcode)
			ADD: out <= A + B;
			OR: out <= A | B;
			AND: out <= A & B;
			XOR: out <= A ^ B;
			SL: out <= {A[N-2:1], 1'b0};
			SR: out <= {A[N-1], A[N-1:1]};
			SEQ: out <= A == B;
			SLT: out <= A < B;
			default: ; // if OP is not defined as parameter, do nothing
		endcase
endmodule
