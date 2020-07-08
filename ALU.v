module ALU #(parameter N = 16) (A, B, out, opcode, clk);
	input clk;
	input [N-1:0] A, B;
	input [3:0] opcode;
	output reg [N-1:0] out;
	initial out = 0;

	parameter ADD = 4'd0;
	parameter XOR = 4'd1;
	parameter OR = 4'd2;
	parameter AND = 4'd3;
	parameter SEQ = 4'd4;
	parameter SLT = 4'd5;
	parameter SL = 4'd6;
	parameter SR = 4'd7;

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
